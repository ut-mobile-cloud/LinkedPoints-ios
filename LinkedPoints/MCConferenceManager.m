//
//  MCConferenceManager.m
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import "MCConferenceManager.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Conference.h"
#import "Conferences.h"
#import "ConferencesParser.h"

NSString *MCFinishedLoadingProjectsNotification = @"MKFinishedLoadingProjectsNotification";
NSString *MCDidAddConferenceNotification = @"MCDidAddConferenceNotification";
NSString *MCConferencesDidChangeNotification = @"MCConferencesDidChangeNotification";

static NSString *MCConferencesServletURL = @"http://ec2-46-137-15-183.eu-west-1.compute.amazonaws.com:8080/EC2RunInstance/GetConferences";
static NSString *MCAddConferenceServletURL = @"http://ec2-46-137-15-183.eu-west-1.compute.amazonaws.com:8080/EC2RunInstance/CreateConference";
static NSString *MCFirstVideoURLString = @"http://ec2-46-137-15-183.eu-west-1.compute.amazonaws.com:8080/EC2RunInstance/Dispatcher?currentVideo=%@&currentConference=%d";
static NSString *MCImageUploadURL = @"http://ec2-46-137-15-183.eu-west-1.compute.amazonaws.com:8080/EC2RunInstance/UploadImage";

@implementation MCConferenceManager

@dynamic conferences;
- (Conferences *)conferences
{
	if(conferences == nil) {
		[self startLoadingConferences];
	}
	return conferences;
}

+ (MCConferenceManager *)sharedManager
{
	static MCConferenceManager *MCConferenceManagerInstance = nil;
	if(MCConferenceManagerInstance == nil) {
		MCConferenceManagerInstance = [[MCConferenceManager alloc] init];
	}
	return MCConferenceManagerInstance;
}

- (NSURL *)nextVideoForConference:(Conference *)conference URL:(NSURL *)lastURL
{
	if(lastURL == nil) {
		lastURL = [NSURL URLWithString:[NSString stringWithFormat:MCFirstVideoURLString, @"STRRQ", conference.ID]];
	} else {
		lastURL = [NSURL URLWithString:[NSString stringWithFormat:MCFirstVideoURLString, [lastURL absoluteString], conference.ID]];
	}
	ASIHTTPRequest *videoURLRequest = [[ASIHTTPRequest alloc] initWithURL:lastURL];
	NSURL *nextVideoURL = nil;
	[videoURLRequest startSynchronous];
	NSError *error = [videoURLRequest error];
	if(!error) {
		NSString *urlString = [[videoURLRequest responseString] stringByReplacingOccurrencesOfString:@"\n" withString:@""]; // Remove newline character at the end. Somehow the server puts it there
		
		nextVideoURL = [NSURL URLWithString:urlString];
		DLog(@"Received video : %@", [videoURLRequest responseString]);
	}
	return nextVideoURL;
}

- (id)init
{
	self = [super init];
	if(self) {
		conferences = [[Conferences alloc] init];
	}
	return self;
}

- (void)startLoadingConferences
{
	if(conferences != nil) {
		[conferences release];
		conferences = nil;
	}
	if(conferences == nil) {
		NSURL *requestURL = [NSURL URLWithString:MCConferencesServletURL];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestURL];
		request.delegate = self;
		[request startAsynchronous];
	}
}

- (void)reloadConferences
{
	[conferences release];
	[self startLoadingConferences];
}

- (void)addConferenceRequestFailed:(ASIHTTPRequest *)request
{
	DLog(@"Add Conference Request FAILED");
}

- (void)addConferenceRequestFinished:(ASIHTTPRequest *)request
{
	DLog(@"Add Conference Request FINISHED");
	[[NSNotificationCenter defaultCenter] postNotificationName:MCConferencesDidChangeNotification object:nil];
}

- (void)addConference:(Conference *)conference withImage:(UIImage *)image progressDelegate:(id<ASIProgressDelegate>)progressDelegate
{
	// Servlet method is GET
	/*
	private static final String PARAM_CONFERENCE_NAME = "confName";
	private static final String PARAM_CONFERENCE_OWNER = "confOwner";
	private static final String PARAM_CONFERENCE_PLACE = "confPlace";
	private static final String PARAM_LATITUDE = "latitude";
	private static final String PARAM_LONGITUDE = "longitude";
	private static final String PARAM_IMAGE_NAME = "imageName";
	 */

	// 0. Generate picture file name
	conference.pictureLocation = (image == nil) ? @"" : [NSString stringWithFormat:@"%@%fx%f",conference.title, conference.latitude, conference.longitude];
	// 1. Add new conference
	
	NSString *addConferenceURLString = [NSString stringWithFormat:@"%@?confName=%@&confOwner=%@&confPlace=%@&latitude=%f&longitude=%f&imageName=%@", MCAddConferenceServletURL, conference.title, conference.owner, conference.place, conference.latitude, conference.longitude, conference.pictureLocation];
	DLog(@"IMAGE FILENAME : %@", conference.pictureLocation);
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:addConferenceURLString]];
	[request setRequestMethod:@"GET"];
	if(progressDelegate != nil) {
		request.uploadProgressDelegate = progressDelegate;
	}
	request.delegate = self;
	[request setDidFailSelector:@selector(addConferenceRequestFailed:)];
	[request setDidFinishSelector:@selector(addConferenceRequestFinished:)];
	[request startAsynchronous];
	
	// 2. Upload image associated with conference (only when there is an image)
	if(image != nil) {
		NSData *imageData = UIImagePNGRepresentation(image);
		ASIFormDataRequest *imageUploadRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:MCImageUploadURL]];
		[imageUploadRequest addData:imageData withFileName:conference.pictureLocation andContentType:@"image/png" forKey:@"data"];
		
		imageUploadRequest.uploadProgressDelegate = progressDelegate;
		imageUploadRequest.delegate = self;
		[imageUploadRequest startAsynchronous];
	}
}

#pragma mark ASIHTTPRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
	conferences = [[ConferencesParser loadConferencesFromString:[request responseString]] retain];
	DLog(@"conferences count == %d", conferences.conferenceList.count);
	[[NSNotificationCenter defaultCenter] postNotificationName:MCFinishedLoadingProjectsNotification object:self];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	
}

@end
