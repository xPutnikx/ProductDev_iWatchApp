//
//  CircleBar.swift
//  ProgressCircle
//
//  Created by Sveta Dedunovich on 3/16/15.
//  Copyright (c) 2015 Sveta Dedunovich. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics


@IBDesignable
class CircleBar: UIView {
    
    @IBInspectable var progress: Double = 0.0 {
        didSet {
            if progress > 1.0 {
                progress = 1.0
            }
            if progress < 0 {
                progress = 0.0
            }
            progressBar.strokeEnd = CGFloat(progress)
        }
    }
    
    @IBInspectable var trackWidth: Double = 8 { didSet {} }
    @IBInspectable var trackColor: UIColor = UIColor.colorWithRGB(241.0, green: 239.0, blue: 239.0) { didSet {} }
    
    @IBInspectable var progressGradientStartColor: UIColor = UIColor.redColor() { didSet {} }
    @IBInspectable var progressGradientEndColor: UIColor = UIColor.colorWithRGB(124.0, green: 77.0, blue: 255.0) { didSet {} }
    @IBInspectable var gradientRotationAngle: Double = 0.0 { didSet {} }
    
    @IBInspectable var showShadow: Bool = true { didSet {} }
    @IBInspectable var shadowOffset: CGSize = CGSizeMake(0, -3) { didSet {} }
    @IBInspectable var shadowRadius: CGFloat = 5.0 { didSet {} }
    
    private var progressLayer = CAShapeLayer()
    private var progressBar = CAShapeLayer()
    
    override init () {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: drawing circular progress bar elements
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        var circlePath = pathForCircle(inFrame: rect)
        
        var track = drawTrack(circlePath, aTrackWidth: trackWidth, aTrackColor: trackColor)
        layer.addSublayer(track)
        progressBar = drawProgressBar(circlePath, aTrackWidth: trackWidth, aProgress: progress)
        var gradientBar = drawGradient(progressBar, startColor: progressGradientStartColor, endColor: progressGradientEndColor, angle: gradientRotationAngle)
        layer.addSublayer(gradientBar)
    }
    
    private func pathForCircle(inFrame frame: CGRect) -> UIBezierPath {
        let centerPoint = CGPointMake(frame.width / 2, frame.width / 2)
        var maxShadowOffset = max(abs(shadowOffset.width), abs(shadowOffset.height))
        var spaceForShadow = shadowRadius > 0 ? maxShadowOffset + shadowRadius : 0
        let circleRadius : CGFloat = frame.width / 2 - CGFloat(trackWidth) - spaceForShadow
        var path = UIBezierPath(arcCenter: centerPoint, radius: circleRadius, startAngle: CGFloat(-0.5 * M_PI), endAngle: CGFloat(1.5 * M_PI), clockwise: true)
        return path;
    }
    
    private func drawTrack(path: UIBezierPath, aTrackWidth: Double, aTrackColor: UIColor) -> CALayer {
        var track = CAShapeLayer()
        track = CAShapeLayer ()
        track.path = path.CGPath
        track.strokeColor = aTrackColor.CGColor
        track.fillColor = UIColor.clearColor().CGColor
        track.lineWidth = CGFloat(aTrackWidth)
        track.strokeStart = 0
        track.strokeEnd = 1
        track.lineCap = kCALineCapRound
        track.rasterizationScale = 2.0
        track.shouldRasterize = true
        return track
    }
    
    private func contentFrame() -> CGRect {
        var contentFrame = self.frame
        contentFrame.origin = CGPointZero
        return contentFrame
    }
    
    private func drawProgressBar(path: UIBezierPath, aTrackWidth: Double, aProgress: Double) -> CAShapeLayer {
        var bar = CAShapeLayer()
        bar.path = path.CGPath
        bar.strokeColor = UIColor.greenColor().CGColor
        bar.fillColor = UIColor.clearColor().CGColor
        bar.lineWidth = CGFloat(aTrackWidth)
        bar.strokeStart = 0
        bar.strokeEnd = CGFloat(aProgress)
        bar.lineCap = kCALineCapRound
        bar.rasterizationScale = 2.0
        bar.shouldRasterize = true
        
        if showShadow {
            bar.shadowRadius = shadowRadius
            bar.shadowOffset = shadowOffset
            bar.shadowColor = UIColor.blackColor().CGColor
            bar.shadowOpacity = 0.9
        }
        
        return bar
    }
    
    private func drawGradient(layer: CAShapeLayer, startColor: UIColor, endColor: UIColor, angle: Double) -> CAGradientLayer {
        var gradient = CAGradientLayer()
        gradient.frame = contentFrame()
        gradient.colors = [startColor.CGColor, endColor.CGColor]
        gradient.startPoint = CGPointMake(0, 0)
        gradient.endPoint = endPointForGradient(angle)
        
        gradient.mask = layer
        gradient.masksToBounds = true
        gradient.rasterizationScale = 2.0
        gradient.shouldRasterize = true
        
        return gradient
    }
    
    private func endPointForGradient(angle: Double) -> CGPoint {
        if angle < 45 {
            var endY = CGFloat( tan(angle * M_PI / 180.0) )
            return CGPointMake(1, endY)
        } else if angle > 45 {
            var endX = CGFloat( 1.0 / tan(angle * M_PI / 180.0) )
            return CGPointMake(endX, 1)
        }
        return CGPointMake(1, 1)
    }
    
}