//
//  MCParser.h
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 Indilo Wireless. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GDataXMLDocument;
@interface MCParser : NSObject {
@private
	GDataXMLDocument *gXmlDoc;
    
}
@property (nonatomic, retain) GDataXMLDocument *gXmlDoc;

- (id)initWithString:(NSString *)xmlString;
- (id)initWithData:(NSData *)xmlData;

@end
