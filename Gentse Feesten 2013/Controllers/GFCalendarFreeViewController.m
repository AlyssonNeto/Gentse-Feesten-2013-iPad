//
//  GFCalendarFreeViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFCalendarFreeViewController.h"

@interface GFCalendarFreeViewController ()

@end

@implementation GFCalendarFreeViewController

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

    [self.view addSubview:[super headerLabel:[NSLocalizedString(@"FREE", nil) uppercaseString]]];
    [super calledFromNavigationController];

    self.trackedViewName = @"Program free";
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
