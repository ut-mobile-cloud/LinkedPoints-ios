//
//  MCConferenceDetailsController.h
//  LinkedPoints
//
//  Created by Madis Nõmme on 2/4/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Conference;
@interface MCConferenceDetailsController : UIViewController<UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
@private
    
	UITextField *conferenceTitle;
	UITextField *place;
	UITextField *latitude;
	UITextField *longitude;
	Conference *conference;
	UIImageView *image;
	UITapGestureRecognizer *tapGesture;
}
@property (nonatomic, retain) IBOutlet UITextField *conferenceTitle;
@property (nonatomic, retain) IBOutlet UITextField *place;
@property (nonatomic, retain) IBOutlet UITextField *latitude;
@property (nonatomic, retain) IBOutlet UITextField *longitude;
@property (nonatomic, retain) Conference *conference;
@property (nonatomic, retain) IBOutlet UIImageView *image;

- (IBAction)donePushed:(id)sender;

@end
