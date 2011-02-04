//
//  MCConferencesController.h
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 Indilo Wireless. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Conferences;
@interface MCConferencesController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
@private
    
	UITableView *conferencesTable;
}
@property (nonatomic, retain) IBOutlet UITableView *conferencesTable;
@property (nonatomic, readonly) Conferences *conferences;

@end
