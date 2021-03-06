//
//  MenuViewController.swift
//  LunchPlan
//
//  Created by Felix Belau on 24.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit
import CocoaLumberjack

private let reuseIdentifier = "MenuTableViewCell"

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var shop : Shop?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        DDLogInfo("Menu Selection Screen - Appear")
    }
    
    //MARK: TableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shop!.menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MenuTableViewCell
        
        let menuItem = shop!.menuItems[indexPath.row]
        cell.menuLabel.text = menuItem.menuName
        cell.menuImageView.image = UIImage(named: menuItem.menuImageString)
        cell.priceLabel.text = menuItem.menuPrice
        return cell
    }
    
    //MARK: TableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let menuItem = shop!.menuItems[indexPath.row]
        DDLogWarn("Menu selected: \(menuItem.menuName)")
        self.performSegueWithIdentifier("showMenuCustomizationSegue", sender: nil)
    }
}
