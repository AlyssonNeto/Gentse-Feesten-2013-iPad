//
//  GFEventDetailViewController.m
//  #GF13
//
//  Created by Tim Leytens on 15/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

#import "GFEventDetailViewController.h"

#import "MDCParallaxView.h"
#import "GFAnnotation.h"
#import "GFFontSmall.h"
#import "GFDates.h"
#import "GFWebViewController.h"
#import "GFEventsDataModel.h"

@interface GFEventDetailViewController () <UIScrollViewDelegate, MKMapViewDelegate>

@end

@implementation GFEventDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.trackedViewName = [NSString stringWithFormat:@"Detail event: %@", _event.name];

    if (_calledFromNavigationController == YES) {
        [super calledFromNavigationController];
    }
    else {
        [self.navigationItem setHidesBackButton:YES animated:NO];
    }

    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height - 320, 480)];

    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:NO];
    [mapView setScrollEnabled:NO];

    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [_event.lat floatValue];
    region.center.longitude = [_event.lon floatValue];
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [mapView setRegion:region animated:NO];

    GFAnnotation *annotation = [[GFAnnotation alloc] init];
    annotation.lat = [_event.lat floatValue];
    annotation.lon = [_event.lon floatValue];
    [mapView addAnnotation:annotation];

    [mapView setDelegate:self];

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height - 320, 600)];
    containerView.backgroundColor = UIColorFromRGB(0x005470);

    GFCustomYellowLabel *headerLabel = [[GFCustomYellowLabel alloc] initWithFrame:CGRectMake(padding, IS_IOS_7 ? 20 + navBarHeight : 20, self.view.frame.size.height - 320 - padding * 2, 28)];
    headerLabel.text = [_event.name uppercaseString];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.backgroundColor = UIColorFromRGB(0x005470);
    headerLabel.numberOfLines = 0;
  
    headerLabel.frame = CGRectMake(headerLabel.frame.origin.x, headerLabel.frame.origin.y, headerLabel.frame.size.width, [super getHeightForHeader:[_event.name uppercaseString] withWidth:headerLabel.frame.size.width]);

    if (IS_IOS_7) {
        headerLabel.frame = CGRectMake(headerLabel.frame.origin.x, headerLabel.frame.origin.y - 44, headerLabel.frame.size.width, headerLabel.frame.size.height);
    }

    [containerView addSubview:headerLabel];

    UIImage *bodyTop = [UIImage imageNamed:@"tableTop.png"];
    UIImageView *bodyTopView = [[UIImageView alloc] initWithImage:bodyTop];
    bodyTopView.frame = CGRectMake(padding, headerLabel.frame.size.height + headerLabel.frame.origin.y + padding, bodyTop.size.width, bodyTop.size.height);
    [containerView addSubview:bodyTopView];

    UIView *myBackView = [[UIView alloc] initWithFrame:CGRectMake(padding, bodyTopView.frame.size.height + bodyTopView.frame.origin.y, self.view.frame.size.height - 320 - (padding * 2), 400)];
    myBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackground.png"]];
    [containerView addSubview:myBackView];

    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(myBackView.frame.origin.x + (padding * 2), myBackView.frame.origin.y, 60, 57)];
    [dateLabel setLineBreakMode:UILineBreakModeWordWrap];
    dateLabel.font = [GFFontSmall sharedInstance];
    dateLabel.textColor = UIColorFromRGB(0xed4e40);
    dateLabel.backgroundColor = [UIColor whiteColor];
    dateLabel.text = NSLocalizedString(@"DATE", nil);
    [containerView addSubview:dateLabel];

    NSString *datum = nil;
    for (id date in [GFDates sharedInstance]) {
        if ([[date objectForKey:@"id"] isEqualToString:_event.datum]) {
            datum = [date objectForKey:@"name"];
        }
    }

    datum = [datum stringByAppendingFormat:@"\n%@", _event.periode];

    UILabel *dateText = [[UILabel alloc] initWithFrame:CGRectMake(dateLabel.frame.origin.x + padding + dateLabel.frame.size.width, myBackView.frame.origin.y, myBackView.frame.size.width - (padding * 4) - dateLabel.frame.size.width, [super getHeightForString:datum withWidth:myBackView.frame.size.width - (padding * 4) - dateLabel.frame.size.width] + 30)];
    [dateText setLineBreakMode:UILineBreakModeWordWrap];
    dateText.font = [GFFontSmall sharedInstance];
    dateText.textColor = [UIColor darkGrayColor];
    dateText.backgroundColor = [UIColor whiteColor];
    dateText.text = datum;
    dateText.numberOfLines = 0;
    [containerView addSubview:dateText];

    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(padding * 2, dateText.frame.size.height + dateText.frame.origin.y, myBackView.frame.size.width - 2 - (padding * 2), 1);
    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                     alpha:1.0f].CGColor;

    [containerView.layer addSublayer:bottomBorder];


    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(myBackView.frame.origin.x + (padding * 2), bottomBorder.frame.origin.y + 1, 60, 57)];
    [priceLabel setLineBreakMode:UILineBreakModeWordWrap];
    priceLabel.font = [GFFontSmall sharedInstance];
    priceLabel.textColor = UIColorFromRGB(0xed4e40);
    priceLabel.backgroundColor = UIColorFromRGB(0xf5f5f5);
    priceLabel.text = NSLocalizedString(@"PRICE", nil);
    [containerView addSubview:priceLabel];

    NSString *price = nil;
    
    if ([_event.gratis boolValue] == YES) {
        price = NSLocalizedString(@"FREE", nil);
    }
    else {
        price = _event.prijs;
        if ([price isEqualToString:@""]) {
            price = @" ";
        }
    }

    UILabel *priceText = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel.frame.origin.x + padding + priceLabel.frame.size.width, priceLabel.frame.origin.y, myBackView.frame.size.width - (padding * 5) - priceLabel.frame.size.width, [super getHeightForString:price withWidth:myBackView.frame.size.width - (padding * 5) - priceLabel.frame.size.width] + 30)];
    [priceText setLineBreakMode:UILineBreakModeWordWrap];
    priceText.font = [GFFontSmall sharedInstance];
    priceText.textColor = [UIColor darkGrayColor];
    priceText.backgroundColor = UIColorFromRGB(0xf5f5f5);
    priceText.text = price;
    priceText.numberOfLines = 0;
    [containerView addSubview:priceText];

    UIView *priceBackView = [[UIView alloc] initWithFrame:CGRectMake(myBackView.frame.origin.x + padding, priceLabel.frame.origin.y, myBackView.frame.size.width - 2 - (padding * 2), priceText.frame.size.height)];
    priceBackView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [containerView insertSubview:priceBackView belowSubview:priceLabel];

    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.frame = CGRectMake(padding * 2, priceText.frame.size.height + priceText.frame.origin.y, myBackView.frame.size.width - 2 - (padding * 2), 1);
    bottomBorder2.backgroundColor = [UIColor colorWithWhite:0.8f
                                                      alpha:1.0f].CGColor;

    [containerView.layer addSublayer:bottomBorder2];

    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(myBackView.frame.origin.x + (padding * 2), bottomBorder2.frame.origin.y + 1, 60, 57)];
    [locationLabel setLineBreakMode:UILineBreakModeWordWrap];
    locationLabel.font = [GFFontSmall sharedInstance];
    locationLabel.textColor = UIColorFromRGB(0xed4e40);
    locationLabel.backgroundColor = [UIColor whiteColor];
    locationLabel.text = NSLocalizedString(@"EVENT_LOCATION", nil);
    [containerView addSubview:locationLabel];


    UILabel *locationText = [[UILabel alloc] initWithFrame:CGRectMake(locationLabel.frame.origin.x + padding + locationLabel.frame.size.width, locationLabel.frame.origin.y, myBackView.frame.size.width - (padding * 5) - locationLabel.frame.size.width, [super getHeightForString:_event.loc withWidth:myBackView.frame.size.width - (padding * 5) - locationLabel.frame.size.width] + 30)];
    [locationText setLineBreakMode:UILineBreakModeWordWrap];
    locationText.font = [GFFontSmall sharedInstance];
    locationText.textColor = [UIColor darkGrayColor];
    locationText.backgroundColor = [UIColor whiteColor];
    locationText.text = _event.loc;
    locationText.numberOfLines = 0;
    [containerView addSubview:locationText];

    CALayer *bottomBorder3 = [CALayer layer];
    bottomBorder3.frame = CGRectMake(padding * 2, locationText.frame.size.height + locationText.frame.origin.y, myBackView.frame.size.width - 2 - (padding * 2), 1);
    bottomBorder3.backgroundColor = [UIColor colorWithWhite:0.8f
                                                      alpha:1.0f].CGColor;

    [containerView.layer addSublayer:bottomBorder3];

    CALayer *bottomBorder4 = nil;

    if ([_event.omschrijving length] != 0) {

    UILabel *descriptionText = [[UILabel alloc] initWithFrame:CGRectMake(myBackView.frame.origin.x + (padding * 2), bottomBorder3.frame.origin.y + 1, myBackView.frame.size.width - 2 - (padding * 4), [super getHeightForString:_event.omschrijving withWidth:myBackView.frame.size.width - 2 - (padding * 4)] + 30)];
    [descriptionText setLineBreakMode:UILineBreakModeWordWrap];
    descriptionText.font = [GFFontSmall sharedInstance];
    descriptionText.textColor = [UIColor darkGrayColor];
    descriptionText.backgroundColor = [UIColor whiteColor];
    descriptionText.text = _event.omschrijving;
    descriptionText.numberOfLines = 0;
    [containerView addSubview:descriptionText];

    bottomBorder4 = [CALayer layer];
    bottomBorder4.frame = CGRectMake(padding * 2, descriptionText.frame.size.height + descriptionText.frame.origin.y, myBackView.frame.size.width - 2 - (padding * 2), 1);
    bottomBorder4.backgroundColor = [UIColor colorWithWhite:0.8f
                                                      alpha:1.0f].CGColor;

    [containerView.layer addSublayer:bottomBorder4];

    }


    UIImage *favButtonImage = [UIImage imageNamed:@"fav_detail_inactive.png"];
    UIImage *favButtonImageActive = [UIImage imageNamed:@"fav_detail_active.png"];
    UIButton *favButton = [UIButton buttonWithType:UIButtonTypeCustom];

    if ([_event.fav isEqualToNumber:[NSNumber numberWithInt:1]]) {
        favButton.selected = YES;
    }
    else {
        favButton.selected = NO;
    }

    [favButton setBackgroundImage:favButtonImage forState:UIControlStateNormal];
    [favButton setBackgroundImage:favButtonImageActive forState:UIControlStateSelected];
    
    if ([_event.omschrijving length] != 0) {
        [favButton setFrame:CGRectMake(myBackView.frame.size.width - favButtonImage.size.width - 2, bottomBorder4.frame.origin.y + padding, favButtonImage.size.width, favButtonImage.size.height)];
    }
    else {
        [favButton setFrame:CGRectMake(myBackView.frame.size.width - favButtonImage.size.width - 2, bottomBorder3.frame.origin.y + padding, favButtonImage.size.width, favButtonImage.size.height)];
    }

    [favButton addTarget:self
                  action:@selector(addEventToFavorites:)
        forControlEvents:UIControlEventTouchDown];
    [containerView addSubview:favButton];


    myBackView.frame = CGRectMake(myBackView.frame.origin.x, myBackView.frame.origin.y, myBackView.frame.size.width, favButton.frame.origin.y + favButton.frame.size.height - myBackView.frame.origin.y + padding);

    UIView *footer = [super addTableViewFooter];
    footer.frame = CGRectMake(padding, myBackView.frame.origin.y + myBackView.frame.size.height, footer.frame.size.width, footer.frame.size.height);
    [containerView addSubview:footer];

    UIButton *routeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [routeButton addTarget:self
                    action:@selector(showRoute)
          forControlEvents:UIControlEventTouchDown];
    [routeButton setTitle:[NSLocalizedString(@"SHOW_ROUTE", nil) uppercaseString] forState:UIControlStateNormal];
    routeButton.frame = CGRectMake(padding, footer.frame.origin.y + (padding * 2), (self.view.frame.size.height - 320 - (padding * 2)) / 2 - 10, 55.0);
    routeButton.backgroundColor = UIColorFromRGB(0xed4e40);

    routeButton.layer.masksToBounds = NO;
    routeButton.layer.shadowColor = UIColorFromRGB(0x043c4b).CGColor;
    routeButton.layer.shadowOpacity = 1;
    routeButton.layer.shadowRadius = 0;
    routeButton.layer.shadowOffset = CGSizeMake(2.0f, 3.0f);

    [containerView addSubview:routeButton];

    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton addTarget:self
                   action:@selector(goToWebsite:)
          forControlEvents:UIControlEventTouchDown];
    [infoButton setTitle:[NSLocalizedString(@"MORE_INFO_ONLINE", nil) uppercaseString] forState:UIControlStateNormal];
    infoButton.frame = CGRectMake((padding * 3) + routeButton.frame.size.width, footer.frame.origin.y + (padding * 2), (self.view.frame.size.height - 320 - (padding * 2)) / 2 - 10, 55.0);
    infoButton.backgroundColor = UIColorFromRGB(0xed4e40);

    infoButton.layer.masksToBounds = NO;
    infoButton.layer.shadowColor = UIColorFromRGB(0x043c4b).CGColor;
    infoButton.layer.shadowOpacity = 1;
    infoButton.layer.shadowRadius = 0;
    infoButton.layer.shadowOffset = CGSizeMake(2.0f, 3.0f);

    [containerView addSubview:infoButton];

    containerView.frame = CGRectMake(containerView.frame.origin.x, containerView.frame.origin.y, containerView.frame.size.width, infoButton.frame.origin.y + infoButton.frame.size.height + (padding * 2) + 50);


    MDCParallaxView *parallaxView = [[MDCParallaxView alloc] initWithBackgroundView:mapView
                                                                     foregroundView:containerView];
    parallaxView.frame = CGRectMake(0, IS_IOS_7 ? 44 : 0, self.view.frame.size.height - 320, self.view.frame.size.width);
    parallaxView.backgroundHeight = 0.0f;
    parallaxView.scrollView.scrollsToTop = YES;
    parallaxView.scrollViewDelegate = self;
    parallaxView.tag = 1;
    [self.view addSubview:parallaxView];


    
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    MDCParallaxView *parallaxView = (MDCParallaxView *) [self.view viewWithTag:1];
    parallaxView.backgroundHeight = 140.0f;
}

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView {
    MDCParallaxView *parallaxView = (MDCParallaxView *) [self.view viewWithTag:1];
    parallaxView.backgroundHeight = 140.0f;
}

- (void)goToWebsite:(UIButton*)button
{
    GFWebViewController *webView = [[GFWebViewController alloc] initWithNibName:nil bundle:NULL];
    webView.url = [NSString stringWithFormat:@"http://www.gentsefeesten.be/nl/event/%@", _event.serverId];
    [self presentViewController:webView animated:YES completion:nil];
}

- (void)showRoute
{
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([_event.lat floatValue], [_event.lon floatValue]);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:_event.name];

        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                       launchOptions:launchOptions];
    }
}

- (void)dismissModal:(id)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addEventToFavorites:(UIButton*)sender
{
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:[[GFEventsDataModel sharedDataModel] persistentStoreCoordinator]];

    NSInteger serverId = [_event.serverId intValue];
    GFEvent *event = [GFEvent eventWithServerId:serverId usingManagedObjectContext:context];
    sender.selected = !sender.selected;
    [event toggleFavorite:sender.selected];
    [context save:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
