//
//  GFParkingDetailViewController.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 11/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GFCustomViewController.h"

@interface GFParkingDetailViewController : GFCustomViewController

@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *description;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

@end
