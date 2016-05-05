//
//  AppDelegate.swift
//  PVNSampleSwift
//
//  Created by Sebastien Ardon on 6/02/2015.
//  Copyright (c) 2015 Incoming Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // ISDK method forward
        ISDKAppDelegateHelper.application(application, didFinishLaunchingWithOptions:launchOptions)
        
        // Register for remote notifications. The Incoming PVN uses silent remote notifications for content updates. 
        // You must call this method at some stage for the push video service to operate correctly. 
        ISDKAppDelegateHelper.registerForRemoteNotifications()
        
        // This will pop-up the OS permission dialog, feel free to
        // integrate them differently in your workflow
        ISDKAppDelegateHelper.registerForNotifications()
        
        
        // the two following calls are optional. They enable location and motion data collection
        // which improves the timing prediction of Push Video Notifications.
        // Calling these methods may result in the OS permission dialog being presented
        // to the user.
        ISDKAppDelegateHelper.registerForLocationUpdates()
        ISDKAppDelegateHelper.registerForMotionActivity()
        
        
        // <insert your app initialization code here>
        return true
    }
    
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        // ISDK method forward
        if (ISDKAppDelegateHelper.handleOpenURL(url, sourceApplication: sourceApplication, annotation: annotation) == false)
        {
           // perform handling of your app URL here
            
            
        }
        
        return true
    }
    
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        // ISDK method forward
        ISDKAppDelegateHelper.application(application, performFetchWithCompletionHandler:completionHandler)
        
    }
    
    func application(application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: () -> Void) {
        
        // ISDK method forward
        ISDKAppDelegateHelper.application(application, handleEventsForBackgroundURLSession: identifier, completionHandler: completionHandler)
        
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        // ISDK method forward
        ISDKAppDelegateHelper.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        
    }
    
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        
        // ISDK method forward
        ISDKAppDelegateHelper.application(application, didFailToRegisterForRemoteNotificationsWithError:error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        // ISDK method forward
        if ISDKAppDelegateHelper.application(application, didReceiveRemoteNotification: userInfo) == false
        {
            // process your app's remote notification here

        }
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        // ISDK method forward
        if (ISDKAppDelegateHelper.application(application, didReceiveLocalNotification: notification) == false)
        {
            // process your app local notification here
            
        }
    }
    
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        // ISDK method forward
        if (ISDKAppDelegateHelper.application(application, handleActionWithIdentifier: identifier, forLocalNotification: notification, completionHandler: completionHandler) == false)
        {
            // process your app local notification here
            
            
            // call completion handler
            completionHandler();
        }
    }
    

    func applicationWillResignActive(application: UIApplication) {
        
        // ISDK method calls
        
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

