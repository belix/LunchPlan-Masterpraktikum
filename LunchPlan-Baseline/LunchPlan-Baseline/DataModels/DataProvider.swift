//
//  DataProvider.swift
//  LunchPlan
//
//  Created by Felix Belau on 30.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit

class DataProvider: NSObject {
    
    static let dönerBox = MenuItem(menuName: "Dönerbox", menuPrice: "2,99 €", menuImageString: "doenerbox")
    static let currywurst = MenuItem(menuName: "Currywurst", menuPrice: "1,99 €", menuImageString: "currywurst")
    static let pommes = MenuItem(menuName: "Pommes", menuPrice: "0,99 €", menuImageString: "pommes")
    
    static let gourmetImbiss = Shop(shopName: "Gourmet Imbiss", distance: "500 m", waitingTime: 12, menuItems:[dönerBox, currywurst,pommes])
    static let onkelLou = Shop(shopName: "Onkel Lou", distance: "450 m", waitingTime: 9, menuItems:[dönerBox, currywurst,pommes])
    static let bäckerei = Shop(shopName: "Bäckerei", distance: "300 m", waitingTime: 7, menuItems:[dönerBox, currywurst,pommes])
    static let mensa = Shop(shopName: "Mensa", distance: "1340 m", waitingTime: 2, menuItems:[dönerBox, currywurst,pommes])
    
    static func shops()->[Shop]{
        return [gourmetImbiss,onkelLou,bäckerei,mensa]
    }
    
    static func favoriteMenus()->[MenuItem]{
        return [dönerBox,currywurst,pommes]
    }
    
}
