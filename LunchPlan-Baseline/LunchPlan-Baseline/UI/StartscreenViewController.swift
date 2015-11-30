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

class StartscreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate {
    
    let shops = DataProvider.shops()
    var selectedShop : Shop?
    var cells = [ShopTableViewCell]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shop Auswahl"
        self.tabBarController?.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if appDelegate.newTask{
            appDelegate.newTask = false
            let alertController = UIAlertController(title: "Neue Aufgabe", message: "Lasse dir die Aufgabe erklären und drücke OK falls du bereit bist", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                DDLogInfo("--------- Start Logging ---------")
                DDLogInfo("Shop Selection Screen - Appear")
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else{
            DDLogInfo("Shop Selection Screen - Appear")
        }
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        DDLogWarn("Tab selected: Shop Selection")
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
        DDLogWarn("Shop selected: \(self.selectedShop!.shopName)")
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMenuSegue"{
            let destinationViewController = segue.destinationViewController as! MenuViewController
            destinationViewController.shop = self.selectedShop
        }
    }
}
