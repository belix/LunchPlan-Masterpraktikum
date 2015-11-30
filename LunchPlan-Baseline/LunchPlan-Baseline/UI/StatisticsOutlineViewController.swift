//
//  StatisticsOutlineViewController.swift
//  LunchPlan-Baseline
//
//  Created by Felix Belau on 30.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit
import CocoaLumberjack

private let reuseIdentifier = "ShopStatisticTableViewCell"

class StatisticsOutlineViewController: UIViewController, UITabBarControllerDelegate {
    
    let shops = DataProvider.shops()
    var selectedShop : Shop?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Statistik Überlick"
        self.tabBarController?.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        DDLogInfo("Statistics Outline Screen - Appear")
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        DDLogWarn("Tab selected: Statistic Outlin")
    }
    
    
    //MARK: TableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shops.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ShopTableViewCell
        
        // Configure the cell...
        let shop = shops[indexPath.row]
        cell.shopNameLabel.text = shop.shopName
        cell.timeLabel.text = "\(shop.waitingTime) m"
        return cell
    }
    
    
    //MARK: TableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedShop = shops[indexPath.row]
        self.performSegueWithIdentifier("showStatisticSegue", sender: nil)
        DDLogInfo("Shop-Statistics selected: \(self.selectedShop!.shopName)")
    }
}
