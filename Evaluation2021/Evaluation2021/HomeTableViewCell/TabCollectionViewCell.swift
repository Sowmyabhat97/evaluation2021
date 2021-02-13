//
//  TabCollectionViewCell.swift
//  Evaluation2021
//
//  Created by Sowmya on 13/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import UIKit

enum Tabs : Int {
    // Re-arranged tabs according to unique ids
    case photos = 1
    case videos
    case favorites
    
    
    static let allCases :[Tabs] = [photos,videos,favorites]
    func getText() -> String {
        switch self {
        case .photos : return "Photos"
        case .videos : return "Videos"
        case .favorites : return "Favorites"
        }
    }
    
}

protocol TabDelegate: class {
    func handleScroll(notification : Notification)
}
protocol MaintainCollectionViewState: class {
    func ChangeTheScrollingState(enable: Bool)
}
protocol HandleSegmentSelectionProtocol : class {
    func ScrollSegmentTotab(index: IndexPath)
}


class TabCollectionViewCell: UITableViewCell, TabScrollToTop {
    
    @IBOutlet weak var tabCollectionView: UICollectionView!
    weak var collectionViewStateDelegate : MaintainCollectionViewState?
    weak var handleSegmentSelectionDelegate :HandleSegmentSelectionProtocol?
    weak var photosTableViewDelegate : PhotosTableViewProtocol?
    
    //Views references for all the tabs
    var photosTableView : PhotosTableView?
    var videosTableView : VideosTableView?
    var favoritesTableView : FavoritesTableView?
    
    var currentSelectedIndex: Int = -1
    var segmentAtTopFlag : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        registerXib()
    }
    
    func registerXib() {
        tabCollectionView.register(UINib(nibName: "TabScreenCell", bundle: nil), forCellWithReuseIdentifier: "tabScreenCell")
    }
    
}

extension TabCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabScreenCell", for: indexPath) as? TabScreenCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? TabScreenCell else { return }
        let tabType = Tabs.allCases[indexPath.row]
        if(currentSelectedIndex != indexPath.row){
            currentSelectedIndex = indexPath.row
            cell.subviews.forEach({$0.removeFromSuperview()})
            
        }
        switch tabType{
        case .photos:
            photosTableView = PhotosTableView(frame: collectionView.frame, style: .plain)
            photosTableView?.isScrollEnabled = segmentAtTopFlag
            photosTableView?.tag = indexPath.row
            photosTableView?.photosTableViewDelegate = photosTableViewDelegate
            cell.addSubview(photosTableView!)
            
        case .videos:
            videosTableView = VideosTableView(frame: collectionView.frame, style: .plain)
            videosTableView?.isScrollEnabled = segmentAtTopFlag
            videosTableView?.photosTableViewDelegate = photosTableViewDelegate
            videosTableView?.tag = indexPath.row
            cell.addSubview(videosTableView!)
            
        case .favorites:
            favoritesTableView = FavoritesTableView(frame: collectionView.frame, style: .plain)
            favoritesTableView?.isScrollEnabled = segmentAtTopFlag
            favoritesTableView?.tag = indexPath.row
            cell.addSubview(favoritesTableView!)
            
        }
    }
}
extension TabCollectionViewCell {
    //Delegating Job to collection all cell.
    func ChangeStateOfScrolling(enable: Bool) {
        collectionViewStateDelegate?.ChangeTheScrollingState(enable: enable)
    }
    
    func ScrollToSelectedPage(indexpath : IndexPath, scrollState : Bool) {
        
        //If already the segment is at top , enable the scroll of all section.
        if(scrollState == true){
            segmentAtTopFlag = true
        }else{
            segmentAtTopFlag = false
        }
        
        tabCollectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
    }
}

extension TabCollectionViewCell {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth : CGFloat = tabCollectionView.frame.size.width;
        let currentPage : CGFloat = tabCollectionView.contentOffset.x / pageWidth;
        let num = Int(ceil(currentPage))
        
        handleSegmentSelectionDelegate?.ScrollSegmentTotab(index: IndexPath(row: num, section: 0))
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
}

extension TabCollectionViewCell : UICollectionViewDelegateFlowLayout {
    
    //Maintaing the size of collection cell.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        
    }
}
