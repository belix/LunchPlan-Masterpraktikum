//
//  MenuItem.swift
//  LunchPlan
//
//  Created by Felix Belau on 24.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit

class MenuItem: NSObject {

    var menuName: String
    var menuPrice: String
    var menuImageString: String
    
    init(menuName: String, menuPrice: String, menuImageString: String){
        
        self.menuName = menuName
        self.menuPrice = menuPrice
        self.menuImageString = menuImageString
        super.init()
    }
}
