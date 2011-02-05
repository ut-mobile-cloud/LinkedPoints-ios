//
//  MCConferenceDetailsController.m
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/4/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import "MCConferenceDetailsController.h"
#import "Conference.h"

@implementation MCConferenceDetailsController
@synthesize conferenceTitle;
@synthesize place;
@synthesize latitude;
@synthesize longitude;
@synthesize conference;
@synthesize image;

- (void)pickImage:(UIGestureRecognizer *)gestureRecognizer
{
	DLog(@"Will start picking image");
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self presentModalViewController:imagePicker animated:YES];
	[imagePicker release];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	// Will be called when textField is being asked to resign it's first responder status
	DLog(@"shouldEndEditing");
	return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// Called whenever user taps the return button
	DLog(@"Should return");
	[textField resignFirstResponder];
	if(textField == self.conferenceTitle) {
		DLog(@"and it will");
//		[textField resignFirstResponder];
		[self.place becomeFirstResponder];
	}
	return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	// Called after textField resigns it's first responder status
	// TODO: possibly put entered text into conference object (or this could be done in donePushed:)
}
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissModalViewControllerAnimated:YES];
	self.image.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickImage:)];
    }
    return self;
}

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.image addGestureRecognizer:tapGesture];
	[self.conferenceTitle becomeFirstResponder];
}
- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[self.image removeGestureRecognizer:tapGesture];
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

- (IBAction)donePushed:(id)sender {
	// TODO: Do the saving so that ConferenceManager will have all necessary data after leaving this view
	self.conference.title = self.conferenceTitle.text;
	self.conference.place = self.place.text;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.8];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view.superview cache:YES];
	[self.view removeFromSuperview];
	[UIView commitAnimations];
}

#pragma mark NSObject

- (void)dealloc
{
	[conference release];
	[conferenceTitle release];
	[place release];
	[latitude release];
	[longitude release];
	[image release];
    [super dealloc];
}


@end
