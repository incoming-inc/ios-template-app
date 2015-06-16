---
title: Incoming iOS PVN SDK - Release notes
layout: default 
---

v1.3-148 - 16th June 2015
-------------------------

- No breaking API change introduced in this version

- SDK is now bundled as a .framework and .bundle for convenience. To upgrade, discard the old `libincoming-ios-sdk.a`,  `incoming-ios-sdk-resources.bundle` and `include/ISDKDelegateHelper.h` from your project in XCode (make sure to keep your `incoming-ios-sdk.plist` config file which remains unchanged). Then import the content of the SDK distribution. You should have a .bundle and a .framework files added to your main application target. 

- The widget code has been refactored to more closely follow Apple's guidelines. Drag and drop the widget code onto your widget target, make sure to set the widget main storyboard as described in the [widget integration](./widget-integration.html) section.

