//
//  ViewController.swift
//  Evaluation2021
//
//  Created by Sowmya on 12/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import UIKit

protocol TabScrollToTop : class{
    
    func ChangeStateOfScrolling(enable: Bool)
    func ScrollToSelectedPage(indexpath: IndexPath, scrollState : Bool)
}


class ViewController: UIViewController {
    
    //Oulets
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var topHeightContraints: NSLayoutConstraint!
    
    var headerCell : SegmentHeaderCell?
    var scrollingEnableDelegate : TabScrollToTop?
    
    var selectedTabIndex = 0
    fileprivate var tabsAtTop : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        registerXibs()
        topHeightContraints.constant = 0
        logoImage.isHidden = true
    }
    
    func registerXibs() {
        tableView.register(UINib(nibName: "HomeScreenHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "homeScreenHeaderTableViewCell")
        tableView.register(UINib(nibName: "TabCollectionViewCell", bundle: nil), forCellReuseIdentifier: "tabCollectionViewCell")
        tableView.register(UINib(nibName: "SegmentHeaderCell", bundle: nil), forCellReuseIdentifier: "segmentTabHeaderIdentifier")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeScreenHeaderTableViewCell", for: indexPath) as! HomeScreenHeaderTableViewCell
            cell.homeScreenHeaderTableViewCellDelegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tabCollectionViewCell", for: indexPath) as! TabCollectionViewCell
            cell.handleSegmentSelectionDelegate = self
            cell.photosTableViewDelegate = self
            scrollingEnableDelegate = cell
            return cell
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return (UIScreen.main.bounds.size.height * 0.4)
        case 1:
            return tableView.frame.height - 60
        default:
            return 40
            
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 0
        case 1:
            return 60
        default:
            return 40
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerCell = tableView.dequeueReusableCell(withIdentifier: "segmentTabHeaderIdentifier") as? SegmentHeaderCell
        headerCell?.selectedTabIndex = selectedTabIndex
        headerCell?.handleScrollDelegate = self
        DispatchQueue.main.async {
            self.headerCell?.scrollToTab(indexPath: IndexPath(row: self.selectedTabIndex, section: 0))
        }
        return headerCell
    }
    
    // Function to check whether the second section header is on the top or not.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let visibleRows = self.tableView.indexPathsForVisibleRows {
            let visibleSections = visibleRows.map({$0.section})
            //TODO:- Pass the selected tab index
            if (visibleSections.first == 1){
                
                NotificationCenter.default.post(name: Notification.Name.NotificationName.tabScrolled, object: nil, userInfo: ["scroll" : true, "selectedTab" : selectedTabIndex+1])
                
                if !tabsAtTop {
                    print("Scroll up tabs")
                    
                    updateTopBarScrolledUp()
                }
                tabsAtTop = true
            }else{
                print("Scroll down tabs")
                updateTabBarScrolledDown()
                tabsAtTop = false
                NotificationCenter.default.post(name: Notification.Name.NotificationName.tabScrolled, object: nil, userInfo: ["scroll" : false, "selectedTab" : selectedTabIndex+1])
            }
        }
    }
    
}

fileprivate extension ViewController {
    func updateTopBarScrolledUp() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.topHeightContraints.constant = 56
            self.logoImage.isHidden = false
        }, completion: nil)
    }
    
    func updateTabBarScrolledDown() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.topHeightContraints.constant = 0
            self.logoImage.isHidden = true
        }, completion: nil)
    }
}

// MARK: HandlePageScrollProtocol
extension ViewController : HandlePageScrollProtocol{
    func scrollToTabPage(tabIndex: IndexPath) {
        selectedTabIndex = tabIndex.row
        scrollingEnableDelegate?.ScrollToSelectedPage(indexpath: tabIndex,scrollState : tabsAtTop)
    }
}

// MARK: HandleSegmentSelectionProtocol
extension ViewController : HandleSegmentSelectionProtocol {
    func ScrollSegmentTotab(index: IndexPath) {
        print("Selected page \(index.row)")
        selectedTabIndex = index.row
        headerCell?.scrollToTab(indexPath: index)
    }
}

// MARK: TabsManagerDelegate
extension ViewController : TabsManagerDelegate {
    func switchTab(_ tabIndex: Int) {
        let indexPath = IndexPath(row: tabIndex, section: 0)
        ScrollSegmentTotab(index: indexPath)
        scrollToTabPage(tabIndex: indexPath)
    }
}

// MARK: PhotosTableViewProtocol
extension ViewController : PhotosTableViewProtocol {
    func cellTapped(id: Int, imageUrl: String, name: String, liked: Bool, type: String) {
        if type == "Photo" {
            let photosViewController = PhotosViewController(nibName: "PhotosViewController", bundle: Bundle.main)
            photosViewController.modalPresentationStyle = .fullScreen
            photosViewController.id = id
            photosViewController.url = imageUrl
            photosViewController.name = name
            photosViewController.liked = liked
            self.present(photosViewController, animated: true, completion: nil)
        } else if type == "Video" {
            let videoViewController = VideosViewController(nibName: "VideosViewController", bundle: Bundle.main)
            videoViewController.modalPresentationStyle = .fullScreen
            videoViewController.id = id
            videoViewController.name = name
            self.present(videoViewController, animated: true, completion: nil)
        }
    }
}
// MARK: HomeScreenHeaderTableViewCellProtocol
extension ViewController: HomeScreenHeaderTableViewCellProtocol {
    func didSearch(query: String) {
        NotificationCenter.default.post(name: Notification.Name.NotificationName.searchText, object: nil, userInfo: ["selectedOption" : query])
    }
    
    
}
