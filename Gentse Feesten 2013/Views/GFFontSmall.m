//
//  GFFontSmall.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 31/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFFontSmall.h"

@implementation GFFontSmall

+ (id)sharedInstance {
    static UIFont *__sharedInstance;

    if (__sharedInstance == nil) {
        __sharedInstance = [UIFont fontWithName:@"PT Sans Narrow" size:19.0];;
    }

    return __sharedInstance;
}

@end
