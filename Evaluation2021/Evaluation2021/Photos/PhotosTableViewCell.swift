//
//  PhotosTableViewCell.swift
//  Evaluation2021
//
//  Created by Sowmya on 13/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photographersPhotoImageView: UIImageView!
    @IBOutlet weak var PhtographerNameLabel: UILabel!
    @IBOutlet weak var favoriteImageButton: UIButton!
    @IBOutlet weak var playImage: UIImageView!
    var isLiked = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        if isLiked == true {
            favoriteImageButton.setImage(UIImage(named: "Path Copy 2"), for: .normal)
            isLiked = false
        } else {
            favoriteImageButton.setImage(UIImage(named: "Path"), for: .normal)
            isLiked = true
        }
    }
    
    func configurePhotoCell(data : PhotoData) {
        guard let url = URL(string: data.src?.large ?? "") else { return  }
        
        photoImageView.loadImage(url: url)
        PhtographerNameLabel.text = data.photographer
        favoriteImageButton.setImage(data.liked == true ? UIImage(named: "Path Copy 2") : UIImage(named: "Path"), for: .normal)
    }
    func configureVideoCell (data : Video) {
        guard let url = URL(string: data.image ?? "") else { return  }
        photoImageView.loadImage(url: url)
        PhtographerNameLabel.text = data.user?.name
        //        favoriteImageButton.setImage(data.liked == true ? UIImage(named: "Path Copy 2") : UIImage(named: "Path"), for: .normal)
    }
}
