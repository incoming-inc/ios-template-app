//
//  AppDelegate.swift
//  PVNSampleSwift
//
//  Created by Sebastien Ardon on 6/02/2015.
//  Copyright (c) 2015 Incoming Inc. All rights reserved.
//

import UIKit
import UserNotifications
import IncomingPVN

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // ISDK method forward
        ISDKAppDelegateHelper.application(application, didFinishLaunchingWithOptions:launchOptions)
        
        // Register for remote notifications. The Incoming PVN uses silent remote notifications for content updates. 
        // You must call this method at some stage for the push video service to operate correctly. 
        ISDKAppDelegateHelper.registerForRemoteNotifications()
        
        // This will pop-up the OS permission dialog, feel free to
        // integrate them differently in your workflow, e.g. after prompting the user if they'd agree to do so
        ISDKAppDelegateHelper.registerForNotifications()
        
        // set UNNUserNotificationCenter delegate
        if #available(iOS 10.0, *) {
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.delegate = self
        }
        
        // the two following calls are optional. They enable location and motion data collection
        // which improves the timing prediction of Push Video Notifications.
        // Calling these methods may result in the OS permission dialog being presented
        // to the user.
        ISDKAppDelegateHelper.registerForLocationUpdates()
        ISDKAppDelegateHelper.registerForMotionActivity()
        
        // <insert your app initialization code here>
        return true
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        // ISDK method forward
        if (ISDKAppDelegateHelper.handleOpen(url, sourceApplication: sourceApplication!, annotation: annotation) == false)
        {
            // perform handling of your app URL here
            
        }
        return true
    }
    
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // ISDK method forward
        ISDKAppDelegateHelper.application(application, performFetchWithCompletionHandler:completionHandler)
        
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
        // ISDK method forward
        ISDKAppDelegateHelper.application(application, handleEventsForBackgroundURLSession: identifier, completionHandler: completionHandler)
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        // ISDK method forward
        ISDKAppDelegateHelper.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        // ISDK method forward
        ISDKAppDelegateHelper.application(application, didFailToRegisterForRemoteNotificationsWithError:error)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        // ISDK method forward
        if ISDKAppDelegateHelper.application(application, didReceiveRemoteNotification: userInfo) == false {
            // process your app's remote notification here

        }
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        // ISDK method forward
        if (ISDKAppDelegateHelper.application(application, didReceive: notification) == false) {
            // process your app local notification here
            
        }
    }
    
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        
        // ISDK method forward
        if (ISDKAppDelegateHelper.application(application, handleActionWithIdentifier: identifier, for: notification, completionHandler: completionHandler) == false) {
            
            // process your app local notification here
            // when done, call the OS completion block
            completionHandler();
        }
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // forward to ISDK
        ISDKAppDelegateHelper.userNotificationCenter(center, didReceive: response) { (processed: Bool) -> Void in
            
            if !processed {
                // this notification is not ISDK, handle your app notification response here as needed
            }
            
            // when done, call the OS completion block
            completionHandler()
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        ISDKAppDelegateHelper.userNotificationCenter(center, willPresent: notification) { (processed: Bool) -> Void in
            if !processed {
                // this notification is not ISDK
                // process your app notification here
                // and call the completion handler if needed ..

            }
        }
    }
}

