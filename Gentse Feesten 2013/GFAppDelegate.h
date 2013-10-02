//
//  GFAppDelegate.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GAI.h"

#import "GFMenuViewController.h"
#import "GFNavigationViewController.h"

@interface GFAppDelegate : UIResponder <UIApplicationDelegate> 

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UISplitViewController *splitViewController;

@property (nonatomic, strong) GFMenuViewController *menuViewController;

@end
