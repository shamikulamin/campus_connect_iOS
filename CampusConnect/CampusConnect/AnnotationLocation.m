
//
//  AnnotationLocation.m
//  CampusConnect
//
//  Created by Shamikul Amin on 7/18/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "AnnotationLocation.h"
#import <AddressBook/AddressBook.h>

@interface AnnotationLocation()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;

@end
@implementation AnnotationLocation


-(id)initWithName:(NSString *)title desc:(NSString *)desc coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        if ([title isKindOfClass:[NSString class]]) {
            self.title = title;
        }
        self.desc = desc;
        self.theCoordinate = coordinate;
    }
    return self;
}

-(NSString *)title {
    return _title;
}

-(NSString *)subtitle {
    return _desc;
}

-(CLLocationCoordinate2D)coordinate {
    return _theCoordinate;
}

-(MKMapItem *)mapItem {
    
    NSDictionary *descDict = @{(NSString *)kABPersonAddressStreetKey : _desc};
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:descDict];
    
    MKMapItem *mapitem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapitem.name = self.title;
    
    return mapitem;
}

@end