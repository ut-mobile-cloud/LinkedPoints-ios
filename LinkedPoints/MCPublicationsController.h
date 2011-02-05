//
//  MCPublicationsController.h
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestDelegate.h"

@class Publications;
@interface MCPublicationsController : UIViewController<UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate> {
@private
    Publications *publications;
	UITableView *publicationsTable;
}

@property (nonatomic, retain) IBOutlet UITableView *publicationsTable;
@property (nonatomic, retain) Publications *publications;

@end
