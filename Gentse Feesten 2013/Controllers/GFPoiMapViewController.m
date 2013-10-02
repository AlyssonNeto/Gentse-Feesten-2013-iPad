//
//  GFPoiMapViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 4/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "GFPoiMapViewController.h"

#import "GFCustomToolBar.h"
#import "GFAnnotation.h"

#import "AFNetworking.h"
#import "GFDatatankAPIClient.h"

#import "GFPoiDetailViewController.h"

@interface GFPoiMapViewController(){
    NSString *_path;
}


@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) NSMutableArray *responseData;

@end

@implementation GFPoiMapViewController

static BOOL haveAlreadyReceivedCoordinates;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (_calledFromNavigationController == YES) {
        [super calledFromNavigationController];
    }
    else {
        [self.navigationItem setHidesBackButton:YES animated:NO];
    }

    UIView *headerLabel = [super headerLabel:[NSLocalizedString(@"PUBLIC_TOILETS", nil) uppercaseString]];
    [self.view addSubview:headerLabel];

    UIImage *bodyTop = [UIImage imageNamed:@"tableTop.png"];
    UIImageView *bodyTopView = [[UIImageView alloc] initWithImage:bodyTop];
    bodyTopView.frame = CGRectMake(padding, headerLabel.frame.size.height + headerLabel.frame.origin.y + padding, bodyTop.size.width, bodyTop.size.height);
    [self.view addSubview:bodyTopView];

    UIView *myBackView = [[UIView alloc] initWithFrame:CGRectMake(padding, IS_IOS_7 ? 62 + navBarHeight : 62, self.view.frame.size.height - 320 - (padding * 2), self.view.frame.size.width - navBarHeight - (padding * 2) - 62)];
    myBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackground.png"]];
    [self.view addSubview:myBackView];

    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(padding * 2, IS_IOS_7 ? 67 + navBarHeight : 67, self.view.frame.size.height - 320 - (padding * 4) - 2, self.view.frame.size.width - navBarHeight - (padding * 3) - 62)];

    [_mapView setMapType:MKMapTypeStandard];
    [_mapView setZoomEnabled:YES];
    [_mapView setScrollEnabled:YES];
    [_mapView setDelegate:self];
    
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };

    region.center.latitude = 51.0540835;
    region.center.longitude = 3.7251482;
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [_mapView setRegion:region animated:YES];

    [self.locationManager startUpdatingLocation];
    
    [self.view addSubview:_mapView];

    UIView *footer = [super addTableViewFooter];
    footer.frame = CGRectMake(padding, myBackView.frame.origin.y + myBackView.frame.size.height, footer.frame.size.width, footer.frame.size.height);
    [self.view addSubview:footer];

    NSString *documentsDirectory = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    NSString *filename = @"public-toilets.plist";
    _path = [documentsDirectory stringByAppendingPathComponent:filename];

    _responseData = [NSMutableArray arrayWithContentsOfFile:_path];

    if (_responseData) {
        [self updateAnnotations];
    }
    else {

        [[GFDatatankAPIClient sharedInstance] getPath:@"Infrastructuur/PubliekSanitair.json" parameters:nil
                                              success:^(AFHTTPRequestOperation *operation, id response) {

                                                  _responseData = [NSMutableArray array];
                                                  for (id toilet in [response objectForKey:@"PubliekSanitair"]) {
                                                      [_responseData addObject:toilet];
                                                  }
                                                  [_responseData writeToFile:_path atomically:YES];       
                                                  [self updateAnnotations];

                                                  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              }
                                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                                                  [super showAlertNoInternetConnection];
                                                  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                          }];
    }
    self.trackedViewName = @"Toilets";

}

