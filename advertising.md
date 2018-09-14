---
title: Advertising SDK Integration
layout: default 
---

Advertising SDK support is available in version 1.3.X and above of the Push Video SDK. The choice of Ad SDK, and responsibility of integrating and implementing the chosen Ad SDK remains the responsibility of the host app developer. Incoming then provides the necessary callback mechanism, to allows the ad SDK to display an Ad along side an Incoming push video notification. Currently only pre-roll is supported, i.e. the ad is shown immediately prior to showing the ISDK video player. 

### Supported Ad SDK

Any ad SDK is supported in principle. A set of approved SDK providing high-quality video pre-roll advertisements are however preferred. Contact your Incoming representative to discuss your specific needs. 

### Implementation

The ISDK provides a protocol allowing the host application to define. This protocol is defined in [ISDKAdDelegateHelper.h](apidoc/html/Protocols/ISDKAdAdapter.html). 

To integrate your chosen Ad SDK, first follow the instructions provided by the SDK. Then implement the ISDKAdAdapter protocol using a new or existing class from your host application. In particular, in the `- (void) showPrerollWithCompletionHandler:(void (^)(BOOL adShown, BOOL shouldProceed, NSError **error))completionHandler` method, call the Ad SDK method to show the pre-roll. Once the Ad was shown, your implementation is then required to call the supplied completion handler, to allow the Incoming SDK to show the push video notification. 

The resulting object, implementing the ISDKAdAdapter protocol, then needs to be registered with the ISDK using the `[ISDKAppDelegateHelper setAdAdapter:]` method. 

An example of this integration for an hypothetical Ad SDK called SomeAdSDK is shown below.

~~~~
@interface HAMyAdSDKAdapter : NSObject <ISDKAdAdapter, SomeAdSDKDelegate>
@end


@implementation HAMyAdSDKAdapter

-(void)showPrerollWithCompletionHandler:(void (^)(BOOL adShown, BOOL shouldProceed, NSError **error))isdkCompletionHandler
{
	if ([SomeAdSDK isAdAvailable])
	{
		// SomeAdSDK has an ad to show, show this ad, then call the isdkCompletionHandler
		[SomeAdSDK showADWithCompletionHandler~{
			isdkCompletionHandler(YES, YES, nil);
		}];
	} else {
		// no ad available, call ISDK completion handler with adShown = NO
		isdkCompletionHandler(NO, YES, nil);
	}
}

// this method will be called by the ISDK every time the app launches or comes back to the foreground.
// You can use it to perform any initialization required by your chosen Ad SDK 
- (void) prefetchAdIfPossible 
{
	// optional
	[SomeAdSDK initAds];
}

@end
~~~~
	
And in your app delegate, register the HAMyAdSDKAdapter with the ISDK as follow

~~~~
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	...
	[ISDKAppDelegateHelper application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:launchOptions];

	id<ISDKAdAdapter> adAdapter = [[SomeAdSDKs alloc] init];
	[ISDKAppDelegateHelper setAdAdapter:adAdapter];
	// optional method, if you 
	[adAdapter prefetchAdIfPossible];
}
~~~~




