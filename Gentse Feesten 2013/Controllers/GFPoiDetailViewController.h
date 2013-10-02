//
//  GFPoiDetailViewController.h
//  #GF13
//
//  Created by Tim Leytens on 14/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GFCustomViewController.h"

@interface GFPoiDetailViewController : GFCustomViewController

@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *open;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

@end
