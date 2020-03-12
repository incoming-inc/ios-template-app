//
//  PVTAppDelegate.m
//  PVNTemplate
//
//  Created by doug wright on 10/06/14.
//  Copyright (c) 2014 Incoming Pty Ltd. All rights reserved.
//

#import "PVTAppDelegate.h"
#import <IncomingPVN/ISDKAppDelegateHelper.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface PVTAppDelegate() <UNUserNotificationCenterDelegate> {
    
}
@end

#endif
@implementation PVTAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // ISDK initialization
    [ISDKAppDelegateHelper application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
    }
#endif
    
    
    // Register for remote notifications. The Incoming PVN uses silent remote notifications for content updates. 
    // You must call this method at some stage for the push video service to operate correctly. 
    [ISDKAppDelegateHelper registerForRemoteNotifications];
    
    // This will pop-up the OS permission dialog, feel free to
    // integrate them differently in your workflow
    [ISDKAppDelegateHelper registerForNotifications];
    
    // perform your own initialization here
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([ISDKAppDelegateHelper application:application openURL:url options:nil] == NO) {
        // perform handling of your app URL here
    }
    return YES;
}


- (void) application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [ISDKAppDelegateHelper application:application performFetchWithCompletionHandler:completionHandler];
    
    /**
    If your app uses background fetch, you may want to serialize the work using, e.g. 
    
    [ISDKAppDelegateHelper application:application performFetchWithCompletionHandler:^(UIBackgroundFetchResult isdkResult) {
        // perform your app background fetch - and return result in appBackgroundFetchResult
        UIBackgroundFetchResult appBackgroundFetchResult = UIBackgroundFetchResultNewData;
        
        if (appBackgroundFetchResult == UIBackgroundFetchResultFailed) {
            completionHandler(UIBackgroundFetchResultFailed);
            return;
        }
        
        if (isdkResult == UIBackgroundFetchResultNewData || appBackgroundFetchResult == UIBackgroundFetchResultNewData) {
            completionHandler(UIBackgroundFetchResultNewData);
            return;
        }
        
        completionHandler(appBackgroundFetchResult);
    }];
    */
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler
{
    if ([ISDKAppDelegateHelper canHandleBackgroundURLSession:identifier]) {
        [ISDKAppDelegateHelper application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
    } else {
        // handle your app background download session here
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [ISDKAppDelegateHelper application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [ISDKAppDelegateHelper application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
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

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000

#pragma  mark - UNUserNotificationCenterDelegate methods

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

#endif



@end