- (void)updateAnnotations {
    for (NSDictionary *toilet in _responseData) {
        GFAnnotation *annotation = [[GFAnnotation alloc] init];
        annotation.lat = [[toilet objectForKey:@"lat"] floatValue];
        annotation.lon = [[toilet objectForKey:@"long"] floatValue];
        annotation.price = [toilet objectForKey:@"prijs_toeg"];
        annotation.type = [toilet objectForKey:@"type_sanit"];
        annotation.open = [toilet objectForKey:@"openuren"];

        if ([[toilet objectForKey:@"situering"] length] > 0) {
            annotation.title = [toilet objectForKey:@"situering"];
        }
        else {
            annotation.title = [toilet objectForKey:@"type_locat"];
        }
        annotation.subtitle = [toilet objectForKey:@"openuren"];
        [_mapView addAnnotation:annotation];
    }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    CLLocation *locationGhent = [[CLLocation alloc] initWithLatitude:51.0540835 longitude:3.7251482];


    CLLocation *location = [locations lastObject];
    [self.locationManager stopUpdatingLocation];

    CLLocationDistance dist = [locationGhent distanceFromLocation:location];
    if ((int) dist > 5000) {
        if(!haveAlreadyReceivedCoordinates) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"WARNING", nil) message:NSLocalizedString(@"NOT_LOCATED_IN_GHENT", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    else {

        MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };

        region.center.latitude = location.coordinate.latitude;
        region.center.longitude = location.coordinate.longitude;
        region.span.longitudeDelta = 0.01f;
        region.span.latitudeDelta = 0.01f;

        [self.mapView setRegion:region animated:YES];

        GFAnnotation *annotation = [[GFAnnotation alloc] init];
        annotation.lat = location.coordinate.latitude;
        annotation.lon = location.coordinate.longitude;
        annotation.userLocation = YES;
        annotation.title = NSLocalizedString(@"YOUR_LOCATION", nil);
        [_mapView addAnnotation:annotation];
    }

    haveAlreadyReceivedCoordinates = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    self.locationManager = nil;
}

- (void)updateLocation {
    [self.locationManager startUpdatingLocation];
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(GFAnnotation*)annotation {

    static NSString *identifier = @"MyAnnotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];

    GFAnnotation *myAnnotation = (GFAnnotation*) annotation;

    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:identifier];

    }
    else {
        annotationView.annotation = annotation;
    }

    if (annotation.userLocation) {
        annotationView.pinColor = MKPinAnnotationColorPurple;
    }
    else {
        annotationView.pinColor = MKPinAnnotationColorRed;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        button.frame = CGRectMake(0, 0, 23, 23);
        
        annotationView.rightCalloutAccessoryView = button;
        
    }
    
    annotationView.canShowCallout = YES;
    
    return annotationView;
}


- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {

    GFPoiDetailViewController *detail = [[GFPoiDetailViewController alloc] initWithNibName:nil bundle:NULL];

    GFAnnotation *annotation = (GFAnnotation*) view.annotation;
    detail.latitude = annotation.lat;
    detail.longitude = annotation.lon;
    detail.label = [annotation.title uppercaseString];
    detail.open = annotation.open;
    detail.type = annotation.type;
    detail.price = annotation.price;
    [self.navigationController pushViewController:detail animated:YES];
    
}



- (UIBarButtonItem *)showMenuButton {

    UIImage *menuButtonImage = [UIImage imageNamed:@"list.png"];
    UIImage *menuButtonImageActive = [UIImage imageNamed:@"list.png"];
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [menuButton setBackgroundImage:menuButtonImage forState:UIControlStateNormal];
    [menuButton setBackgroundImage:menuButtonImageActive forState:UIControlStateHighlighted];

    [menuButton setFrame:CGRectMake(0, 0, menuButtonImage.size.width, menuButtonImage.size.height)];

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, menuButtonImage.size.width, menuButtonImage.size.height)];

    [menuButton addTarget:self
                   action:@selector(openMenuView:)
         forControlEvents:UIControlEventTouchDown];

    [containerView addSubview:menuButton];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    return item;
}

@end
