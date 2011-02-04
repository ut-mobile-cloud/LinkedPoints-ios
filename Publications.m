//
//  Publications.m
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 Indilo Wireless. All rights reserved.
//

#import "Publications.h"


@implementation Publications
@synthesize publicationList;

- (id)init
{
	self = [super init];
	if(self) {
		publicationList = [[NSMutableArray alloc] initWithCapacity:0];
	}
	return self;
}

- (void)dealloc
{
	[publicationList release];
	[super dealloc];
}
@end
