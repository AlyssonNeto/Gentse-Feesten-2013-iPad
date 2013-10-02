//
//  GFNavigationViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFNavigationViewController.h"

#import "GFCustomNavBar.h"

@interface GFNavigationViewController ()


@end

@implementation GFNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = UIColorFromRGB(0x005470);
        
        [self setValue:[[GFCustomNavBar alloc]init] forKeyPath:@"navigationBar"];
        
    }
    return self;
}

@end
