//
//  ProgressCircle.swift
//  ProgressCircle
//
//  Created by Sveta Dedunovich on 2/19/15.
//  Copyright (c) 2015 Sveta Dedunovich. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics


@IBDesignable
class ProgressCircle: CircleBar {
    
    var buttonClickHandler: ((isButtonSelected: Bool) -> ())?
    
    @IBInspectable var showButton: Bool = true {
        didSet {
            if showButton {
                button.hidden = !showButton
            }
        }
    }
    
    @IBInspectable var selectedButtonImage: UIImage? {
        didSet {
            if let image = selectedButtonImage {
                button.setBackgroundImage(image, forState: UIControlState.Selected)
            }
        }
    }
    
    @IBInspectable var notSelectedButtonImage: UIImage? {
        didSet {
            if let image = notSelectedButtonImage {
                button.setBackgroundImage(image, forState: UIControlState.Normal)
            }
        }
    }
    
    @IBInspectable var titleText: String = "25" {
        didSet {
            titleText = titleText.uppercaseString
            let text = NSAttributedString(string: titleText, attributes: titleTextAttributes())
            titleLabel.attributedText = text
        }
    }
    
    @IBInspectable var subtitleText: String = "DAYS PASSED" {
        didSet {
            subtitleText = subtitleText.uppercaseString
            let text = NSAttributedString(string: subtitleText, attributes: subtitleTextAttributes())
            subtitleLabel.attributedText = text
        }
    }
    
    var titleFont: UIFont = UIFont(name: "AvenirNext-UltraLight", size: 100)!
    var subtitleFont: UIFont = UIFont(name: "HelveticaNeue-Light", size: 22)!
    
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var button = BellButton()
    
    override init () {
        super.init()
        createSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    private func createSubviews() {
        createLabels()
        #if !TARGET_INTERFACE_BUILDER
            createButton()
        #endif
    }
    
    //MARK: configuring subviews
    private func createLabels() {
        titleLabel.frame = titleFrame()
        addSubview(titleLabel)
        subtitleLabel.frame = subtitleFrame()
        addSubview(subtitleLabel)
    }
    
    private func createButton() {
        button.frame = buttonFrame()
        button.hidden = !showButton
        button.selected = true
        button.addTarget(self, action: Selector("onButtonClick"), forControlEvents: UIControlEvents.TouchUpInside)

        if let image = selectedButtonImage {
            button.setBackgroundImage(image, forState: UIControlState.Selected)
        }
        
        if let image = notSelectedButtonImage {
            button.setBackgroundImage(image, forState: UIControlState.Normal)
        }
        
        addSubview(button);
    }
    
    func onButtonClick() {
        button.selected = !button.selected
        button.animateSelection()
        
        if let handler = buttonClickHandler {
            handler(isButtonSelected: button.selected)
        }
    }
    
    // MARK: drawing for live rendering
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        #if TARGET_INTERFACE_BUILDER
            drawText()
            drawButton()
        #endif
    }
}