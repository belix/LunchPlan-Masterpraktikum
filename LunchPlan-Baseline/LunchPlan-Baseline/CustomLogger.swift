//
//  CustomLogger.swift
//  LunchPlan
//
//  Created by Felix Belau on 30.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit
import CocoaLumberjack


class CustomLogger: NSObject, DDLogger {
    
    static let sharedInstance = CustomLogger()
    
    var messages = [DDLogMessage]()
    let dateFormatter = NSDateFormatter()
    var logFormatter : DDLogFormatter = CustomLoggingFormatter()
    
    //MARK : DDLogger
    func logMessage(logMessage: DDLogMessage!) {
        self.messages.append(logMessage)
    }
    
    func clearCache(){
        self.messages.removeAll()
    }
    
}
