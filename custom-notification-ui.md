---
title: Custom Notifications UI
layout: default 
---

iOS 10 introduced the ability to customise how user notifications are presented, through the [UserNotificationUI framework](https://developer.apple.com/reference/usernotificationsui). 

Leveraging this iOS feature, from version 1.13 and onward, the Sourse PVN SDK can play videos right into the notification UI. This feature can be accessed by users by hard-pressing a notification on 3D touch devices, or by sliding on non-3D touch devices. 

![Notification UI Overview](images/notification-ui-overview.png)      ![Notification UI Player](images/notification-ui-player.png)

This document outlines how to implement a custom user notification UI using the Sourse Push Video SDK.

## Overview

Custom user notification UI are implemented in iOS 10 as an [_app extension_](https://developer.apple.com/library/ios/documentation/General/Conceptual/ExtensibilityPG/). 

While iOS provides the ability to add video media attachments to notifications, iOS restricts the video file attachments to a 50MB file size. To work around this limitation, the Sourse PVN SDK uses an iOS [shared container](https://developer.apple.com/library/content/documentation/General/Conceptual/ExtensibilityPG/ExtensionScenarios.html#//apple_ref/doc/uid/TP40014214-CH21-SW6) to share files between the app and the Notification Content extension.  

__Note: The following steps are quite similar to the steps needed to [configure the today widget](./widget-integration.html), so if you have already done that - you will find these can be be significantly shortened__


## Pre-requisites

To add a custom notification ui you will need: 

* XCode 8 or above
* Access to the apple developer portal for your app ID
* Your app project, [configured to use the Sourse Push Video Notification SDK](./).


## Apple developer portal configuration ##

The notification UI is an iOS 10 app extension of the “Notification Content” type (c.f. [https://developer.apple.com/app­extensions/](https://developer.apple.com/app­extensions/))​.
Its code therefore reside in a separate target under your XCode project, with a separate Bundle ID (‘app id’). You must therefore configure two bundle ID in the apple developer portal: one for your application and one for the widget. In addition, the SDK and the widget must be part of the same apple app group, to be able to communicate and exchange data (c.f. the “Sharing Data with your Container app” section at [https://developer.apple.com/library/ios/documentation/General/Conceptual/ExtensibilityPG/Ext ensionScenarios.html](https://developer.apple.com/library/ios/documentation/General/Conceptual/ExtensibilityPG/Ext ensionScenarios.html)).


### Create the bundle IDs ###

Log in the Apple developer portal, and click __Certificates, Identifiers and Profiles__, then __Identifiers__ under __App Ids__.

![Create app ID screenshot](./images/widget_appledev_app_id.png)

Create an app id in the form `com.yourcompany.yourapp.notificationui`. 
You should therefore have three app IDs with the following structure:

 * `com.yourcompany.yourapp` 
 * `com.yourcompany.yourapp.widget`
 * `com.yourcompany.yourapp.notificationui`

Note: The host application cannot use a wildcard app id (in the form com.yourcompany.*), as the Sourse Push Video Notification requires push notifications


### Create the app group ### 

The notification UI and host application use a shared filesystem area to communicate and exchange data. To enable this shared filesystem, the containing app's main target and the widget / notification content extension bundle IDs need to be part of the same "App Group".

__Note: This app group should be the same used for the widget, so it you have already created an app group for the Today widget, you may want to skip this section__

To create the app group, still in the apple developer portal, click Identifiers / App Groups / +. Name it e.g. `group.com.yourcompany.yourapp` (Apple recommends that the group name should start with ‘group’). 
	
![Create app group screenshot](./images/widget_app_group.png)


### Configure app IDs to use the app security group ###

In the Apple Developer portal, select “Identifiers” / "App IDs” and enable the App Group service for the three app IDs previously created, by clicking the app ID, then ‘Edit’ at the bottom, then toggle the ‘App Groups’ service, click “edit” and select the app group created in the previous step.

![Configure app ID to use app group](./images/widget_app_group_configure.png)


![Configure app ID to use app group](./images/widget_app_group_configure2.png)


### Re-generate provisioning profiles ###

Provisioning profiles must be re­generated so that the app group service is enabled when building your application. In the Apple Developer Portal, go to “Provisioning Profiles”, and __generate a provisioning profile for each app ID__.

## XCode project configuration


### Create the Notification Content target
 
Add a new target to your project, of type _Notification Content_: Select _Add Target_ from the _Editor_ menu, and choose the _Notification Content_ type. 

![Add a new target of type Notification Content](./images/notificationui_create_target.png)

### Configure the Notification Content Target

Configure the new target's notification category. Select your target, navigate to the _Info_ Pane, and open the _NSExtension_ property, then _NSExtensionAttribute_. Change the _UNNotificationExtensionCategory_ value to `isdk-notifications`

![Configure the new target's UNNotificationExtensionCategory value](./images/notificationui_configure_target.png)

Configure the target's initial aspect ratio. If your video content is mostly 16:9 ratio, configure the `UNNotificationExtensionInitialContentSizeRatio` value to match your content aspect ratio. E.g. for 16:9 content enter a value of 0.5625 (9:16). 

In the XCode project navigator, select your project, then your Notification Content target, and select the Capability pane. Scroll down to “App Group”, and select the app group previously created in the Apple Developer Portal. If you don’t see your app group, click the reload button (next to the ‘+’ button). Note that all Sourse-related targets (main app, Widget, and Notification Content) must be configured with the same app group capability. 

![Configure the new target's app group capability](./images/notificationui-appgroup.png)


### Add the Sourse Notification UI library and assets to your target

#### Cocoapod method

To add the widget library to your Notification Content Extension target using cocoapod, amend your Podfile using the following

~~~~
        # (Replate MyAppNotificationContentExtension with your target name)
        target 'MyAppNotificationContentExtension' do
          platform :ios, '10.0'
          pod 'IncomingSDK/NotificationUI'
        end
~~~~

and run `pod install`

#### Zip Archive method

From the Incoming PVN SDK zip archive distribution, drag the NotificationUI subfolder to your project, adding them to Notification Content Extension target.

##### Configure the target Linker Flags

_(This step can be skipped if using cocoapod)_
In XCode, click on the notification content extension target, then select the 'Build Settings' tab, and search for 'Other Linker Flags' in the top right search box. Enter '-ObjC' for the 'Other Linker Flags' option. 

##### Set up Frameworks 

_(This step can be skipped if using cocoapod)_
Select your Notification Content Extension target, navigate to the _Build Phases_ pane, and add the _AVFoundation_ and _MobileCoreServices_ framework. 
![Add the AVFoundation framework to the target build phases](./images/notificationui_add_frameworks.png)


### Configure the Notification Content target storyboard

In the XCode project navigator, select your project, then your Notification Content target, and select the General pane. Scroll down to the 'Deployment Info' section, and set the main interface to the ISDKNotification.storyboard. 

![Configure the Notification Content target storyboard](./images/notificationui-storyboard.png)

__Note__: the Notification Content Extenstion UI is entirely implemented in the supplied framework and bundle. However, the target must contain at least one compilable source file so that the framework can be linked against something. 


### Configure the Sourse Push Notification SDK

This step ensures that the Sourse PVN SDK uses the right app group. Download the [incoming-notification-ui.plist](./incoming-notification-ui.plist) configuration file and add it to your project, by dragging it onto your newly created notification UI target in XCode. Make sure to check "copy files if needed", it needs to be be added to the notification UI bundle.

Edit the _incoming-notification--ui.plist_ file, and add this entries:

 * `security_application_group`​ set to your group name, e.g. group.com.yourcompany.yourapp

![Configure SDK notification UI file](./images/notificationui-config-file.png)


### Configure target provisioning profiles

This step ensure that each target embeds the right provisioning profile. In both main app and widget target’s build settings, scroll down to the “Code Signing” and check that the “Provisioning Profile” setting is set to “Automatic”. Alternatively, select the provisioning profiles previously created in the Apple Developer Portal.



Once done, you may want to proceed to the [Testing / logging page](./testing-logging.html)




