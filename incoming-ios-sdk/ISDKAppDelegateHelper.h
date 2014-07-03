//
//  PVSAppDelegateHelper.h
//  PushVideoSample
//
//  Created by doug wright on 19/03/14.
//  Copyright (c) 2014 Incoming Pty. Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ISDKAppDelegateHelper : NSObject

//@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *projectKey;

@property (strong, nonatomic) UIWindow *videoPlayerWindow;
/**
 * Processes a notification for a new video. All local notifications can be passed to this method; ones that don't relate to ISDK video notifications will be ignored.
 */
- (void)handleLocalNotification:(UILocalNotification *)notification;

- (void)handleRemoteNotification:(NSDictionary *)userInfo;

-(void)handleLaunchOptions:(NSDictionary*)launchOptions;

/**
 This should be called from didRegisterForRemoteNotificationsWithDeviceToken in the application delegate.
 */
-(void)handleRemoteNotificationDeviceToken:(NSData*)deviceToken;


-(void)handleRemoteNotificationRegistrationFailed:(NSError*)error;

-(void)performBackgroundUpdate:(void (^)(UIBackgroundFetchResult))completionHandler;

-(void)handleRemoteNotif:(NSDictionary *)userInfo completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

/**
 
 The completion handler is called by the incoming-ios-sdk once the events related to a URL session have been processed.

 @param completionHandler The host application may either pass the completion handler provided by the operating system in <code>handleEventsForBackgroundURLSession</code> or if the host application is executing other background download tasks it may implement its own completion handler to pass to the SDK.
 
 @param identifier the identifier provided by the operating system in the call to <code>handleEventsForBackgroundURLSession</code>.

 */
-(void)setBackGroundSessionCompletionHandler:(NSString*)identifier completionHandler:(void (^)())completionHandler;

@end
