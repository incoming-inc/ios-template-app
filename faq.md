---
title: FAQ
layout: default 
---

# FAQ

* **Can my app make use of Apple remote push notifications as well as the Incoming SDK notifications?**

	Yes. c.f. the [ISDKAppDelegateHelper application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler] method. 


* **Can I test the SDK functionality without Apple Push Notifications working (e.g. without the correct provisioning)?**

	Yes. The SDK reverts to periodic polling in the absence of Apple Push Notifications provisioning. 


* **Which version of Apple XCode is supported by the template apps?** 

	XCode 6.0 and above


* **I don't see much notification activity** 

	When testing, remember that if you kill the app by swiping up in the task switcher, 
	iOS  will not relaunch the app in response to notifications or 
	background fetch.


* **Does the SDK require access to the user's location, motion data ?**

 	No, this is optional, to improve the accuracy of Push Video Notifications.





