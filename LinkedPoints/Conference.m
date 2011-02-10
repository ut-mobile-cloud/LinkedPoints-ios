//
//  Conference.m
//  VideoStreaming
//
//  Created by Madis Nõmme on 2/1/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import "Conference.h"


@implementation Conference
@synthesize ID = m_ID;
@synthesize title = m_title;
@synthesize place = m_place;
@synthesize owner = m_owner;
@synthesize pictureLocation = m_pictureLocation;
@synthesize latitude = m_latitude;
@synthesize longitude = m_longitude;

@dynamic coordinate;
- (CLLocationCoordinate2D)coordinate
{
	return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}
@dynamic subtitle;
- (NSString *)subtitle
{
	return self.place;
}
- (id)initWithID:(int)ID title:(NSString *)title place:(NSString *)place owner:(NSString *)owner picture:(NSString *)picture latitude:(float)latitude longitude:(float)longitude
{
	self = [super init];
	if(self) {
		m_ID = ID;
		m_title = [title retain];
		m_place = [place retain];
		m_owner = [owner retain];
		m_pictureLocation = [picture retain];
		m_latitude = latitude;
		m_longitude = longitude;
	}
	return self;
}

- (void)dealloc
{
	[m_title release];
	[m_place release];
	[m_owner release];
	[m_pictureLocation release];
	[super dealloc];
}

@end
