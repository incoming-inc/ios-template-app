---
title: Application Re-engagement Deep Linking
layout: default
---

The Push Video SDK helps the user re-engage with the host application once the user has played a video notification. 

Two forms of application re-engagement links are supported:

 1. A project-wide link that is triggered every time the user finishes playing a video from a notification.
 1. A video-specific link to support richer forms of re-engagement, including displaying a view showing related content, or the series relating to a teaser video viewed from a video notification.

The details of the link are configured in the project settings section of the Incoming control panel. The links supports an arbitrary number of parameters and are tailored to video content management system used. This allows for flexibility with regard to custom video content management system integrations and A/B testing.

On iOS all deep links are delivered using iOS [`custom URLs`](https://developer.apple.com/library/ios/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Inter-AppCommunication/Inter-AppCommunication.html#//apple_ref/doc/uid/TP40007072-CH6-SW10). 

Custom URLs must therefore be configured by your application as per iOS documentation, and entered in the Incoming control panel for specific videos, or project-wide. The Incoming PVN player will invoke the specified URL after the video playback completes, whether it's interrupted by the user, or the video as finished playing. 
