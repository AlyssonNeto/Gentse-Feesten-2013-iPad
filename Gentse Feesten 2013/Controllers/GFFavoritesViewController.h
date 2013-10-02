//
//  GFFavoritesViewController.h
//  #GF13
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <CoreData/CoreData.h>

#import <UIKit/UIKit.h>

#import "GFCustomViewController.h"

@interface GFFavoritesViewController : GFCustomViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
