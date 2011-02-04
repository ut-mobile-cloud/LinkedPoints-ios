//
//  MCConferencesController.m
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 Indilo Wireless. All rights reserved.
//

#import "MCConferencesController.h"
#import "Conferences.h"
#import "Conference.h"
#import "MCConferenceManager.h"
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
	DLog(@"Ridu : %d", rows);
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
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	ConferenceController *conferenceController = [[ConferenceController alloc] initWithNibName:@"ConferenceController" bundle:nil];
//	conferenceController.conference = [conferences.conferenceList objectAtIndex:indexPath.row];
//	[self.navigationController pushViewController:conferenceController animated:YES];
//	[conferenceController release];
//}

# pragma mark UIViewController
- (void)viewDidLoad
{
	[super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(projectsLoaded:) name:MCFinishedLoadingProjectsNotification object:nil];
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
