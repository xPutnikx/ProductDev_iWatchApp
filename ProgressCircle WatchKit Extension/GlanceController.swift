//
//  GlanceController.swift
//  ProgressCircle
//
//  Created by Vladimir Hudnitsky on 3/24/15.
//  Copyright (c) 2015 Sveta Dedunovich. All rights reserved.
//

import Foundation
import WatchKit

class GlanceController: WKInterfaceController {
    var circle : ProgressCircle!
    @IBOutlet weak var imageView: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        self.circle = ProgressCircle()
        self.circle.createCircle()
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour : Int = components.hour
        let minutes : Int = components.minute
        let progress : CGFloat = CGFloat(CGFloat(hour > 12 ? hour - 12 : hour)/12) + CGFloat(CGFloat(minutes) / 600)
        
        self.imageView.setImage(self.circle.getImage(progress))
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func updateUserActivity(type: String, userInfo: [NSObject : AnyObject]?, webpageURL: NSURL?) {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour : Int = components.hour
        let minutes : Int = components.minute
        let progress : CGFloat = CGFloat(CGFloat(hour > 12 ? hour - 12 : hour)/12) + CGFloat(CGFloat(minutes) / 600)
        
        self.imageView.setImage(self.circle.getImage(progress))
    }
    
    override func handleUserActivity(userInfo: [NSObject : AnyObject]?) {
        
    }
}
