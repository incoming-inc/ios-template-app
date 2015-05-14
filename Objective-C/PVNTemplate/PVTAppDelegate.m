//
//  PVTAppDelegate.m
//  PVNTemplate
//
//  Created by doug wright on 10/06/14.
//  Copyright (c) 2014 Incoming Pty Ltd. All rights reserved.
//

#import "PVTAppDelegate.h"
#import <IncomingPVN/ISDKAppDelegateHelper.h>


@implementation PVTAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [ISDKAppDelegateHelper application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:launchOptions];
    
    
    // This will pop-up the OS permission dialog, feel free to
    // integrate them differently in your workflow
    [ISDKAppDelegateHelper registerForNotifications];
    
    // the two following calls are optional. They enable location and motion data collection
    // which improves the timing prediction of Push Video Notifications.
    // Calling these methods may result in the OS permission dialog being presented
    // to the user.
    [ISDKAppDelegateHelper registerForMotionActivity];
    [ISDKAppDelegateHelper registerForLocationUpdates];
    
    /* perform your own initialization here */
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([ISDKAppDelegateHelper handleOpenURL:url sourceApplication:sourceApplication annotation:annotation] == NO)
    {
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
    if ([ISDKAppDelegateHelper application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler] == NO)
    {
        // process your remote notification here.
        
        
        // call completion handler
        if (completionHandler)
        {
            completionHandler(UIBackgroundFetchResultNewData);
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if ([ISDKAppDelegateHelper application:application didReceiveRemoteNotification:userInfo] == NO)
    {
        // process your remote notification here
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [ISDKAppDelegateHelper application:application didReceiveLocalNotification:notification];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)userInfo completionHandler:(void (^)())completionHandler {
    
    if ([ISDKAppDelegateHelper application:application handleActionWithIdentifier:identifier
                      forLocalNotification:userInfo completionHandler:completionHandler] == NO)
    {
        // process your app local notification here
        
        // call completion handler
        if (completionHandler)
        {
            completionHandler();
        }
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [ISDKAppDelegateHelper application:application didRegisterUserNotificationSettings:notificationSettings];
}

@end
