---
title: Integration in an existing Project
layout: default 
---

### Import the iOS SDK zip ###

The PVN SDK distribution zip can be downloaded from your project in the Incoming control panel
(contact your Incoming media representative for access).

The distribution zip file contains a directory named incoming-ios-sdk, which itself contains:

* the Incoming SDK Framework
* the Incoming SDK Resource Bundle
* a sample configuration file sample-incoming-ios-sdk.plist
* README and CHANGELOG

Drag and drop the incoming-ios-sdk onto your XCode project. Tick "Copy items if needed".
![Add SDK to project dialog](./images/add_sdk_to_project_dialog.png)



### Configure framework dependencies ###

(if your project is in Swift, you can skip this phase) 
Go into your app’s target’s Build Phases screen and add the following frameworks to
the *Link Binary With Libraries* section

	* AVFoundation.framework
	* MediaPlayer.framework
	* SystemConfiguration.framework
	* CoreMotion.framework
	* CoreTelephony.framework
	* CoreData.framework
	* CoreMedia.framework
	* MediaPlayer.framework
	* MobileCoreServices.framework
	* SystemConfiguration.framework
	* Foundation.framework
	* CoreImage.framework
	* Accelerate.framework
	* UIKit.framework
	* libz.dylib
	* NotificationCenter.framework (status can be set to “Optional” if you want to support
iOS7

### Configure Background Modes ###

Using XCode, configure the application background modes:
 * click on your app target, then select `Capabilities`.
 * Turn on `Background Modes`
 * In Background Modes, enable `Background fetch and Remote Notifications`

![Background mode configuration ](./images/setup_target_capabilities.png)

In your app Info pane, add the location data collection purpose, by adding a new key for `Privacy 
- Location Usage Description` to e.g. _To compute the best place and time to send you content update_
Note this step is optional, if you enable location data usage in the SDK

![Location ](./images/setup_info_plist_location_privacy_key.png)


### Set linker flags ###

Enable a linker flag that allows the use of categories in the Incoming SDK static library. 
Start by choosing the main target for your app, selecting the Build Settings tab, and then
 search for `other linker flags`. Under Other Linker Flags, add the `-ObjC`.

![Location ](./images/setup_linker_flag.png)

### Add bridging header ###

If your project doesn't use swift, you may skip to the next step. Swift users must add [this 
bridging header](https://github.com/incoming-inc/ios-template-app/blob/master/Swift/ISDK-Bridging-Header.h) 
to their project to be able to use the Incoming PVN sdk.

### Configure push remote notifications ### 

*Note*: The SDK reverts to periodic polling in the absence of Apple Push Notifications provisioning. You 
can therefore test the SDK functionality without completing this step, but it is necessary in production. 

### Add code to your app delegate ###

The host application delegate must to forward several calls from the operating system to the SDK. 
These are all implemented in the template application and can be conveniently copied from there. 

Take a look into the sample application’s delegate code:

 * Objective-C [https://github.com/incoming-inc/ios-template-app/blob/master/Objective-C/PVNTemplate/PVTAppDelegate.m](https://github.com/incoming-inc/ios-template-app/blob/master/Objective-C/PVNTemplate/PVTAppDelegate.m)
 * Swift [https://github.com/incoming-inc/ios-template-app/blob/master/Swift/PVNSampleSwift/AppDelegate.swift](https://github.com/incoming-inc/ios-template-app/blob/master/Swift/PVNSampleSwift/AppDelegate.swift
)

The minimum code to add to your application delegate is as follows. 

#### Objective-C ####

	#import "ISDKAppDelegateHelper.h"
	...


	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{
		[ISDKAppDelegateHelper application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:launchOptions];

		// This will pop-up the OS permission dialog, feel free to
		// integrate them differently in your workflow
		[ISDKAppDelegateHelper registerForNotifications];

		// the two following calls are optional. They enable location and motion data collection
		// which improves the timing prediction of Push Video Notifications
		// calling these methods may also result in the OS permission dialog being presented
		// to the user.
		[ISDKAppDelegateHelper registerForMotionActivity];
		[ISDKAppDelegateHelper registerForLocationUpdates];

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

#### Swift ####


	import UIKit

	@UIApplicationMain
	class AppDelegate: UIResponder, UIApplicationDelegate 
	{
	var window: UIWindow?
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool     
	{ 
	    // ISDK method forward
	    ISDKAppDelegateHelper.application(application, didFinishLaunchingWithOptions:launchOptions)

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


	func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool 
	{

	    // ISDK method forward
	    if (ISDKAppDelegateHelper.handleOpenURL(url, sourceApplication: sourceApplication, annotation: annotation) == NO)
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
	    ISDKAppDelegateHelper.application(application, didReceiveRemoteNotification: userInfo)
	}

	func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {

	    // ISDK method forward
	    ISDKAppDelegateHelper.application(application, didReceiveLocalNotification: notification)
	}


	func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {

	    // ISDK method forward
	    ISDKAppDelegateHelper.application(application, handleActionWithIdentifier: identifier, forLocalNotification: notification, completionHandler: completionHandler)
	}

Once done, you may want to proceed to the [SDK settings configuration](./sdk-settings.html)
