//
//  UIColor+RGB.swift
//  ProgressCircle
//
//  Created by Sveta Dedunovich on 3/13/15.
//  Copyright (c) 2015 Sveta Dedunovich. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    class func colorWithRGB(red: Double, green: Double, blue: Double) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0);
    }
    
    class func colorWithRGBA(red: Double, green: Double, blue: Double, alpha: Double) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha));
    }
    
}