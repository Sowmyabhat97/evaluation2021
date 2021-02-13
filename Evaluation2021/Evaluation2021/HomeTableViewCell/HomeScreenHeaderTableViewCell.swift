//
//  HomeScreenHeaderTableViewCell.swift
//  Evaluation2021
//
//  Created by Sowmya on 13/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import UIKit

protocol HomeScreenHeaderTableViewCellProtocol: class {
    func didSearch(query: String)
}
class HomeScreenHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var searchtextField: UITextField!
    @IBOutlet weak var searchOuterView: UIView!
    
    weak var homeScreenHeaderTableViewCellDelegate : HomeScreenHeaderTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        searchtextField.delegate = self
        searchOuterView.layer.cornerRadius = 5
    }
    
}

extension HomeScreenHeaderTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let query = searchtextField.text else { return false }
        homeScreenHeaderTableViewCellDelegate?.didSearch(query: query)
        
        return true
        
    }
}

