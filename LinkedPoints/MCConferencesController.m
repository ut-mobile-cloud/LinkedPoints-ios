//
//  MCConferencesController.m
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import "MCConferencesController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Conferences.h"
#import "Conference.h"
#import "MCConferenceManager.h"
#import "MCVideoController.h"

@implementation MCConferencesController
@synthesize conferencesTable;

@dynamic conferences;
- (Conferences *)conferences
{
	return [MCConferenceManager sharedManager].conferences;
}

- (void)projectsLoaded:(NSNotification *)notification
{
	[self.conferencesTable reloadData];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = self.conferences.conferenceList.count;
	return rows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger sections = 1;
	return sections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ConferenceCellReuseIdentifier";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
	Conference *conference = [self.conferences.conferenceList objectAtIndex:indexPath.row];
	cell.textLabel.text = conference.title;
	cell.detailTextLabel.text = conference.place;
	// TODO: load this image from cloud. Ideally should be done like so
	// UIImageView *conferenceImage = [[UIImageView alloc] initWithImage:[conference.image]];
	// Right now placeholder image will be used
	UIImage *contentViewImage = [UIImage imageNamed:@"conference.gif"];
	UIImageView *conferenceImageView = [[UIImageView alloc] initWithImage:contentViewImage];
	conferenceImageView.frame = CGRectMake(0, 0, 40, 40);
	cell.accessoryView = conferenceImageView;
	[conferenceImageView release];
	
    return cell;
}


#pragma mark UITableViewDelegate

- (void)movieDidFinish:(id)sender
{
	DLog(@"Movie did finish");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MCVideoController *videoController = [[MCVideoController alloc] initWithNibName:@"MCVideoController" bundle:nil];
	Conference *selectedConference = [[MCConferenceManager sharedManager].conferences.conferenceList objectAtIndex:indexPath.row];
	videoController.conference = selectedConference;
	[self.navigationController pushViewController:videoController animated:YES];
	[videoController release];
	
}

# pragma mark UIViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationItem.title = @"Your conferences";
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(projectsLoaded:) name:MCFinishedLoadingProjectsNotification object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation != UIInterfaceOrientationPortrait) {
		return NO;
	}
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[[MCConferenceManager sharedManager] startLoadingConferences];
}

#pragma mark NSObject

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [conferencesTable release];
    [super dealloc];
}

@end
