---
title: FAQ
layout: default 
---

# FAQ


* **Is there a debug log level to have some understanding of what's going on with the SDK?**

	Yes, c.f. [ISDKAppDelegateHelper setLogOn:YES] in [ISDKAppDelegateHelper](./apidoc/html/Classes/ISDKAppDelegateHelper.html)
	

* **Can my app make use of Apple remote push notifications as well as the Incoming SDK notifications?**

	Yes. c.f. [ISDKAppDelegateHelper application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler] method of [ISDKAppDelegateHelper](./apidoc/html/Classes/ISDKAppDelegateHelper.html)


* **Can I test the SDK functionality without Apple Push Notifications working (e.g. without the correct provisioning)?**

	Yes. The SDK reverts to periodic polling in the absence of Apple Push Notifications provisioning. 
	**However** Apple Push Notifications are needed in production, as the background fetch operation of the SDK is not guaranteed by iOS. Remote notifications are used to notify the SDK of new content availability. 

* **I would prefer to handle the presentation of the ISDK video player myself, is that possible?**

	Yes, from version 1.4, implement the [ISDKDelegate protocol](./apidoc/html/Protocols/ISDKDelegate.html) to achieve this. 


* **Which version of Apple XCode is supported by the template apps?** 

	XCode 8.0 and above


* **I don't see much notification activity** 

	When testing, remember that if you kill the app by swiping up in the task switcher,  iOS  will not relaunch the app in response to   background fetch.


* **Does the SDK require access to the user's location, motion data ?**

	No, this is optional, to improve the accuracy of Push Video Notifications.


* **I have configured the widget as per instructions, but when I tap on it, the app opens and the video does not play**

	Check that you have correctly configured the app_url_scheme key in the incoming-ios-sdk.plist configuration file. 
	
	





