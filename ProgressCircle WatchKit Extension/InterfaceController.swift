//
//  InterfaceController.swift
//  ProgressCircle WatchKit Extension
//
//  Created by Vladimir Hudnitsky on 3/23/15.
//  Copyright (c) 2015 Sveta Dedunovich. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    @IBOutlet weak var imageView: WKInterfaceImage!
    @IBOutlet weak var updateButton: WKInterfaceButton!
    var circle : ProgressCircle!
    
    @IBAction func shareClick() {
        println("share")
    }
    
    @IBAction func maybeClick() {
        println("maybe")
    }
    
    @IBAction func offClick() {
        println("off")
    }
    
    @IBActio]'  az cyui'n func onClick() {
        println("on")
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        InterfaceController.openParentApplication(["getProgress": "1"], reply: {(response, error) -> Void in
            if(error == nil){
                var progress : CGFloat = response["progress"] as CGFloat
               if(self.circle != nil){
                    self.imageView.setImage(self.circle.getImage(progress))
                }
            }
        })
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        self.circle = ProgressCircle()
        self.circle.createCircle()
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func update(){
        InterfaceController.openParentApplication(["getProgress": "1"], reply: {(response, error) -> Void in
            if(error == nil){
                var progress : CGFloat = response["progress"] as CGFloat
                if(self.circle != nil){
                    self.imageView.setImage(self.circle.getImage(progress))
                }
            }
        })
    }
}
