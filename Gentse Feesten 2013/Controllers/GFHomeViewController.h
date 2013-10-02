//
//  GFHomeViewController.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <CoreData/CoreData.h>

#import <UIKit/UIKit.h>

#import "GFCustomViewController.h"

@interface GFHomeViewController : GFCustomViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, NSFetchedResultsControllerDelegate, UISplitViewControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
