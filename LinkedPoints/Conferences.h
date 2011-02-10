//
//  Conferences.h
//  VideoStreaming
//
//  Created by Madis Nõmme on 2/1/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Conferences : NSObject {
@private
	NSMutableArray *conferenceList;
    
}

@property (nonatomic, retain) NSMutableArray *conferenceList;

@end
