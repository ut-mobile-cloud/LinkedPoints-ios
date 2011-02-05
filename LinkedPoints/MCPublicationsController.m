//
//  MCPublicationsController.m
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/3/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import "MCPublicationsController.h"
#import "ASIHTTPRequest.h"
#import "Publication.h"
#import "Publications.h"
#import "PublicationsParser.h"

static int HTTP_STATUS_CODE_OK = 200;
static NSString *MCPublicationsServletURL = @"http://ec2-46-137-15-183.eu-west-1.compute.amazonaws.com:8080/EC2RunInstance/GetPublications";

@implementation MCPublicationsController
@synthesize publicationsTable;
@synthesize publications;

#pragma mark ASIHTTPRequestDelegate
- (void)requestFailed:(ASIHTTPRequest *)request
{
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	if([request responseStatusCode] == HTTP_STATUS_CODE_OK) {
		self.publications = [PublicationsParser loadPublicationsFromString:[request responseString]];
		[self.publicationsTable reloadData];
	}	
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = self.publications.publicationList.count;
	return rows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger sections = 1;
	return sections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"PublicationCellIdentifier";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
	
    Publication *publication = [self.publications.publicationList objectAtIndex:indexPath.row];
	cell.textLabel.text = publication.title;
	cell.detailTextLabel.text = publication.date;
	
    return cell;
}


#pragma mark UITableViewDelegate
// All method optional
// - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
// - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
// - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
// - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)viewDidLoad
{
    [super viewDidLoad];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:MCPublicationsServletURL]];
	request.delegate = self;
	[request startAsynchronous];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark UIViewController
#pragma mark NSObject
- (void)dealloc
{
	[publications release];
    [publicationsTable release];
    [super dealloc];
}
@end
