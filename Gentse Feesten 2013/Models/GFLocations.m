//
//  GFLocations.m
//  #GF13
//
//  Created by Tim Leytens on 22/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFLocations.h"

@implementation GFLocations

+ (id)sharedInstance {
    static NSArray *__sharedInstance;

    if (__sharedInstance == nil) {

        __sharedInstance = [[NSArray alloc] initWithObjects:
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"376", @"id",
                             @"Baudelohof", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"390", @"id",
                             @"Beverhoutplein", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"230", @"id",
                             @"Bij Sint-Jacobs", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"385", @"id",
                             @"Bisdomplein", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"615", @"id",
                             @"Emile Braunplein", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"382", @"id",
                             @"François Laurentplein", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"394", @"id",
                             @"Gravensteen", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"380", @"id",
                             @"Groentenmarkt", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"395", @"id",
                             @"Koningin Maria Hendrikaplein", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"379", @"id",
                             @"Korenlei - Graslei", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"378", @"id",
                             @"Korenmarkt", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"384", @"id",
                             @"Kouter", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"470", @"id",
                             @"Portus Ganda, Voorhoutkaai", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"392", @"id",
                             @"Sint-Bavo Humaniora - Reep 4", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"377", @"id",
                             @"St-Baafsplein", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"381", @"id",
                             @"St-Veerleplein", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"383", @"id",
                             @"Vlasmarkt", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"386", @"id",
                             @"Vrijdagmarkt", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"393", @"id",
                             @"Watersportbaan", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"387", @"id",
                             @"Woodrow Wilsonplein", @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"0", @"id",
                             NSLocalizedString(@"OTHER_LOCATIONS", nil), @"name",
                             nil],
                            nil];
    }

    return __sharedInstance;
}

@end
