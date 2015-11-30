//
//  StartscreenViewController.swift
//  LunchPlan
//
//  Created by Felix Belau on 24.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ShopTableViewCell"

class StartscreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let shops =    [Shop(shopName: "Gourmet Imbiss", distance: "500 m", waitingTime: 12, menuItems:[MenuItem(menuName: "Dönerbox", menuPrice: "2,99 €", menuImageString: "clock"),
                                                                                                    MenuItem(menuName: "Currywurst", menuPrice: "1,99 €", menuImageString: "clock"),
                                                                                                    MenuItem(menuName: "Pommes", menuPrice: "0,99 €", menuImageString: "clock")]),
        Shop(shopName: "Onkel Lou", distance: "450 m", waitingTime: 9, menuItems:                  [MenuItem(menuName: "Dönerbox", menuPrice: "2,99 €", menuImageString: "clock"),
                                                                                                    MenuItem(menuName: "Dönerbox", menuPrice: "2,99 €", menuImageString: "clock"),
                                                                                                    MenuItem(menuName: "Dönerbox", menuPrice: "2,99 €", menuImageString: "clock")]),
        Shop(shopName: "Bäckerei", distance: "300 m", waitingTime: 7, menuItems:                   [MenuItem(menuName: "Dönerbox", menuPrice: "2,99 €", menuImageString: "clock"),
                                                                                                    MenuItem(menuName: "Dönerbox", menuPrice: "2,99 €", menuImageString: "clock"),
                                                                                                    MenuItem(menuName: "Dönerbox", menuPrice: "2,99 €", menuImageString: "clock")]),
        Shop(shopName: "Mensa", distance: "1340 m", waitingTime: 2, menuItems:                     [MenuItem(menuName: "Dönerbox", menuPrice: "2,99 €", menuImageString: "clock"),
                                                                                                    MenuItem(menuName: "Dönerbox", menuPrice: "2,99 €", menuImageString: "clock"),
                                                                                                    MenuItem(menuName: "Dönerbox", menuPrice: "2,99 €", menuImageString: "clock")]),]

    var selectedShop : Shop?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shop Auswahl"
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigationController = self.navigationController
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if appDelegate.enteredViaShortCut{
            self.performSegueWithIdentifier("showMenuCustomizationViaShortcutSegue", sender: nil)
        }
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.tableView.reloadData()
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
        cell.time = shop.waitingTime
        cell.distanceLabel.text = shop.distance
        
        return cell
    }
    
    //MARK: TableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedShop = shops[indexPath.row]
        self.performSegueWithIdentifier("showMenuSegue", sender: nil)
    }

    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .Normal, title: "Statistiken") { action, index in
            self.performSegueWithIdentifier("showStatisticsSegue", sender: nil)
        }
        more.backgroundColor = UIColor.lightGrayColor()
        
        return [more]
    }
    
    //MARK: Shaking
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            print("shake")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("FavoritesNavigationController")
            self.navigationController?.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMenuSegue"{
            let destinationViewController = segue.destinationViewController as! MenuViewController
            destinationViewController.shop = self.selectedShop
        }
    }
}
