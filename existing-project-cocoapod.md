---
title: Integration using Cocoapod
layout: default 
---

### Pre-requisite ###

Install cocoapod, by following the [installation guide](https://guides.cocoapods.org/using/getting-started.html#toc_3).

### Amend your podfile ###

Below is an example of cocoapod file. You need to replace the target names with the names of your app's target. 
For instructions on how to create the today widget and notification UI targets, c.f. the widget [Today widget integration](./widget-integration.html)
and [Custom notification UI](./custom-notification-ui.html) integration pages. 

        platform :ios, '8.0' # or whichever version your app is targetting. 8.0 is the minimum for the PVN SDK
        use_frameworks!

        target 'MyApp' do
          pod 'IncomingSDK/IncomingPVN'
        end


Once added, run `pod install`.


{% include_relative existing-project-common.md %}