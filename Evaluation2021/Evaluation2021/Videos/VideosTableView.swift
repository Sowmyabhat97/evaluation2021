//
//  VideosTableView.swift
//  Evaluation2021
//
//  Created by Sowmya on 13/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import UIKit

class VideosTableView: UITableView, TabDelegate {
    var query = "Animal"
    var data: VideosData?
    var videoData: [Video]?
    weak var photosTableViewDelegate : PhotosTableViewProtocol?
    
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
        fetchData()
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleScroll(notification:)), name: Notification.Name.NotificationName.tabScrolled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(searchedText(notification:)), name: Notification.Name.NotificationName.searchText, object: nil)
    }
    
    @objc func searchedText(notification: Notification) {
        if let info = notification.userInfo?.values.first {
            
            query = info as! String
            fetchData()
        }
    }
    
    func fetchData() {
        let networkManager = NetworkManager()
        let url = "https://api.pexels.com/videos/search?query=" +  query + "&per_page=10"
        networkManager.getData(url: url, model: VideosData.self){ [weak self] (result) in
            switch result {
            case .success(let response):
                self?.data = response
                self?.videoData = response.videos
                self?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func registerNib() {
        register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: "photosTableViewCell")
    }
    
    @objc func handleScroll(notification: Notification) {
        if let info = notification.userInfo as? [String : Any], let scroll = info["scroll"] as? Bool, let selectedTab = info["selectedTab"] as? Int {
            
            if selectedTab == Tabs.videos.rawValue {
                
                isScrollEnabled = scroll
            }
        }
    }
}

extension VideosTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photosTableViewCell", for: indexPath) as! PhotosTableViewCell
        if let data = videoData?[indexPath.row]{
            cell.configureVideoCell(data: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = videoData?[indexPath.row]{
            photosTableViewDelegate?.cellTapped(id: item.id ?? 0, imageUrl: item.url ?? "", name: item.user?.name ?? "", liked: false, type: "Video")
        }
    }
}
