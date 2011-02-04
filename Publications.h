//
//  Publications.h
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 Indilo Wireless. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Publications : NSObject {
@private
    NSMutableArray *publicationList;
}

@property (nonatomic, retain) NSMutableArray *publicationList;

@end
