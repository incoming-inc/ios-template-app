---
title: Incoming iOS PVN SDK - Release notes
layout: default 
---

PVN SDK v1.6-39 - 21st August 2015
----------------------------------
- 'ASAP' scheduling
- Post-roll ad support
- Provide the host application with the opportunity to dismiss the PVN video player
- Cache eviction algorithm improvement
- Widget tap starts in-app video player at same playback position 
- FIX #100484088 Explicitly disable airplay in widget video player



PVN SDK v1.4-17 - 8th July 2015
-------------------------------
- Provide the host application with the opportunity to present the ISDK PVN video player using the delegate pattern
- In-widget video player (binary distribution)
- Explicit API for location data opt-out
- Improvement to notification timing algorithm



PVN SDK v1.3-148 - 16th June 2015
---------------------------------
- SDK now packaged as a .bundle and a .framework for convenience
- New feature: Advertising SDK adapters allow host applications to show ads before Push Video playback
- FIX #95077772 - Video player orientation does not match notification and control center
- FIX #95095918 - SDK will not download if notification user denies notification permissions
- FIX #92341456 - Crash in certain conditions when thumbnail downloads a corrupt image file or thumbnail download fails
- FIX #92308604 - Crash in background under certain conditions "with iOS message this request has been neutered"
- FIX #90868644 - Incoming Video player orientation problem: on lansdscape-supporting apps, when pausing and exiting the app while playing



PVN SDK v1.2-63 - 16 march 2015
-------------------------------
- FIX #90182654 - Player / host app rotation problems regression on iOS8


PVN SDK v1.2-49 - 12 march 2015
-------------------------------
- FIX #90182654 - Player / host app rotation problems under some circumstances


PVN SDK v1.2-42 - 12 march 2015
-------------------------------
- FIX #90076754 - Player start automatically when app is in the foreground and in_app_rich_notifications is NO
- FIX #89986402 - Player not shown if UIAlertView is shown
- FIX #89359206 - Crash under rare condition when thumbnail download fail


PVN SDK v1.2 -  Feb 2015
------------------------

- API CHANGE: Make Location and Motion data collection optional, c.f. documentation
- API CHANGE: Added BOOL return value to - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url so that host applications can handle their own app URLs
- Added optional SDK config file flags notification_prefix, sound_file and in_app_rich_notifications
- Fix video player orientation bug (iPad)
- Deep linking


Upgrade instruction from 0.x
----------------------------

- Save a copy of you incoming-ios-sdk.plist aside
- Delete the incoming-ios-sdk folder from your project ('Move to trash')
- Re-import by following instructions at http://incoming-inc.github.io/ios-template-app/
- Check that you have only one incoming-ios-sdk.plist in your app, and that it's the correct one.