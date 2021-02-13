//
//  TabsLabelCell.swift
//  Evaluation2021
//
//  Created by Sowmya on 13/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import UIKit

class TabsLabelCell: UICollectionViewCell {
    
    @IBOutlet weak var tabLabel: UILabel!
    @IBOutlet weak var selectedSegment: UIView!
    
    static var tabSelectedFont = UIFont.systemFont(ofSize: 12, weight: .bold)
    static var tabNormalFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    func setText(data: String, isSelected : Bool){
        tabLabel.text = data
        if(isSelected){
            selectedSegment.isHidden = false
            tabLabel.font = TabsLabelCell.tabSelectedFont
        }else{
            selectedSegment.isHidden = true
            tabLabel.font = TabsLabelCell.tabNormalFont
        }
        
    }
    
    func getFont() -> UIFont? {
        return tabLabel.font
    }
    
    
}
