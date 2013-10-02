//
//  GFMenuViewController.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@class GFAppDelegate;

@interface GFMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISplitViewControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) UIViewController *detailViewController;

@property (nonatomic, assign) GFAppDelegate *appDelegate;

@end
