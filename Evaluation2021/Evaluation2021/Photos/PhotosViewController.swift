//
//  PhotosViewController.swift
//  Evaluation2021
//
//  Created by Sowmya on 13/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photographerImageView: UIImageView!
    @IBOutlet weak var photographerNameLabel: UILabel!
    
    @IBOutlet weak var favoriteImageButton: UIButton!
    var id = 0
    var url = ""
    var liked = false
    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    @IBAction func zoomInTapped(_ sender: Any) {
    }
    @IBAction func zoomOutTapped(_ sender: Any) {
    }
    @IBAction func favoriteImageTapped(_ sender: Any) {
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func loadData() {
        guard let url = URL(string: url) else { return  }
        photoImageView.loadImage(url: url)
        photographerNameLabel.text = name
        favoriteImageButton.setImage(liked == true ? UIImage(named: "Path Copy 2") : UIImage(named: "Path"), for: .normal)
    }
}
