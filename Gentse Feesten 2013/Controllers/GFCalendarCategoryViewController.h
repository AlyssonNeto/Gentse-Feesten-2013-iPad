//
//  GFCalendarCategoryViewController.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GFCustomViewController.h"

@interface GFCalendarCategoryViewController : GFCustomViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *timestamp;

@end
