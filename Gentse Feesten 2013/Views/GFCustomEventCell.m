//
//  GFCustomEventCell.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 3/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "GFFontSmall.h"
#import "GFCustomEventCell.h"

@implementation GFCustomEventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
        self.accessoryType = UITableViewCellAccessoryNone;
        [self setupLabel];
        [self setupTimeLabel];
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

    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    [_label setLineBreakMode:UILineBreakModeWordWrap];
    _label.font = [GFFontSmall sharedInstance];
    _label.textColor = [UIColor darkGrayColor];
    _label.highlightedTextColor = [UIColor whiteColor];
    _label.backgroundColor = [UIColor clearColor];
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.numberOfLines = 0;
    [_containerView addSubview:_label];
}


- (void)setupTimeLabel {
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding / 2, 6, 50, self.frame.size.height)];
    [_timeLabel setLineBreakMode:UILineBreakModeWordWrap];
    _timeLabel.font = [GFFontSmall sharedInstance];
    _timeLabel.textColor = UIColorFromRGB(0xed4e40);
    _timeLabel.highlightedTextColor = [UIColor whiteColor];
    _timeLabel.backgroundColor = [UIColor clearColor];
    [_containerView addSubview:_timeLabel];
}


- (void)setupBottomBorder {
    _bottomBorder = [CALayer layer];
    _bottomBorder.frame = CGRectZero;
    _bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                     alpha:1.0f].CGColor;
    [_containerView.layer addSublayer:_bottomBorder];
}


@end
