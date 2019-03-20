### Configure capabilities ###

Using XCode, configure the application capabilities:

 * click on your app target, then select `Capabilities`.
 * Turn on `Background Modes`
 * In Background Modes, enable `Background fetch` and `Remote Notifications`
 * Turn on `Access Wifi Information`
 
![Background mode configuration ](./images/setup_target_capabilities.png)


### Configure ATS

iOS 8 introduced [App Transport Security](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html). __This step must be completed if and only if your content server exposes assets over plain HTTP__. If you use the Sourse Video Distribution service, you do not need this and can skip to the next section.  

Start by choosing the main target of your app, select the Info tab, and add the 'App Transport Security Settings' key, with a subkey 'Allow Arbitrary Loads' to YES. 
assas

![ATS setup ](./images/setup-ats.png)


### Add code to your app delegate ###

The host application delegate must to forward several calls from the operating system to the SDK. 
These are all implemented in the template application and can be conveniently copied from there. 

Take a look into the sample application’s delegate code:

 * Swift [https://github.com/incoming-inc/ios-template-app/blob/master/Swift/PVNSampleSwift/AppDelegate.swift](https://github.com/incoming-inc/ios-template-app/blob/master/Swift/PVNSampleSwift/AppDelegate.swift)
 * Objective-C [https://github.com/incoming-inc/ios-template-app/blob/master/Objective-C/PVNTemplate/PVTAppDelegate.m](https://github.com/incoming-inc/ios-template-app/blob/master/Objective-C/PVNTemplate/PVTAppDelegate.m)


The minimum code to add to your application delegate is as follows. 


#### Swift ####

~~~~
	import UIKit
	import UserNotifications
	import IncomingPVN

	@UIApplicationMain
	class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

	    var window: UIWindow?


	    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

			// turn on debug logging
			ISDKAppDelegateHelper.setDebugLogging(true);
		
	        // ISDK method forward
	        ISDKAppDelegateHelper.application(application, didFinishLaunchingWithOptions:launchOptions!)

	        // Register for remote notifications. The Sourse PVN uses silent remote notifications for content updates. 
	        // You must call this method at some stage for the push video service to operate correctly. 
	        ISDKAppDelegateHelper.registerForRemoteNotifications()

	        // This will pop-up the OS permission dialog, feel free to
	        // integrate them differently in your workflow
	        ISDKAppDelegateHelper.registerForNotifications()

	        // set UNNUserNotificationCenter delegate
	        if #available(iOS 10.0, *) {
				ISDKAppDelegateHelper.application(application, didFinishLaunchingWithOptions:launchOptions)
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


	    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {

	        // ISDK method forward
	        if (ISDKAppDelegateHelper.handleOpenURL(url, sourceApplication: sourceApplication!, annotation: annotation) == false)
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

	    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
	        // ISDK method forward
	        if ISDKAppDelegateHelper.application(application, didReceiveRemoteNotification: userInfo) == false
	        {
	            // process your app's remote notification here

	        }
	        completionHandler(.newData)
	    }
    
	    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
	        // ISDK method forward
	        if ISDKAppDelegateHelper.application(application, didReceiveRemoteNotification: userInfo) == false
	        {
	            // process your app's remote notification here
            
	        }
	    }
    
	    // Note: if you are targetting iOS 10 and up, this method is not needed
	    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
	        // ISDK method forward
	        if (ISDKAppDelegateHelper.application(application, didReceive: notification) == false)
	        {
	            // process your app local notification here
            
	        }
	    }
    
	    // Note: if you are targetting iOS 10 and up, this method is not needed
	    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
	        // ISDK method forward
	        if (ISDKAppDelegateHelper.application(application, handleActionWithIdentifier: identifier, for: notification, completionHandler: completionHandler) == false)
	        {
	            // process your app local notification here
            
            
	            // call completion handler
	            completionHandler();
	        }
	    }
	
	    @available(iOS 10.0, *)
	    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
	        // forward to ISDK
	        ISDKAppDelegateHelper.userNotificationCenter(center, didReceive: response) { (processed: Bool) -> Void in
	            if !processed {
	                // this notification is not ISDK, handle your app notification response here as needed
	            }
            
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
~~~~

#### Objective-C ####

~~~~
	#import "ISDKAppDelegateHelper.h"
	...


	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{
		
		// turn on debug logging 
		[ISDKAppDelegateHelper setDebugLogging:YES];
		
		[ISDKAppDelegateHelper application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:launchOptions];
		
		// Set the UNUserNotificationCenterDelegate - iOS > 10
		if (NSClassFromString(@"UNUserNotificationCenter")) {
	        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
	        center.delegate = self;
	    }

		// this registers for remote notifications on iOS > 8. It must be called
		// at some stage in your app initialization. Note that this method will never
		// result in a notification permission dialog being shown to the user. 
		[ISDKAppDelegateHelper registerForRemoteNotifications];

		// This will pop-up the OS permission dialog, feel free to
		// integrate them differently in your workflow
		[ISDKAppDelegateHelper registerForNotifications];

		// the two following calls are optional. They enable location and motion data collection
		// which improves the timing prediction of Push Video Notifications
		// calling these methods may also result in the OS permission dialog being presented
		// to the user.
		//[ISDKAppDelegateHelper registerForMotionActivity];
		//[ISDKAppDelegateHelper registerForLocationUpdates];

		return YES;
	}

	- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
	{
		if ([ISDKAppDelegateHelper handleOpenURL:url sourceApplication:sourceApplication annotation:annotation] == NO){
			// perform handling of your app URL here
		}
		return YES;
	}

	- (void) application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
		[ISDKAppDelegateHelper application:application performFetchWithCompletionHandler:completionHandler];
	}

	- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
	{
		[ISDKAppDelegateHelper application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
	}

	- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
	{
		[ISDKAppDelegateHelper application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
	}

	- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
	{
		[ISDKAppDelegateHelper application:application didFailToRegisterForRemoteNotificationsWithError:error];
	}

	- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
	fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
	{
		[ISDKAppDelegateHelper application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
	}

	- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
	{
		[ISDKAppDelegateHelper application:application didReceiveRemoteNotification:userInfo];
	}

	- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
	{
		[ISDKAppDelegateHelper application:application didReceiveLocalNotification:notification];
	}

	- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)userInfo completionHandler:(void (^)())completionHandler {
		[ISDKAppDelegateHelper application:application handleActionWithIdentifier:identifier forLocalNotification:userInfo completionHandler:completionHandler];
	}

	- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
	{
		[ISDKAppDelegateHelper application:application didRegisterUserNotificationSettings:notificationSettings];
	}
	
	
	- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
	{
	    [ISDKAppDelegateHelper userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:^(BOOL processed) {
	        if (!processed)
	        {
	            // handle host app notification response.
	        }
	        if (completionHandler)
	        {
	            completionHandler();
	        }
	    }];
	}

	- (void)userNotificationCenter:(UNUserNotificationCenter *)center
	       willPresentNotification:(UNNotification *)notification
	         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
	{
	    [ISDKAppDelegateHelper userNotificationCenter:center willPresentNotification:notification withCompletionHandler:^(BOOL processed) {
	        if (!processed)
	        {
	            // handle host app notification
	            // and call completion handler
	        } else {
	            completionHandler(UNNotificationPresentationOptionNone);
	        }
	    }];
	}
~~~~

	

Once done, you may want to proceed to the [SDK settings configuration](./sdk-settings.html)
