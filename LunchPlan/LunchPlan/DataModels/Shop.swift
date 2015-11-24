//
//  Shop.swift
//  LunchPlan
//
//  Created by Felix Belau on 24.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit

class Shop: NSObject {

    var shopName : String
    var distance : String
    var waitingTime : Int
    var menuItems : [MenuItem]
    
    init(shopName: String, distance: String, waitingTime: Int, menuItems: [MenuItem]) {
        
        self.shopName = shopName
        self.distance = distance
        self.waitingTime = waitingTime
        self.menuItems = menuItems
        super.init()
    }
}
