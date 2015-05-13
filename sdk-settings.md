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

 * `notification_prefix`: (String) Prefix the notification text. E.g. "New video! ". Don't forget to include a space at the end. 
 * `notification_sound`: (string) - Filename of the sound to play when showing a notification, e.g. sound1.caf. 
	The corresponding sound file need to be added to your main app target's bundle. For information about 
	supported sound file formats, c.f. [the official doc](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/IPhoneOSClientImp.html#//apple_ref/doc/uid/TP40008194-CH103-SW6) 

The SDK is now operational. When running your app, the SDK will download video content in the background, and reveal push video notifications according to your project settings.  

Next, if you intend on configuring the iOS8 Today widget, head to the [widget integration](./widget-integration.html) page. 

