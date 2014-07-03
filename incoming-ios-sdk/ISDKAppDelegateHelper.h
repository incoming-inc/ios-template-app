//
//  PVSAppDelegateHelper.h
//
//  Created by doug wright on 19/03/14.
//  Copyright (c) 2014 Incoming Pty. Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ISDKAppDelegateHelper : NSObject

@property (strong, nonatomic) NSString *projectKey;
@property (strong, nonatomic) UIWindow *videoPlayerWindow;

/**
 Call this from didFinishLaunchingWithOptions.
 */
-(void)handleLaunchOptions:(NSDictionary*)launchOptions;

#pragma mark - Background update of services

/**
 Inform the Incoming SDK a background fetch update is in progress. Call this from performFetchWithCompletionHandler in the application delegate.
 */
-(void)performBackgroundUpdate:(void (^)(UIBackgroundFetchResult))completionHandler;

#pragma mark - Download

/**
 
 The completion handler is called by the incoming-ios-sdk once the events related to a URL session have been processed.
 
 @param completionHandler The host application may either pass the completion handler provided by the operating system in <code>handleEventsForBackgroundURLSession</code> or if the host application is executing other background download tasks it may implement its own completion handler to pass to the SDK.
 
 @param identifier the identifier provided by the operating system in the call to <code>handleEventsForBackgroundURLSession</code>.
 
 */
-(void)setBackGroundSessionCompletionHandler:(NSString*)identifier completionHandler:(void (^)())completionHandler;

#pragma mark - Notifications

/**
 * Processes a notification for a new video. All local notifications can be passed to this method; ones that don't relate to ISDK video notifications will be ignored.
 */
- (void)handleLocalNotification:(UILocalNotification *)notification;

/**
  Call this from didReceiveRemoteNotification in the application delegate.
 */
- (void)handleRemoteNotification:(NSDictionary *)userInfo;

/**
 This should be called from didRegisterForRemoteNotificationsWithDeviceToken in the application delegate.
 */
-(void)handleRemoteNotificationDeviceToken:(NSData*)deviceToken;

-(void)handleRemoteNotificationRegistrationFailed:(NSError*)error;

/**
 Call this from the block variant of didReceiveRemoteNotification in the application delegate.
 */
-(void)handleRemoteNotif:(NSDictionary *)userInfo completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;


@end
