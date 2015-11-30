//
//  AdminPanelViewController.swift
//  LunchPlan
//
//  Created by Felix Belau on 29.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit

class AdminPanelViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var notificationTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //Internal: Notification
    func fireNotification(){
        let notification = UILocalNotification()
        notification.alertTitle = "Schlangen-Alarm"
        notification.alertBody = "Die Wartezeit beim Gourmet-Imbiss ist im Moment unter 5 Minuten"
        notification.alertAction = "open"
        notification.fireDate = NSDate(timeIntervalSinceNow: NSTimeInterval(notificationTextField.text!)!)
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    //MARK: IBActions
    @IBAction func closeButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func fireNotificationButtonPressed(sender: AnyObject) {
        fireNotification()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
