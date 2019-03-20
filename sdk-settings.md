---
title: SDK configuration
layout: default 
---

### Create or Edit the Sourse SDK Configuration File ###


Download the [incoming-ios-sdk.plist](./incoming-ios-sdk.plist) and add it to your project, in your main app's target. Make sure to check "copy files if needed", it needs to be be added to the app bundle. 

This incoming-ios-sdk.plist file is the main SDK configuration file, it must contain at minimum the following keys

 * `api_endpoint`: the Sourse API endpoint to connect to, e.g. api-sandbox.incoming.tv
 * `project_key`: your Sourse PVN project key

You will find both these values in the Sourse media control panel, by going to the 'App' page, in the top­left section titled _Download the push video SDK for iOS_

In addition, this file may contain the following optional keys:

  * `notification_prefix`: (String). Prefix the notification text. E.g. "New video! ". Don't forget to include a space at the end. (Default to empty)
  * `notification_sound`: (String) Filename of the sound to play when showing a notification, e.g. sound1.caf, or empty or missing if no sound is to be played 
	The corresponding sound file need to be added to your main app target's bundle. For information about 
	supported sound file formats, c.f. [the official doc](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/IPhoneOSClientImp.html#//apple_ref/doc/uid/TP40008194-CH103-SW6) 
  * [New in 2.0-160] [Retired in 2.1-233] `campaign_mode`	
  * [New in v2.0-176] `video_controls`: (Boolean) Settings this flag to NO will disable video controls, forcing the user to complete video playback. 

The SDK is now operational. When running your app, the SDK will download video content in the background, and reveal push video notifications or show interstitial according to your project settings.  

Next, if you intend on configuring the iOS8 Today widget, head to the [widget integration](./widget-integration.html) page. 

### Configure push remote notifications ### 

*Note*: The SDK reverts to periodic polling in the absence of Apple Push Notifications provisioning. You 
can therefore test the SDK functionality without completing this step, but it is necessary in production. 

To configure remote push notifications, follow the instructions in the "APNs certificate and keys" section
at [https://push-video.incoming.tv/help](https://push-video.incoming.tv/help)

Once done, you may want to proceed to the [Apple Push Notification configuration](./apns.html) 


