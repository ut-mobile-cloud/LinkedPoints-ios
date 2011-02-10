//
//  Conference.h
//  VideoStreaming
//
//  Created by Madis Nõmme on 2/1/11.
//  Copyright 2011 MobileCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Conference : NSObject<MKAnnotation> {
@private
	int m_ID;
	NSString *m_title;
	NSString *m_place;
	NSString *m_owner;
	NSString *m_pictureLocation;
	float m_latitude;
	float m_longitude;
    
}
@property (nonatomic, assign) int ID;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *place;
@property (nonatomic, retain) NSString *owner;
@property (nonatomic, retain) NSString *pictureLocation;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) NSString *subtitle;

- (id)initWithID:(int)ID title:(NSString *)title place:(NSString *)place owner:(NSString *)owner picture:(NSString *)picture latitude:(float)latitude longitude:(float)longitude;

@end
