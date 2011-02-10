//
//  ConferencesParser.m
//  VideoStreaming
//
//  Created by Madis Nõmme on 2/1/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import "ConferencesParser.h"
#import "Conference.h"
#import "Conferences.h"
#import "GDataXMLNode.h"

@implementation ConferencesParser
// Sample XML
/*
 <record>
 <ID field="INT">1</ID>
 <Title field="VARCHAR">mobile cloud computing</Title>
 <latitude field="DOUBLE">22</latitude>
 <longitude field="DOUBLE">52</longitude>
 <Place field="VARCHAR">tartu, Estonia</Place>
 <Owner field="CHAR">null</Owner>
 <PictureLocation field="VARCHAR">tartu Estoniamobile cloud computing04jpg</PictureLocation>
 </record>
 */

+ (Conferences *)loadConferencesFromString:(NSString *)xmlString
{
	ConferencesParser *parser = [[[ConferencesParser alloc] initWithString:xmlString] autorelease];
	return [parser parse];
}

- (Conferences *)parse
{
	if(self.gXmlDoc == nil) {
		return nil;
	}
	Conferences *conferences = [[Conferences alloc] init];
	NSArray *conferencesXml = [self.gXmlDoc.rootElement elementsForName:@"record"];
	for (GDataXMLElement *conference in conferencesXml) {
		int ID = -1;
		NSString *title = nil;
		NSString *place = nil;
		NSString *owner = nil;
		NSString *picture = nil;
		float latitude = -1;
		float longitude = -1;
		// ID
		NSArray *IDs = [conference elementsForName:@"ID"];
		if(IDs.count > 0) {
			GDataXMLElement *firstID = (GDataXMLElement *)[IDs objectAtIndex:0];
			ID = [[firstID stringValue] intValue];
		} else continue;
		// Title
		NSArray *titles = [conference elementsForName:@"Title"];
		if(titles.count > 0) {
			GDataXMLElement *firstTitle = (GDataXMLElement *)[titles objectAtIndex:0];
			title = firstTitle.stringValue;
		} else continue;
		// Place
		NSArray *places = [conference elementsForName:@"Place"];
		if(titles.count > 0) {
			GDataXMLElement *firstPlace = (GDataXMLElement *)[places objectAtIndex:0];
			place = firstPlace.stringValue;
		} else continue;
		// Owner
		NSArray *owners = [conference elementsForName:@"Owner"];
		if(owners.count > 0) {
			GDataXMLElement *firstOwner = (GDataXMLElement *)[owners objectAtIndex:0];
			owner = firstOwner.stringValue;
		} else continue;
		// Picture
		NSArray *pictures = [conference elementsForName:@"PictureLocation"];
		if(titles.count > 0) {
			GDataXMLElement *firstPicture = (GDataXMLElement *)[pictures objectAtIndex:0];
			picture = firstPicture.stringValue;
		} else continue;
		// Latitude
		NSArray *latitudes = [conference elementsForName:@"latitude"];
		if(latitudes.count > 0) {
			GDataXMLElement *firstLatitude = (GDataXMLElement *)[latitudes objectAtIndex:0];
			latitude = [[firstLatitude stringValue] floatValue];
		} else continue;
		// Longitude
		NSArray *longitudes = [conference elementsForName:@"longitude"];
		if(longitudes.count > 0) {
			GDataXMLElement *firstLongitude = (GDataXMLElement *)[longitudes objectAtIndex:0];
			longitude = [[firstLongitude stringValue] floatValue];
		} else continue;
		Conference *newConference = [[[Conference alloc] initWithID:ID title:title place:place owner:owner picture:picture latitude:latitude longitude:longitude] autorelease];
		[conferences.conferenceList addObject:newConference];
	}
	return [conferences autorelease];
}

@end
