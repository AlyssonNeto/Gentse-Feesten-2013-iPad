//
//  GFCalendarFestivalViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFCalendarFestivalViewController.h"

@interface GFCalendarFestivalViewController ()

@end

@implementation GFCalendarFestivalViewController

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

    [self.view addSubview:[super headerLabel:[NSLocalizedString(@"FESTVALS", nil) uppercaseString]]];

    [super calledFromNavigationController];
    
    self.trackedViewName = @"Program festival";

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
