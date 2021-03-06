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
    static let kaffee = MenuItem(menuName: "Kaffee", menuPrice: "0,65 €", menuImageString: "kaffee")
    static let breze = MenuItem(menuName: "Breze", menuPrice: "1,59 €", menuImageString: "breze")
    
    static let gourmetImbiss = Shop(shopName: "Gourmet Imbiss", distance: "200 m", waitingTime: 6, menuItems:[dönerBox, currywurst,pommes])
    static let onkelLou = Shop(shopName: "Onkel Lou", distance: "300 m", waitingTime: 9, menuItems:[dönerBox, currywurst,pommes])
    static let bäckerei = Shop(shopName: "Bäckerei", distance: "800 m", waitingTime: 15, menuItems:[breze,kaffee])
    static let mensa = Shop(shopName: "Mensa", distance: "1340 m", waitingTime: 2, menuItems:[dönerBox, currywurst,pommes])
    
    static func shops()->[Shop]{
        return [mensa,gourmetImbiss,onkelLou,bäckerei]
    }
    
    static func favoriteMenus()->[MenuItem]{
        return [dönerBox,currywurst]
    }
    
}
