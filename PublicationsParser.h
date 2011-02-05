//
//  PublicationsParser.h
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCParser.h"

@class Publications;
@class GDataXMLDocument;

@interface PublicationsParser : MCParser {}

+(Publications *)loadPublicationsFromString:(NSString *)xmlString;
- (Publications *)parse;

@end
