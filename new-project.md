---
title: Integration in a New Project
layout: default 
---

We provide a template application to make the SDK integration easy in a new project.

### Clone the Template Application ###

```git clone https://github.com/incoming-inc/ios-template-app```

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

To add the Sourse PVN SDK to your project, drag and drop the incoming-ios-sdk folder onto your XCode project. Tick "Copy items if needed".
![Add SDK to project dialog](./images/add_sdk_to_project_dialog.png)

Proceed to the [SDK settings configuration](./sdk-settings.html)


