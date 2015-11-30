//
//  CustomLoggingFormatter.swift
//  LunchPlan
//
//  Created by Felix Belau on 30.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit
import CocoaLumberjack

class CustomLoggingFormatter: NSObject, DDLogFormatter {

    let dateFormatter = NSDateFormatter()
    
    override init() {
        super.init()
        self.dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"
    }
    
    func formatLogMessage(logMessage: DDLogMessage!) -> String! {
        let dateString = self.dateFormatter.stringFromDate(logMessage.timestamp)
        return "\(dateString): \(logMessage.message)"
    }
}
