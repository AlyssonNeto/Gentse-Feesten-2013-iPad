//
//  GFDatatankAPIClient.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 2/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "AFHTTPClient.h"

@interface GFDatatankAPIClient : AFHTTPClient

+ (id)sharedInstance;

@end
