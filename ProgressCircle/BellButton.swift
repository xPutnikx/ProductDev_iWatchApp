//
//  BellButton.swift
//  ProgressCircle
//
//  Created by Sveta Dedunovich on 3/16/15.
//  Copyright (c) 2015 Sveta Dedunovich. All rights reserved.
//

import Foundation
import UIKit

class BellButton: UIButton {
    
    func animateSelection() {
        animate()
    }
    
    func animate() {
        let duration = 2.0 * 17.0 / 32.0
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.CalculationModeLinear
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/17, animations: {
                self.transform = CGAffineTransformMakeRotation(CGFloat(30 * M_PI / 180.0))
            })
            UIView.addKeyframeWithRelativeStartTime(1/17, relativeDuration: 6/17, animations: {
                self.transform = CGAffineTransformMakeRotation(CGFloat(-28 * M_PI / 180.0))
            })
            UIView.addKeyframeWithRelativeStartTime(7/17, relativeDuration: 4/17, animations: {
                self.transform = CGAffineTransformMakeRotation(CGFloat(20 * M_PI / 180.0))
            })
            UIView.addKeyframeWithRelativeStartTime(11/17, relativeDuration: 4/17, animations: {
                self.transform = CGAffineTransformMakeRotation(CGFloat(-15 * M_PI / 180.0))
            })
            UIView.addKeyframeWithRelativeStartTime(15/17, relativeDuration: 1/17, animations: {
                self.transform = CGAffineTransformMakeRotation(CGFloat(3 * M_PI / 180.0))
            })
            UIView.addKeyframeWithRelativeStartTime(16/17, relativeDuration: 1/17, animations: {
                self.transform = CGAffineTransformMakeRotation(CGFloat(0 * M_PI / 180.0))
            })
            
        }, completion: nil)
        
    }
}
