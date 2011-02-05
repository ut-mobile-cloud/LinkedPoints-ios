//
//  MCVideoController.h
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/4/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Conference;
@class MPMoviePlayerController;
@interface MCVideoController : UIViewController {
@private
	UIView *movieViewPlace; 
	Conference *conference;
	MPMoviePlayerController *moviePlayer;
	
}

@property (nonatomic, retain) IBOutlet UIView *movieViewPlace;
@property (nonatomic, retain) Conference *conference;
@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;

@end
