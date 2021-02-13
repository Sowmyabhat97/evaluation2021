//
//  VideosViewController.swift
//  Evaluation2021
//
//  Created by Sowmya on 13/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class VideosViewController: UIViewController{
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likedButton: UIButton!
    @IBAction func likedImageTapped(_ sender: UIButton) {
    }
    var videoURL = ""
    var name = ""
    var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        URLSessionConfiguration.default.multipathServiceType = .handover
        nameLabel.text = name
        fetchdata()
    }
    
    func fetchdata() {
        let networkManager = NetworkManager()
        let url = "https://api.pexels.com/videos/videos/" + String(id)
        networkManager.getData(url: url, model: VideosData.self){ [weak self] (result) in
            switch result {
            case .success(let response):
                self?.videoURL = response.url ?? ""
                
                self?.playVideo()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func playVideo() {
        guard let url = URL(string: videoURL) else { return  }
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.videoView.bounds
        self.videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
