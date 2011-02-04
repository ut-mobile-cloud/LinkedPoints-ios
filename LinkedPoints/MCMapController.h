//
//  MCMapController.h
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 Indilo Wireless. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MCMapController : UIViewController<MKMapViewDelegate, UIGestureRecognizerDelegate> {
@private
	MKMapView *mapView;
	UIBarButtonItem *addConferenceButton;
	UILongPressGestureRecognizer *longPress;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addConferenceButton;
- (IBAction)goToTartu:(id)sender;
- (IBAction)addConference:(id)sender;
@end
