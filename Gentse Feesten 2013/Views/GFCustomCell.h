//
//  GFCustomCell.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 12/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFCustomCell : UITableViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *containerView;

-(void)setupBottomBorder;

@end
