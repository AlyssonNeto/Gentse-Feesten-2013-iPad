//
//  GFDatatankAPIClient.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 2/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFDatatankAPIClient.h"

#import "AFNetworking.h"

#define GFDatatankApiClientBaseUrl @"http://datatank.gent.be/"

@implementation GFDatatankAPIClient

+ (id)sharedInstance {
    static GFDatatankAPIClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[GFDatatankAPIClient alloc] initWithBaseURL:
                            [NSURL URLWithString:GFDatatankApiClientBaseUrl]];
    });
    return __sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }

    return self;
}

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [super getPath:path parameters:parameters success:success failure:failure];
}

@end
