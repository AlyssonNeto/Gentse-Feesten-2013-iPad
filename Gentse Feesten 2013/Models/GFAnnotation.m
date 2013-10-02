//
//  GFAnnotation.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 12/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFAnnotation.h"

@implementation GFAnnotation

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}


- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(_lat, _lon);
}

@end
