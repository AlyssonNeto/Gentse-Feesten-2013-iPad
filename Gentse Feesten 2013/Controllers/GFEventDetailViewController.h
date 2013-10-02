//
//  GFEventDetailViewController.h
//  #GF13
//
//  Created by Tim Leytens on 15/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GFCustomViewController.h"

#import "GFEvent.h"

@interface GFEventDetailViewController : GFCustomViewController

@property(nonatomic, strong) GFEvent *event;

@property (nonatomic) BOOL calledFromNavigationController;

@end
