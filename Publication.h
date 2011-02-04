//
//  Publication.h
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 Indilo Wireless. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Publication : NSObject {
@private
    int m_ID;
	NSString *m_title;
	NSString *m_date;
	NSString *m_fileLocation;
}

@property (nonatomic, assign) int ID;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *fileLocation;

- (id)initWithID:(int)ID title:(NSString *)title date:(NSString *)date fileLocation:(NSString *)fileLocation;

@end
