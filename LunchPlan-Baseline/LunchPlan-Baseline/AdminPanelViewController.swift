//
//  AdminPanelViewController.swift
//  LunchPlan
//
//  Created by Felix Belau on 29.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit
import CocoaLumberjack
import MessageUI

extension Double {
    func string(fractionDigits:Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.stringFromNumber(self) ?? "\(self)"
    }
}

private let reuseIdentifier = "LoggingTableViewCell"
class AdminPanelViewController: UIViewController, UITextFieldDelegate,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var loggingTableView: UITableView!
    @IBOutlet weak var notificationTextField: UITextField!
    
    var messages = CustomLogger.sharedInstance.messages
    let dateFormatter = NSDateFormatter()
    var startTime: NSDate?

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.messages.count != 0{
            startTime = self.messages[0].timestamp
        }
        else{
            startTime = NSDate()
        }
        self.dateFormatter.dateFormat = "HH:mm:ss:SSS"
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
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
    @IBAction func clearLoggingCacheButtonPressed(sender: AnyObject) {
        if let customLogger = DDLog.allLoggers()[1] as? CustomLogger{
            customLogger.clearCache()
            self.messages = customLogger.messages
            self.loggingTableView.reloadData()
        }
    }
    
    @IBAction func sendLogsViaEmailButtonPressed(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    @IBAction func startTaskButtonPressed(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.newTask = true
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: TableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    //MARK: Customization
    func textOfMessage(index: Int) -> String{
        let message = self.messages[index]
        let timestamp = message.timestamp.timeIntervalSinceDate(startTime!) as Double
        return "\(self.dateFormatter.stringFromDate(message.timestamp)) --- \(timestamp.string(0)):  \(message.message)"
    }
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath){
        let message = self.messages[indexPath.row]
        switch message.flag
        {
        case DDLogFlag.Error:
            cell.textLabel?.textColor = UIColor.redColor()
        case DDLogFlag.Warning:
            cell.textLabel?.textColor = UIColor.orangeColor()
        case DDLogFlag.Debug:
            cell.textLabel?.textColor = UIColor.greenColor()
        case DDLogFlag.Verbose:
            cell.textLabel?.textColor = UIColor.blueColor()
        default:
            cell.textLabel?.textColor = UIColor.blackColor()
        }
        cell.textLabel!.text = textOfMessage(indexPath.row)
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = UIColor.clearColor()
        
    }
    
    //MARK: Email
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
    mailComposerVC.setToRecipients(["felix.belau@me.com","max.wuestehube@gmail.com"])
        mailComposerVC.setSubject("Loggin Report LunchPlan")
        

        var emailBody = "<p style=\"font-weight: bold;\">Proband: </p>"
        for message in self.messages{
            
            let messageStringRepresentation = textOfMessage(self.messages.indexOf(message)!)
            let colorString = htmlColorStringForFlag(message.flag)
            let htmlString = "<p style=\"color: \(colorString)\">\(messageStringRepresentation)</p>"
            emailBody += htmlString
        }
        mailComposerVC.setMessageBody(emailBody, isHTML: true)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        
        let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: InternalHelper
    func htmlColorStringForFlag(flag :DDLogFlag) -> String{
        var colorString = ""
        switch flag
        {
        case DDLogFlag.Error:
            colorString = "red"
        case DDLogFlag.Warning:
            colorString = "orange"
        case DDLogFlag.Debug:
            colorString = "green"
        case DDLogFlag.Verbose:
            colorString = "blue"
        default:
            colorString = "black"
        }
        return colorString
    }
}
