//
//  StartscreenViewController.swift
//  LunchPlan
//
//  Created by Felix Belau on 24.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit
import CocoaLumberjack

private let reuseIdentifier = "ShopTableViewCell"

class StartscreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let shops = DataProvider.shops()
    var selectedShop : Shop?
    var cells = [ShopTableViewCell]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shop Auswahl"
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
        cell.distanceLabel.text = shop.distance
        return cell
    }
    
    //MARK: TableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedShop = shops[indexPath.row]
        self.performSegueWithIdentifier("showMenuSegue", sender: nil)
        DDLogInfo("Shop selected: \(self.selectedShop!.shopName)")
    }

    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .Normal, title: "Statistiken") { action, index in
            self.performSegueWithIdentifier("showStatisticsSegue", sender: nil)
            DDLogInfo("Statistic button pressed")
        }
        more.backgroundColor = UIColor.lightGrayColor()
        DDLogInfo("Swiped cell to see statistics")

        return [more]
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMenuSegue"{
            let destinationViewController = segue.destinationViewController as! MenuViewController
            destinationViewController.shop = self.selectedShop
        }
    }
}
