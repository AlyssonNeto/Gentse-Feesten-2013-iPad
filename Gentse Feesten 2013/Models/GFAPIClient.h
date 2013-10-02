//
//  GFAPIClient.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 11/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "AFHTTPClient.h"

@interface GFAPIClient : AFHTTPClient

+ (id)sharedInstance;

@end
