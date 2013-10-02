//
//  GFCustomEventCell.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 3/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import <UIKit/UIKit.h>

@interface GFCustomEventCell : UITableViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CALayer *bottomBorder;

-(void)setupBottomBorder;

@end
