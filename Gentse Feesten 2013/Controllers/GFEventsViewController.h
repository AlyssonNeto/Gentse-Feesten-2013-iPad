//
//  GFEventsViewController.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 2/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

#import "GFCustomViewController.h"

@interface GFEventsViewController : GFCustomViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) NSString *timestamp;

@property (nonatomic, strong) NSString *programType;

@property (nonatomic, strong) NSString *screenTitle;

@property (nonatomic) int categoryID;

@property (nonatomic) int locationID;

@end
