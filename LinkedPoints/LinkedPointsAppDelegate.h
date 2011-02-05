//
//  LinkedPointsAppDelegate.h
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkedPointsAppDelegate : NSObject <UIApplicationDelegate> {
@private

	UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
