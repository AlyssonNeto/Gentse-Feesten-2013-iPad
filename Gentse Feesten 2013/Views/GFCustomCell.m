//
//  GFCustomCell.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 12/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "GFCustomCell.h"
#import "GFFontSmall.h"


@implementation GFCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _containerView = [[UIView alloc] initWithFrame:CGRectMake(padding, 0, [[UIScreen mainScreen] bounds].size.height - 320 - (padding * 4) - 2, 55)];
        self.accessoryType = UITableViewCellAccessoryNone;
        [self setupLabel];
        [self setupBottomBorder];
        [self setupBackground];
        [self.contentView addSubview:_containerView];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    UIView *mySelectedBackView = [[UIView alloc] initWithFrame:CGRectMake(padding * 2, 0, _containerView.frame.size.width, self.frame.size.height)];
    mySelectedBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"selectedBack.png"]];
    self.selectedBackgroundView = mySelectedBackView;
}


- (void)setupBackground {
    UIView *myBackView = [[UIView alloc] initWithFrame:self.frame];
    myBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackground.png"]];
    self.backgroundView = myBackView;
}


- (void)setupLabel {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, _containerView.frame.size.width - (padding * 2), 55)];
    _label.font = [GFFontSmall sharedInstance];
    _label.textColor = [UIColor darkGrayColor];
    _label.highlightedTextColor = [UIColor whiteColor];
    _label.backgroundColor = [UIColor clearColor];
    [_containerView addSubview:_label];
}


- (void)setupBottomBorder {
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, 55, _containerView.frame.size.width, 1);
    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                     alpha:1.0f].CGColor;
    [_containerView.layer addSublayer:bottomBorder];
}

@end
