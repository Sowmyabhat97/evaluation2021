//
//  SegmentHeaderCell.swift
//  Evaluation2021
//
//  Created by Sowmya on 13/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import UIKit

protocol HandlePageScrollProtocol{
    func scrollToTabPage(tabIndex: IndexPath)
}

class SegmentHeaderCell: UITableViewCell {
    @IBOutlet weak var segmentCollectionView: UICollectionView!
    
    
    var segmentTextFont: UIFont?
    var selectedTabIndex : Int = 0
    fileprivate let tabs = Tabs.allCases
    //Delegate : HandlePageScrollProtocol
    var handleScrollDelegate : HandlePageScrollProtocol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        segmentCollectionView.delegate = self
        segmentCollectionView.dataSource = self
        registerXibs()
    }
    
    
    func registerXibs(){
        segmentCollectionView.register(UINib(nibName: "TabsLabelCell", bundle: nil), forCellWithReuseIdentifier: "tabsLabelCellIdentifier")
        
    }
    
    
    
    func scrollToTab(indexPath : IndexPath) {
        segmentCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        SelecttheSelectedSegment(indexPath: indexPath)
    }
    
}


extension SegmentHeaderCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabsLabelCellIdentifier", for: indexPath) as! TabsLabelCell
        let tab = tabs[indexPath.row]
        if selectedTabIndex == indexPath.row {
            cell.setText(data: tab.getText(), isSelected: true)
        } else {
            cell.setText(data: tab.getText(), isSelected: false)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Delegating task to tableview to scroll the particular page
        handleScrollDelegate?.scrollToTabPage(tabIndex: indexPath)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        SelecttheSelectedSegment(indexPath: indexPath)
    }
    
    
    func SelecttheSelectedSegment(indexPath : IndexPath){
        
        selectedTabIndex = indexPath.row
        //changing the state
        self.segmentCollectionView.reloadData()
    }
}


extension SegmentHeaderCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 3), height: collectionView.frame.size.height)
    }
}
