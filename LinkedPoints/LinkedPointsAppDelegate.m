//
//  LinkedPointsAppDelegate.m
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import "LinkedPointsAppDelegate.h"
#import "UITabBarController+Additions.h"
@implementation LinkedPointsAppDelegate


@synthesize window;
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Override point for customization after application launch.
	[self.window addSubview:self.tabBarController.view];
	[self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc {

	[window release];
    [tabBarController release];
    [super dealloc];
}

@end
