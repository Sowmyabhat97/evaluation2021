//
//  TabsManager.swift
//  Evaluation2021
//
//  Created by Sowmya on 13/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//


import Foundation

protocol TabsManagerDelegate where Self: ViewController {
    func switchTab(_ tabIndex : Int)
}

class TabsManager : NSObject {
    
    private override init() {}
    
    static let shared = TabsManager()
    
    weak var delegate : TabsManagerDelegate?
    
    func gotoTab(_ tab : Tabs) {
        
        var tabIndex = 1
        
        tabIndex = tab.rawValue - 1// Since the tab enum begins with 1 and array index starts from 0
        delegate?.switchTab(tabIndex)
    }
}
