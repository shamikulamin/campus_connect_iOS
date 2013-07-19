//
//  AnnotationLocation.h
//  CampusConnect
//
//  Created by Shamikul Amin on 7/18/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AnnotationLocation : NSObject <MKAnnotation>

-(id)initWithName:(NSString*)title desc:(NSString*)desc coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem;

@end
