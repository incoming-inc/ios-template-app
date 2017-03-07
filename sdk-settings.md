---
title: SDK configuration
layout: default 
---

### Create or Edit the Incoming SDK Configuration File ###

In XCode, Navigate to the incoming-ios-sdk group in your project explorer, rename the file sample-incoming-ios-sdk.plist to 
incoming-ios-sdk.plist if necessary. 

This incoming-ios-sdk.plist file is the main SDK configuration file, it must contain at minimum the following keys

 * `api_endpoint`: the Incoming API endpoint to connect to, e.g. api-sandbox.incoming.tv
 * `project_key`: your Incoming PVN project key

You will find both these values in the Incoming media control panel, by going to the 'App' page, in the top­left section titled _Download the push video SDK for iOS_

In addition, this file may contain the following optional keys:

 * `campaign_mode`: (Boolean) Settings this flag to YES will result in each video played several times, until the campaign budget is expired. To set this flag to YES, you should also have the project configured in campaign_mode in the Incoming control panel. Please contact your Incoming representative to discuss this feature if unsure. (Default to NO).  
 * `notification_prefix`: (String). Prefix the notification text. E.g. "New video! ". Don't forget to include a space at the end. (Default to empty)
 * `notification_sound`: (String) Filename of the sound to play when showing a notification, e.g. sound1.caf, or empty or missing if no sound is to be played 
	The corresponding sound file need to be added to your main app target's bundle. For information about 
	supported sound file formats, c.f. [the official doc](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/IPhoneOSClientImp.html#//apple_ref/doc/uid/TP40008194-CH103-SW6) 
 * [New in v2.0-160] `video_controls`: (Boolean) Settings this flag to NO will disable video controls, forcing the user to complete video playback. Default to YES. 

The SDK is now operational. When running your app, the SDK will download video content in the background, and reveal push video notifications according to your project settings.  

Next, if you intend on configuring the iOS8 Today widget, head to the [widget integration](./widget-integration.html) page. 

### Configure push remote notifications ### 

*Note*: The SDK reverts to periodic polling in the absence of Apple Push Notifications provisioning. You 
can therefore test the SDK functionality without completing this step, but it is necessary in production. 

To configure remote push notifications, follow the instructions in the "APNs certificate and keys" section
at [https://push-video.incoming.tv/help](https://push-video.incoming.tv/help)


Proceed to the [Widget integration](./widget-integration.html)

