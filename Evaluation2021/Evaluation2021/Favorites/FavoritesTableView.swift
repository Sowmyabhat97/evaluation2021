//
//  FavoritesTableView.swift
//  Evaluation2021
//
//  Created by Sowmya on 13/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//
import UIKit

class FavoritesTableView: UITableView, TabDelegate {
    
    var dictArray1: [Dictionary<String, String>]?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initiateView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initiateView()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        initiateView()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func initiateView() {
        dataSource = self
        delegate = self
        isScrollEnabled = false
        backgroundColor = UIColor.white
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 100
        registerNotification()
        registerNib()
        
    }
    func registerNib() {
        
    }
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleScroll(notification:)), name: Notification.Name.NotificationName.tabScrolled, object: nil)
    }
    @objc func handleScroll(notification: Notification) {
        if let info = notification.userInfo as? [String : Any], let scroll = info["scroll"] as? Bool, let selectedTab = info["selectedTab"] as? Int {
            
            if selectedTab == Tabs.favorites.rawValue {
                
                isScrollEnabled = scroll
            }
        }
    }
}

extension FavoritesTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictArray1?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
