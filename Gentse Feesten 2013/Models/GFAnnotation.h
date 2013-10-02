//
//  GFAnnotation.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 12/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GFAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic) float lat;
@property (nonatomic) float lon;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *open;

@property (nonatomic) BOOL userLocation;

@end
