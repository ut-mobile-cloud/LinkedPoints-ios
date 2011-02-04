//
//  MCMapController.h
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 Indilo Wireless. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;
@interface MCMapController : UIViewController {
@private
    
	MKMapView *mapView;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end
