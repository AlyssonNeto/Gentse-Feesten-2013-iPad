//
//  GFMenu.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 12/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFMenu.h"

@implementation GFMenu

+ (id)sharedInstance {
    static NSArray *__sharedInstance;

    if (__sharedInstance == nil) {

        __sharedInstance = [[NSArray alloc] initWithObjects:
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             NSLocalizedString(@"HOME", nil), @"title",
                             [NSNumber numberWithBool:YES], @"bold",
                             @"menu_home.png", @"icon",
                             @"home", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             NSLocalizedString(@"MY_FAVORITES", nil), @"title",
                             [NSNumber numberWithBool:YES], @"bold",
                             @"menu_favorites.png", @"icon",
                             @"favorites", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             NSLocalizedString(@"PROGRAM", nil), @"title",
                             [NSNumber numberWithBool:YES], @"bold",
                             @"menu_program", @"icon",
                             @"program", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             NSLocalizedString(@"CATEGORIES", nil), @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             @"thema", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             NSLocalizedString(@"FREE", nil), @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             @"free", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             NSLocalizedString(@"LOCATION", nil), @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             @"location", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             NSLocalizedString(@"FESTIVALS", nil), @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             @"festival", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             NSLocalizedString(@"PRACTICAL", nil), @"title",
                             [NSNumber numberWithBool:YES], @"bold",
                             @"menu_practical.png", @"icon",
                             @"practical", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             NSLocalizedString(@"PUBLIC_TOILETS", nil), @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             NSLocalizedString(@"PARKINGS", nil), @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             @"parkings", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             NSLocalizedString(@"SETTINGS", nil), @"title",
                             [NSNumber numberWithBool:YES], @"bold",
                             @"menu_settings.png", @"icon",
                             @"settings", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             NSLocalizedString(@"ABOUT", nil), @"title",
                             [NSNumber numberWithBool:YES], @"bold",
                             @"menu_about.png", @"icon",
                             @"about", @"view",
                             nil],
                            nil];
    }
    
    return __sharedInstance;
}

@end
