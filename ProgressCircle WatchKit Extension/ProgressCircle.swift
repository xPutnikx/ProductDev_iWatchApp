//
//  ProgressCircle.swift
//  ProgressCircle
//
//  Created by Vladimir Hudnitsky on 3/23/15.
//  Copyright (c) 2015 Sveta Dedunovich. All rights reserved.
//

//
//  ProgreeCircle.swift
//  ProgressCircle
//
//  Created by Vladimir Hudnitsky on 3/23/15.
//  Copyright (c) 2015 Sveta Dedunovich. All rights reserved.
//


import UIKit
import QuartzCore

extension UIColor {
    
    class func colorWithRGB(red: Double, green: Double, blue: Double) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0);
    }
    
    class func colorWithRGBA(red: Double, green: Double, blue: Double, alpha: Double) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha));
    }
    
}


class ProgressCircle : NSObject{
    
    
    override init () {
        self.circle = UIView()
        self.progress = 0.8
        self.progressCircle = CAShapeLayer()
    }
    
    var circle : UIView
    var progress : CGFloat
    var progressCircle : CAShapeLayer
    
    func createCircle(){
        self.circle = UIView()
        var frame = CGRectMake(0, 0, 512, 512)
        circle.bounds = frame
        circle.frame = frame
        
        
        circle.layoutIfNeeded()
        
        let centerPoint = CGPointMake(frame.width / 2, frame.width / 2);
        let circleRadius : CGFloat = circle.bounds.width / 2 * 0.83;
        
        var circlePath = UIBezierPath(arcCenter: centerPoint, radius: circleRadius, startAngle: CGFloat(-0.5 * M_PI), endAngle: CGFloat(1.5 * M_PI), clockwise: true);
        
        progressCircle.path = circlePath.CGPath;
        progressCircle.strokeColor = UIColor.greenColor().CGColor;
        progressCircle.fillColor = UIColor.clearColor().CGColor;
        progressCircle.lineWidth = 15;
        progressCircle.strokeStart = 0;
        progressCircle.strokeEnd = self.progress;
        progressCircle.lineCap = kCALineCapRound;
        progressCircle.rasterizationScale = 2.0;
        progressCircle.shouldRasterize = true;
        
        progressCircle.shadowRadius = 3
        progressCircle.shadowColor = UIColor.blackColor().CGColor
        progressCircle.shadowOffset = CGSizeMake(0, 5)
        progressCircle.shadowOpacity = 0.5
        //
        var bgCircle = CAShapeLayer();
        bgCircle = CAShapeLayer ();
        bgCircle.path = circlePath.CGPath;
        var grey = UIColor(red: 241.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0);
        bgCircle.strokeColor = grey.CGColor;
        bgCircle.fillColor = UIColor.clearColor().CGColor;
        bgCircle.lineWidth = 15;
        bgCircle.strokeStart = 0;
        bgCircle.strokeEnd = 1;
        bgCircle.lineCap = kCALineCapRound;
        bgCircle.rasterizationScale = 2.0;
        bgCircle.shouldRasterize = true;
        
        var sh = CAShapeLayer ()
        sh.path = UIBezierPath(arcCenter: centerPoint, radius: CGFloat(circleRadius - 1.0), startAngle: CGFloat(-0.5 * M_PI), endAngle: CGFloat(1.5 * M_PI), clockwise: true).CGPath;
        sh.strokeColor = UIColor.colorWithRGBA(255, green: 255, blue: 255, alpha: 0.1).CGColor;
        sh.fillColor = UIColor.clearColor().CGColor;
        sh.lineWidth = 11;
        sh.strokeStart = 0;
        sh.strokeEnd = 1;
        sh.lineCap = kCALineCapRound;
        sh.rasterizationScale = 2.0;
        sh.shouldRasterize = true;
        sh.shadowRadius = 8
        sh.shadowOffset = CGSizeMake(0, -1)
        sh.shadowColor = UIColor.blackColor().CGColor
        sh.shadowOpacity = 1
        sh.mask = bgCircle
        sh.masksToBounds = true
        
        //circle.layer.addSublayer(bgCircle);
        circle.layer.addSublayer(sh);
        
        var gradient = CAGradientLayer();
        gradient.frame = circle.frame;
        var violet = UIColor(red: 124.0/255.0, green: 77.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        gradient.colors = [UIColor.redColor().CGColor, violet.CGColor];
        var test = UIView()
        test.frame = circle.frame
        gradient.startPoint = CGPointMake(0.0, 0.0);
        gradient.endPoint  = CGPointMake(0, 0);
        gradient.mask = progressCircle;
        gradient.masksToBounds = true;
        gradient.rasterizationScale = 2.0;
        gradient.shouldRasterize = true
        
        gradient.transform = CATransform3DMakeRotation((CGFloat)(0.0 / 180.0 * M_PI), 0, 0, 1.0)
        circle.layer.addSublayer(gradient)
    }
    
    func getImage() -> UIImage{
        return self.captureView(circle)
    }
    
    func getImage(progress : CGFloat) -> UIImage{
        self.progress = progress
        progressCircle.strokeEnd = self.progress;
        return self.captureView(circle)
    }
    
    
    private func captureView(view : UIView) -> UIImage {
        
        //hide controls if needed
        let rect = view.bounds
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        view.layer.renderInContext(context)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return img;
    }
}
