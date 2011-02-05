//
//  MCMapController.m
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import "MCMapController.h"
#import "MCConferenceManager.h"
#import "Conference.h"
#import "Conferences.h"
#import "MCConferenceDetailsController.h"

static NSString *MCConferenceLocationAnnotationIdentifier = @"MCConferenceLocationAnnotationIdentifier";

@implementation MCMapController
@synthesize mapView;
@synthesize addConferenceButton;

- (void)finishedLoadingConferences:(id)sender
{
	[self.mapView removeAnnotations:self.mapView.annotations];
	[self.mapView addAnnotations:[MCConferenceManager sharedManager].conferences.conferenceList];
}

- (void)addPinToLocation:(CLLocationCoordinate2D)location
{
	Conference *newConference = [[Conference alloc] init];
	newConference.title = @"See";
	newConference.place = @"Teine";
	newConference.latitude = location.latitude;
	newConference.longitude = location.longitude;
	[[MCConferenceManager sharedManager].conferences.conferenceList addObject:newConference];
	[self.mapView addAnnotation:newConference];
	[self.mapView setCenterCoordinate:self.mapView.region.center animated:NO];
	// Get the detailsView for user to be able to enter new conference details
	MCConferenceDetailsController *detailsController = [[MCConferenceDetailsController alloc] initWithNibName:@"MCConferenceDetailsController" bundle:nil];
	detailsController.conference = newConference;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.8];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	[self.view addSubview:detailsController.view];
	[detailsController viewWillAppear:YES];
	[UIView commitAnimations];
	// TODO : Newly created Conference needs to be saved. Ask Carlos for how the server will handle it
	[newConference release];
}

- (IBAction)addConference:(id)sender
{
	if([sender isKindOfClass:UILongPressGestureRecognizer.class]) {
		if(((UILongPressGestureRecognizer *)sender).state == UIGestureRecognizerStateBegan) {
			CGPoint touchPoint = [sender locationInView:self.mapView];
			CLLocationCoordinate2D touchCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
			[self addPinToLocation:touchCoordinate];
		}
	}
}

- (IBAction)goToTartu:(id)sender
{
	MKCoordinateRegion newRegion;
    newRegion.center.latitude = 58.378398;
    newRegion.center.longitude = 26.712453;
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
	
    [self.mapView setRegion:newRegion animated:YES];
}

#pragma mark MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:MCConferenceLocationAnnotationIdentifier];
	if(annotationView == nil) {
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:MCConferenceLocationAnnotationIdentifier];
	}
	DLog(@"Created annotation : %@", annotation.title);
	annotationView.canShowCallout = YES;
	annotationView.animatesDrop = YES;
	[annotationView setPinColor: MKPinAnnotationColorGreen];
	return annotationView;
}

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(addConference:)];
	longPress.minimumPressDuration = 1;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedLoadingConferences:) name:MCFinishedLoadingProjectsNotification object:nil];
	[self.mapView addGestureRecognizer:longPress];
	[[MCConferenceManager sharedManager] startLoadingConferences];
}

#pragma mark NSObject
- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[longPress release];
    [mapView release];
	[addConferenceButton release];
    [super dealloc];
}

@end
