//
//  GFParkingDetailViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 11/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

#import "GFParkingDetailViewController.h"
#import "MDCParallaxView.h"
#import "GFAnnotation.h"
#import "GFFontSmall.h"


@interface GFParkingDetailViewController () <UIScrollViewDelegate, MKMapViewDelegate>

@end

@implementation GFParkingDetailViewController

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

    self.trackedViewName = @"Parking detail";

    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height - 320, 480)];

    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];

    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = _latitude;
    region.center.longitude = _longitude;
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [mapView setRegion:region animated:YES];
    
    GFAnnotation *annotation = [[GFAnnotation alloc] init];
    annotation.lat = _latitude;
    annotation.lon = _longitude;
    [mapView addAnnotation:annotation];

    [mapView setDelegate:self];

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height - 320, 600)];
    containerView.backgroundColor = UIColorFromRGB(0x005470);

    UIView *headerLabel = [super headerLabel:[self.label uppercaseString]];

    if (IS_IOS_7) {
        headerLabel.frame = CGRectMake(headerLabel.frame.origin.x, headerLabel.frame.origin.y - 44, headerLabel.frame.size.width, headerLabel.frame.size.height);
    }

    [containerView addSubview:headerLabel];

    UIImage *bodyTop = [UIImage imageNamed:@"tableTop.png"];
    UIImageView *bodyTopView = [[UIImageView alloc] initWithImage:bodyTop];
    bodyTopView.frame = CGRectMake(padding, headerLabel.frame.size.height + headerLabel.frame.origin.y + padding, bodyTop.size.width, bodyTop.size.height);
    [containerView addSubview:bodyTopView];

    UIView *myBackView = [[UIView alloc] initWithFrame:CGRectMake(padding, bodyTopView.frame.size.height + bodyTopView.frame.origin.y, self.view.frame.size.height - 320 - (padding * 2), 200)];
    myBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackground.png"]];
    [containerView addSubview:myBackView];

    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(myBackView.frame.origin.x + padding, myBackView.frame.origin.y + padding, myBackView.frame.size.width - (padding * 2), [super getHeightForString:_description withWidth:myBackView.frame.size.width - (padding * 3)])];
    [description setLineBreakMode:UILineBreakModeWordWrap];
    description.font = [GFFontSmall sharedInstance];
    description.textColor = [UIColor darkGrayColor];
    description.backgroundColor = [UIColor clearColor];
    description.text = _description;
    description.numberOfLines = 0;
    [containerView addSubview:description];

    myBackView.frame = CGRectMake(myBackView.frame.origin.x, myBackView.frame.origin.y, myBackView.frame.size.width, description.frame.origin.y + description.frame.size.height - myBackView.frame.origin.y);

    UIView *footer = [super addTableViewFooter];
    footer.frame = CGRectMake(padding, myBackView.frame.origin.y + myBackView.frame.size.height, footer.frame.size.width, footer.frame.size.height);
    [containerView addSubview:footer];


    UIButton *routeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [routeButton addTarget:self
                    action:@selector(showRoute)
          forControlEvents:UIControlEventTouchDown];
    [routeButton setTitle:[NSLocalizedString(@"SHOW_ROUTE", nil) uppercaseString] forState:UIControlStateNormal];
    routeButton.frame = CGRectMake(padding, footer.frame.origin.y + (padding * 2), self.view.frame.size.height - 320 - (padding * 2), 55.0);
    routeButton.backgroundColor = UIColorFromRGB(0xed4e40);

    routeButton.layer.masksToBounds = NO;
    routeButton.layer.shadowColor = UIColorFromRGB(0x043c4b).CGColor;
    routeButton.layer.shadowOpacity = 1;
    routeButton.layer.shadowRadius = 0;
    routeButton.layer.shadowOffset = CGSizeMake(2.0f, 3.0f);

    [containerView addSubview:routeButton];

    containerView.frame = CGRectMake(containerView.frame.origin.x, containerView.frame.origin.y, containerView.frame.size.width, routeButton.frame.origin.y + routeButton.frame.size.height + (padding * 2) + 50);

    MDCParallaxView *parallaxView = [[MDCParallaxView alloc] initWithBackgroundView:mapView
                                                                     foregroundView:containerView];
    parallaxView.frame = CGRectMake(0, IS_IOS_7 ? 44 : 0, self.view.frame.size.height - 320, self.view.frame.size.width);
    parallaxView.backgroundHeight = 0.0f;
    parallaxView.scrollView.scrollsToTop = YES;
    parallaxView.scrollViewDelegate = self;
    parallaxView.tag = 1;
    [self.view addSubview:parallaxView];

    UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;

}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    MDCParallaxView *parallaxView = (MDCParallaxView *) [self.view viewWithTag:1];
    parallaxView.backgroundHeight = 140.0f;
}

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView {
    MDCParallaxView *parallaxView = (MDCParallaxView *) [self.view viewWithTag:1];
    parallaxView.backgroundHeight = 140.0f;
}

- (void)showRoute
{
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(_latitude, _longitude);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:_label];
        
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                       launchOptions:launchOptions];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
