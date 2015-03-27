//
//  ViewController.swift
//  ProgressCircle
//
//  Created by Sveta Dedunovich on 2/19/15.
//  Copyright (c) 2015 Sveta Dedunovich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressBar: ProgressCircle!
    @IBOutlet weak var imageView: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.8
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func plus() {
        progressBar.progress += 0.1
        let image : UIImage = self.captureView(progressBar)
        imageView.image = image;
        NSLog("test")
    }

    @IBAction func minus() {
        progressBar.progress -= 0.1
    }
    
    @IBAction func sendLocalPush(sender: AnyObject) {
        let notification : UILocalNotification = UILocalNotification()
        notification.alertBody = "Hello world"
        notification.alertAction = "Testing notifications"
        notification.category = "Notification"
        notification.fireDate = NSDate(timeIntervalSinceNow: 7)
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.applicationIconBadgeNumber = 1;
        let application = UIApplication.sharedApplication()
        application.scheduleLocalNotification(notification)
    }
    
    @IBAction func sendRemotePush(sender: AnyObject) {
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

    func getProgressBar() -> ProgressCircle{
        return progressBar;
    }
    
    func registerSettingsAndCategories() {
        var categories = NSMutableSet()
        
        var acceptAction = UIMutableUserNotificationAction()
        acceptAction.title = NSLocalizedString("Accept", comment: "Accept invitation")
        acceptAction.identifier = "accept"
        acceptAction.activationMode = UIUserNotificationActivationMode.Background
        acceptAction.authenticationRequired = false
        
        var declineAction = UIMutableUserNotificationAction()
        declineAction.title = NSLocalizedString("Decline", comment: "Decline invitation")
        declineAction.identifier = "decline"
        declineAction.activationMode = UIUserNotificationActivationMode.Background
        declineAction.authenticationRequired = false
        
        var inviteCategory = UIMutableUserNotificationCategory()
        inviteCategory.setActions([acceptAction, declineAction],
            forContext: UIUserNotificationActionContext.Default)
        inviteCategory.identifier = "invitation"
        
        categories.addObject(inviteCategory)
        
        // Configure other actions and categories and add them to the set...
        
        var settings = UIUserNotificationSettings(forTypes: (.Alert | .Badge | .Sound),
            categories: categories)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
}

