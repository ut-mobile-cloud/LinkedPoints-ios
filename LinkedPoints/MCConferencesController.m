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
    static NSString *cellIdentifier = @"<#MyCell#>";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
    }
	Conference *conference = [self.conferences.conferenceList objectAtIndex:indexPath.row];
	DLog(@"made cell for conference : %@", conference.title);
	cell.textLabel.text = conference.title;
	
    return cell;
}


#pragma mark UITableViewDelegate
// All method optional
// - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
// - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
// - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
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
- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [conferencesTable release];
    [super dealloc];
}

@end
