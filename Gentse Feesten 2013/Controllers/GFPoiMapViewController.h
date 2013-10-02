//
//  GFPoiMapViewController.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 4/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>

#import "GFCustomViewController.h"

@interface GFPoiMapViewController : GFCustomViewController <MKMapViewDelegate, MKAnnotation, CLLocationManagerDelegate>

@property (nonatomic) BOOL calledFromNavigationController;

@end
