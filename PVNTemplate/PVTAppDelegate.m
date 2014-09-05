//
//  PVTAppDelegate.m
//  PVNTemplate
//
//  Created by doug wright on 10/06/14.
//  Copyright (c) 2014 Incoming Pty Ltd. All rights reserved.
//

#import "PVTAppDelegate.h"

@implementation PVTAppDelegate

@synthesize delegateHelper;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    delegateHelper = [[ISDKAppDelegateHelper alloc]init];
    
    UIRemoteNotificationType allowedNotifications = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound |UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeNewsstandContentAvailability;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:allowedNotifications];
    
    
    // register for notifications
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // let this code compile on Xcode 5
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]){
        // ios > 8
        UIUserNotificationType allowedTypes = UIUserNotificationTypeBadge |UIUserNotificationTypeSound |UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:allowedTypes
                                                                                 categories:nil];
        
        if (settings!=nil){
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
        // also register for remote notifications
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        // iOS < 8, use registerForRemoteNotifications
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:allowedNotifications];
    }
#else
    // xcode < 6 (and therefore iOS < 8), use old-style registerForRemoteNotifications
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:allowedNotifications];
#endif
    
    [delegateHelper handleLaunchOptions:launchOptions];
    
    return YES;
}

#pragma mark - Background update of services

- (void) application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [delegateHelper performBackgroundUpdate:^(UIBackgroundFetchResult result){
        completionHandler(result);
    }];
}

#pragma mark - Download

/**
 * The app calls this method when all background transfers associated with an NSURLSession object have finished or failed.
 * See https://developer.apple.com/library/ios/documentation/uikit/reference/uiapplicationdelegate_protocol/Reference/Reference.html#//apple_ref/occ/intfm/UIApplicationDelegate/application:handleEventsForBackgroundURLSession:completionHandler:
 */
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
{
    [delegateHelper setBackGroundSessionCompletionHandler:identifier completionHandler:completionHandler];
}

#pragma mark - Notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [delegateHelper handleRemoteNotificationDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [delegateHelper handleRemoteNotificationRegistrationFailed:error];
}

/**
 Called only when app is in foreground. Background notifications handled in didFinishLaunchingWithOptions.
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [delegateHelper handleRemoteNotification:userInfo completionHandler:nil];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [delegateHelper handleRemoteNotification:userInfo completionHandler:^(UIBackgroundFetchResult result){
        completionHandler(result);
    }];
}

/**
 * If the app is running while the notification is delivered, no alert displayed on screen and this delegate is called.
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [delegateHelper handleLocalNotification:notification];
}

/**
 Introduced in iOS8 for didReceiveLocalNotification.
 */
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)userInfo completionHandler:(void (^)())completionHandler {
    [delegateHelper handleLocalNotification:userInfo];
}

#pragma - mark XCode Template Methods

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
