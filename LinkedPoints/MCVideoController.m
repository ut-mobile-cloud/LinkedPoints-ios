//
//  MCVideoController.m
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/4/11.
//  Copyright 2011 Indilo Wireless. All rights reserved.
//

#import "MCVideoController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Conference.h"
#import "MCConferenceManager.h"
#import "Conferences.h"

@implementation MCVideoController
@synthesize movieViewPlace;
@synthesize conference;
@synthesize moviePlayer;

- (IBAction)playFirst:(id)sender {
	NSURL *nextMovieURL = [[MCConferenceManager sharedManager] nextVideoForConference:self.conference URL:nil];
	if(nextMovieURL != nil) {
		self.moviePlayer.contentURL = nextMovieURL;
		[self.moviePlayer play];
	}
}

- (IBAction)playNext:(id)sender
{
	NSURL *nextMovieURL = [[MCConferenceManager sharedManager] nextVideoForConference:self.conference URL:self.moviePlayer.contentURL];
	if(nextMovieURL != nil) {
		self.moviePlayer.contentURL = nextMovieURL;
		[self.moviePlayer play];
	} else {
		DLog(@"No more movies left to play");
	}
}

- (void)movieDidFinish:(NSNotification *)notification
{
	DLog(@"Movie player did finish");
	NSURL *nextMovieURL = [[MCConferenceManager sharedManager] nextVideoForConference:self.conference URL:self.moviePlayer.contentURL];
	if(nextMovieURL != nil) {
		[self.moviePlayer play];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
	// TODO: should request next video and start playing. If no next video is available, should return to previous screen
	//[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(movieDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.moviePlayer = [[MPMoviePlayerController alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.moviePlayer stop];
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.moviePlayer.view.frame = CGRectMake(0, 0, self.movieViewPlace.bounds.size.width, self.movieViewPlace.bounds.size.height);
	self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[self.movieViewPlace addSubview:self.moviePlayer.view];
	NSURL *movieURL = [[MCConferenceManager sharedManager] nextVideoForConference:self.conference URL:self.moviePlayer.contentURL];
	self.moviePlayer.contentURL = movieURL;
	[self.moviePlayer play];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self.moviePlayer stop];
	[self.moviePlayer release];
	[conference release];
    [movieViewPlace release];
    [super dealloc];
}

@end
