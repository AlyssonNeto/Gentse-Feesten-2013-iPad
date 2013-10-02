//
//  GFLocationViewController.h
//  #GF13
//
//  Created by Tim Leytens on 22/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFCustomViewController.h"

@interface GFLocationViewController : GFCustomViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *timestamp;

@end
