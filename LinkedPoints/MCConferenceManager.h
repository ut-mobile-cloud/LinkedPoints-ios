//
//  MKConferenceManager.h
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "ASIHTTPRequest.h"

extern NSString *MCFinishedLoadingProjectsNotification;
extern NSString *MCDidAddConferenceNotification;
extern NSString *MCConferencesDidChangeNotification;

@class Conferences, Conference;
@interface MCConferenceManager : NSObject<ASIHTTPRequestDelegate> {
@private
	Conferences *conferences;
}

@property (nonatomic, readonly) Conferences *conferences;

+ (MCConferenceManager *)sharedManager;
- (void)reloadConferences;
- (void)startLoadingConferences;
- (NSURL *)nextVideoForConference:(Conference *)conference URL:(NSURL *)lastURL;
- (void)addConference:(Conference *)conference withImage:(UIImage *)image progressDelegate:(id<ASIProgressDelegate>)progressDelegate;

@end
