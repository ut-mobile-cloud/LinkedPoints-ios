//
//  Conferences.m
//  VideoStreaming
//
//  Created by Madis Nõmme on 2/1/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import "Conferences.h"


@implementation Conferences
@synthesize conferenceList;

- (id)initWithList:(NSMutableArray *)list
{
	self = [super init];
	if(self) {
		self->conferenceList = [list retain];
	}
	return self;
}

- (id)init
{
	self = [super init];
	if(self) {
		self->conferenceList = [[NSMutableArray arrayWithCapacity:0] retain];
	}
	return self;
}

- (void)dealloc
{
	[conferenceList release];
	[super dealloc];
}
@end
