//
//  MCParser.m
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 Indilo Wireless. All rights reserved.
//

#import "MCParser.h"
#import "GDataXMLNode.h"

@implementation MCParser
@synthesize gXmlDoc;

- (id)initWithString:(NSString *)xmlString
{
	self = [super init];
	if(self) {
		// TODO: error handling
		gXmlDoc = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
	}
	return self;
}

- (id)initWithData:(NSData *)xmlData
{
	self = [super init];
	if(self) {
		// TODO: error handling
		gXmlDoc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
	}
	return self;
}

- (void)dealloc
{
	[gXmlDoc release];
	[super dealloc];
}
@end
