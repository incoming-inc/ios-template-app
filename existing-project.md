---
title: Integration in an existing Project
layout: default 
---

### Import the iOS SDK zip ###

The PVN SDK distribution zip can be downloaded from your project in the Sourse control panel
(contact your Sourse media representative for access).

The distribution zip file contains a directory named incoming-ios-sdk, which itself contains:

* the Sourse SDK Framework
* the Sourse SDK Resource Bundle
* a sample configuration file sample-incoming-ios-sdk.plist
* README and CHANGELOG

The distribution zip also contains:

* incoming-ios-widget: the widget target helper which allows to play Sourse video right in the Notification Center
* incoming-ios-notificationui: the notification UI, which allows to play Sourse video right in the Notifications, on iOS 10
Integration for these two items are covered in separate pages, c.f. [Today widget integration](./widget-integration.html) and [Custom notification UI (iOS 10)](./custom-notification-ui.html)


To add the Sourse PVN SDK to your project, drag and drop the incoming-ios-sdk onto your XCode project. Tick "Copy items if needed".
![Add SDK to project dialog](./images/add_sdk_to_project_dialog.png)


### Configure framework dependencies ###

(if your project is in Swift, you can skip this phase) 
Go into your app’s target’s Build Phases screen and add the following frameworks to
the *Link Binary With Libraries* section

~~~~
	* AVFoundation.framework
	* MediaPlayer.framework
	* SystemConfiguration.framework
	* CoreMotion.framework
	* CoreTelephony.framework
	* CoreData.framework
	* CoreMedia.framework
	* MediaPlayer.framework
	* MobileCoreServices.framework
	* SystemConfiguration.framework
	* Foundation.framework
	* CoreImage.framework
	* Accelerate.framework
	* UIKit.framework
	* libz.dylib
	* NotificationCenter.framework (status can be set to “Optional” if you want to support iOS7
~~~~

### Set linker flags ###

Enable a linker flag that allows the use of categories in the Sourse SDK static library. 
Start by choosing the main target for your app, selecting the Build Settings tab, and then
 search for `other linker flags`. Under Other Linker Flags, add the `-ObjC`.

![Location ](./images/setup_linker_flag.png)


### Add bridging header ###

If your project doesn't use swift, you may skip to the next step. Swift users must add [this 
bridging header](https://github.com/sourse-ai/ios-template-app/blob/master/Swift/ISDK-Bridging-Header.h) 
to their project to be able to use the Sourse PVN sdk.

{% include_relative existing-project-common.md %}