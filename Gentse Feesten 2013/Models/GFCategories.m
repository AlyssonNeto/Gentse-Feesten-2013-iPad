//
//  GFCategories.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 29/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFCategories.h"

@implementation GFCategories

+ (id)sharedInstance {
    static NSArray *__sharedInstance;

    if (__sharedInstance == nil) {

        __sharedInstance = [[NSArray alloc] initWithObjects:
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"10", @"id",
                             NSLocalizedString(@"BALS_DANS", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"24", @"id",
                             NSLocalizedString(@"CIRCUS", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"11", @"id",
                             NSLocalizedString(@"COMEDY", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"12", @"id",
                             NSLocalizedString(@"CONCERTEN_DIVERS", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"13", @"id",
                             NSLocalizedString(@"CONCERTEN_JAZZ", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"14", @"id",
                             NSLocalizedString(@"CONCERTEN_KLASSIEK", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"15", @"id",
                             NSLocalizedString(@"CONCERTEN_ROCK", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"16", @"id",
                             NSLocalizedString(@"KINDERPROGRAMMAS", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"17", @"id",
                             NSLocalizedString(@"MARKTEN", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"18", @"id",
                             NSLocalizedString(@"SPEL", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"19", @"id",
                             NSLocalizedString(@"TENTOONSTELLINGEN", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"20", @"id",
                             NSLocalizedString(@"THEATER", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"21", @"id",
                             NSLocalizedString(@"VARIA", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"22", @"id",
                             NSLocalizedString(@"VERTELLINGEN", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"23", @"id",
                             NSLocalizedString(@"VUURWERK", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"25", @"id",
                             NSLocalizedString(@"WANDELINGEN", nil), @"name",
                             nil],
                            nil];
    }

    return __sharedInstance;
}

@end
