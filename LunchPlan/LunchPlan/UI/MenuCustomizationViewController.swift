//
//  MenuCustomizationViewController.swift
//  LunchPlan
//
//  Created by Felix Belau on 24.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit

class MenuCustomizationViewController: UIViewController {

    @IBOutlet weak var closeButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Dönerbox"
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if !appDelegate.enteredViaShortCut{
            self.closeButton.title = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.enteredViaShortCut = false
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
