//
//  ConferencesParser.h
//  VideoStreaming
//
//  Created by Madis Nõmme on 2/1/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCParser.h"

@class Conferences;
@class GDataXMLDocument;

@interface ConferencesParser : MCParser {}

+ (Conferences *)loadConferencesFromString:(NSString *)xmlString;
- (Conferences *)parse;

@end
