//
//  MenuCustomizationViewController.swift
//  LunchPlan
//
//  Created by Felix Belau on 24.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit
import CocoaLumberjack

class MenuCustomizationViewController: UIViewController {

    @IBOutlet weak var closeButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Dönerbox"
        DDLogInfo("Menu Customization Screen - Appear")
    }

    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    @IBAction func switch1Pressed(sender: AnyObject) {
        DDLogWarn("Specific Value(1) switched")
    }
    
    @IBAction func switch2Pressed(sender: AnyObject) {
        DDLogWarn("Specific Value(2) switched")
    }
    
    @IBAction func valueSelected(sender: AnyObject) {
        DDLogWarn("Specific Value(3) selected")
    }
    
    
    @IBAction func orderButtonPressed(sender: AnyObject) {
        DDLogWarn("Menu ordered")
        let alertController = UIAlertController(title: "Bestellung erfolgreich", message:
            "Du kannst deine Dönerbox um 12:45 Uhr abholen.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
