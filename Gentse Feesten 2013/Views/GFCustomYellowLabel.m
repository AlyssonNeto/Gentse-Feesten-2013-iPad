//
//  GFCustomYellowLabel.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 1/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFCustomYellowLabel.h"

@implementation GFCustomYellowLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = UIColorFromRGB(0xfae900);
    }
    return self;
}

@end
