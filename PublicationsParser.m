//
//  PublicationsParser.m
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 Indilo Wireless. All rights reserved.
//

#import "PublicationsParser.h"
#import "Publication.h"
#import "Publications.h"
#import "GDataXMLNode.h"

@implementation PublicationsParser

// Sample XML
/**
 <?xml version="1.0" encoding="UTF-8"?>
 <records>
 <record>
 <ID field="INT">1</ID>
 <Title field="VARCHAR">Mobile Cloud Computing</Title>
 <DOP field="DATETIME">2011-01-30 00:00:00.0</DOP>
 <FileLocation field="VARCHAR">/AndroidVolume/mobileCloudCompuDting.pdf</FileLocation>
 </record>
 <record>
 <ID field="INT">2</ID>
 <Title field="VARCHAR">Mobile Cloud Computing - Amazon</Title>
 <DOP field="DATETIME">2011-01-30 00:00:00.0</DOP>
 <FileLocation field="VARCHAR">/AndroidVolume/mobileCloudCompuDting-amazon.pdf</FileLocation>
 </record>
 </records> 
 */

+(Publications *)loadPublicationsFromString:(NSString *)xmlString
{
	PublicationsParser *parser = [[[PublicationsParser alloc] initWithString:xmlString] autorelease];
	return [parser parse];
}

- (Publications *)parse
{
	Publications *publications = [[Publications alloc] init];
	NSArray *publicationsXml = [self.gXmlDoc.rootElement elementsForName:@"record"];
	for (GDataXMLElement *publication in publicationsXml) {
		int ID = -1;
		NSString *title = nil;
		NSString *date = nil;
		NSString *fileLocation = nil;
		
		// ID
		NSArray *IDs = [publication elementsForName:@"ID"];
		if(IDs.count > 0) {
			GDataXMLElement *firstID = (GDataXMLElement *)[IDs objectAtIndex:0];
			ID = [firstID.stringValue intValue];
		} else continue;
		// Title
		NSArray *titles = [publication elementsForName:@"Title"];
		if(titles.count > 0) {
			GDataXMLElement *firstTitle = (GDataXMLElement *)[titles objectAtIndex:0];
			title = firstTitle.stringValue;
		} else continue;
		// Date
		NSArray *dates = [publication elementsForName:@"DOP"];
		if(dates.count > 0) {
			GDataXMLElement *firstDate = (GDataXMLElement *)[dates objectAtIndex:0];
			date = firstDate.stringValue;
		} else continue;
		// File location
		NSArray *locations = [publication elementsForName:@"FileLocation"];
		if(dates.count > 0) {
			GDataXMLElement *firstLocation = (GDataXMLElement *)[locations objectAtIndex:0];
			fileLocation = firstLocation.stringValue;
		} else continue;
		
		Publication *newPublication = [[Publication alloc] initWithID:ID title:title date:date fileLocation:fileLocation];
		[publications.publicationList addObject:newPublication];
		[newPublication release];
	}
	return [publications autorelease];
}

@end
