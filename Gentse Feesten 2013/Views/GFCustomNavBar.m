//
//  GFCustomNavBar.m
//  #GF13
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFCustomNavBar.h"
#import "GFFont.h"

@implementation GFCustomNavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((704 - 80) / 2, 10, 80, 30)];
        title.text = @"#GF13";
        title.textColor = [UIColor whiteColor];
        title.shadowColor = [UIColor blackColor];
        title.shadowOffset = CGSizeMake(0, 1);
        title.font = [GFFont sharedInstance];
        title.backgroundColor = [UIColor clearColor];
        title.textAlignment = UITextAlignmentCenter;
        title.backgroundColor = UIColorFromRGB(0x007390);
        
        [self addSubview:title];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIColor *color = UIColorFromRGB(0x007390);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColor(context, CGColorGetComponents( [color CGColor]));
    CGContextFillRect(context, rect);
}
@end
