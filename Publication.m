//
//  Publication.m
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import "Publication.h"


@implementation Publication
@synthesize ID = m_ID;
@synthesize title = m_title;
@synthesize date = m_date;
@synthesize fileLocation = m_fileLocation;

- (id)initWithID:(int)ID title:(NSString *)title date:(NSString *)date fileLocation:(NSString *)fileLocation
{
	self = [super init];
	if(self) {
		m_ID = ID;
		m_title = [title retain];
		m_date = [date retain];
		m_fileLocation = [fileLocation retain];
	}
	return self;
}

- (void)dealloc
{
	[m_title release];
	[m_date release];
	[m_fileLocation release];
	[super dealloc];
}

@end
