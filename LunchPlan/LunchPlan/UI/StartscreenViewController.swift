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

extension UINavigationController {
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return visibleViewController!.supportedInterfaceOrientations()
    }
    public override func shouldAutorotate() -> Bool {
        return visibleViewController!.shouldAutorotate()
    }
}

extension UIAlertController {
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    public override func shouldAutorotate() -> Bool {
        return false
    }
}


class StartscreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let shops = DataProvider.shops()
    var selectedShop : Shop?
    var cells = [ShopTableViewCell]()
    
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
        if fromInterfaceOrientation == .LandscapeLeft || fromInterfaceOrientation == .LandscapeRight{
            DDLogInfo("Rotate from Heatmap to ListView")
            self.title = "Shop Auswahl"
        }
        else{
            DDLogInfo("Rotate from ListView to Heatmap")
            self.title = "Heat Map"
        }
    }

    override func viewDidLayoutSubviews() {
        for cell in cells{
            let time = cell.time
            cell.time = time
        }
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
        cells.append(cell)
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
    
    //MARK: Shaking
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            DDLogInfo("Shaked to Favorites")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("FavoritesNavigationController")
            self.navigationController?.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMenuSegue"{
            let destinationViewController = segue.destinationViewController as! MenuViewController
            destinationViewController.shop = self.selectedShop
        }
    }
}
