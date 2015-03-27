//
//  ProgressCirlce+LiveRendering.swift
//  ProgressCircle
//
//  Created by Sveta Dedunovich on 3/16/15.
//  Copyright (c) 2015 Sveta Dedunovich. All rights reserved.
//

import Foundation


extension ProgressCircle {
    
    internal func drawText() {
        let text = NSString(string: titleText)
        text.drawInRect(titleFrame(), withAttributes: titleTextAttributes())
        
        let subtitleText = NSString(string: self.subtitleText)
        var subtitleFrame = self.subtitleFrame()
        subtitleText.drawInRect(subtitleFrame, withAttributes: subtitleTextAttributes())
    }
    
    internal func titleTextAttributes() -> NSDictionary {
        var style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center
        var color = UIColor.colorWithRGB(69, green: 90, blue: 100)
        let attributes = [NSFontAttributeName: titleFont, NSParagraphStyleAttributeName: style, NSForegroundColorAttributeName: color]
        return attributes
    }
    
    internal func subtitleTextAttributes() -> NSDictionary {
        var style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center
        var color = UIColor.colorWithRGB(167, green: 168, blue: 171)
        let attributes = [NSFontAttributeName: subtitleFont, NSParagraphStyleAttributeName: style, NSForegroundColorAttributeName: color]
        return attributes
    }
    
    internal func titleFrame() -> CGRect {
        var titleFrame = frame
        titleFrame.size = CGSizeMake(frame.size.width, 120)
        titleFrame.origin = CGPointMake(0, frame.size.height / 2 - titleFrame.size.height / 2 - 5)
        return titleFrame
    }
    
    internal func subtitleFrame() -> CGRect {
        var subtitleFrame = titleFrame()
        subtitleFrame.origin.y = CGRectGetMaxY(subtitleFrame) - 25
        subtitleFrame.size.height = 60
        return subtitleFrame
    }
    
    internal func drawButton() {
        var frame = buttonFrame()
        if let image = selectedButtonImage {
            image.drawInRect(frame)
        }
    }
    
    internal func buttonFrame() -> CGRect {
        var frame = CGRectMake(0, 45, 28, 30)
        let width = CGFloat(32)
        let height = CGFloat(35)
        frame.origin.x = (self.frame.size.width - width)/2
        frame.size = CGSizeMake(width, height)
        return frame
    }
}