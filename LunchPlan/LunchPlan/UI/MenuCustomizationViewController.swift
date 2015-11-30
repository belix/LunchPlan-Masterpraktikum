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
        DDLogInfo("Menu Customization Screen - Appear")
        self.title = "Dönerbox"
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if !appDelegate.enteredViaShortCut{
            self.closeButton.title = ""
        }
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
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.enteredViaShortCut = false
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func orderButtonPressed(sender: AnyObject) {
        DDLogWarn("Menu ordered")
        let alertController = UIAlertController(title: "Bestellung erfolgreich", message:
            "Du kannst deine Dönerbox um 12:45 Uhr abholen.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: Shaking
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            DDLogError("Shaked to Favorites")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("FavoritesNavigationController")
            self.navigationController?.presentViewController(vc, animated: true, completion: nil)
        }
    }
}
