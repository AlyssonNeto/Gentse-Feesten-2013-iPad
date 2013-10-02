//
//  GFEventsDataModel.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 1/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface GFEventsDataModel : NSObject

+ (id)sharedDataModel;

@property (nonatomic, readonly) NSManagedObjectContext *mainContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)modelName;
- (NSString *)pathToModel;
- (NSString *)storeFilename;
- (NSString *)pathToLocalStore;

@end
