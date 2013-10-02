//
//  GFAppDelegate.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFAppDelegate.h"
#import "SDURLCache.h"
#import "GFHomeViewController.h"

@interface GFAppDelegate()

@end

@implementation GFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    _menuViewController = [[GFMenuViewController alloc] initWithNibName:nil bundle:NULL];
    UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:_menuViewController];
    masterNavigationController.navigationBarHidden = YES;
    
    GFHomeViewController *homeViewController = [[GFHomeViewController alloc] initWithNibName:nil bundle:NULL];
    GFNavigationViewController *detailNavigationController = [[GFNavigationViewController alloc] initWithRootViewController:homeViewController];

    _menuViewController.detailViewController = homeViewController;

    self.splitViewController = [[UISplitViewController alloc] init];
    self.splitViewController.delegate = homeViewController;
    self.splitViewController.viewControllers = @[masterNavigationController, detailNavigationController];
    self.window.rootViewController = self.splitViewController;
    [self.window makeKeyAndVisible];

    [GAI sharedInstance].trackUncaughtExceptions = NO;
    [GAI sharedInstance].dispatchInterval = 10;
    [GAI sharedInstance].debug = NO;
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-40824609-1"];
    
    return YES;

}

- (void)prepareCache {
    SDURLCache *cache = [[SDURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                      diskCapacity:20 * 1024 * 1024
                                                          diskPath:[SDURLCache defaultCachePath]];
    cache.minCacheInterval = 0;
    [NSURLCache setSharedURLCache:cache];
}


@end
