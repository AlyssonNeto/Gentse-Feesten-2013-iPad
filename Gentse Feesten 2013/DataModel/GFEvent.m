#import "GFEvent.h"

#import "NSDictionary+ObjectForKeyOrNil.h"

@interface GFEvent ()

// Private interface goes here.

@end


@implementation GFEvent

+ (GFEvent *)eventWithServerId:(NSInteger)serverId usingManagedObjectContext:(NSManagedObjectContext *)moc {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[GFEvent entityName]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"serverId = %d", serverId]];
    [fetchRequest setFetchLimit:1];

    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];
    if (error) {
        exit(1);
    }

    if ([results count] == 0) {
        return nil;
    }

    return [results objectAtIndex:0];
}

- (void)updateAttributes:(NSDictionary *)attributes {
    self.name = [attributes objectForKeyOrNil:@"title"];
    self.gratis = [NSNumber numberWithInt:[[attributes objectForKeyOrNil:@"gratis"] intValue]];
    self.festival = [NSNumber numberWithInt:[[attributes objectForKeyOrNil:@"festival"] intValue]];
    self.prijs = [attributes objectForKeyOrNil:@"prijs"];
    self.prijs_vvk = [attributes objectForKeyOrNil:@"prijs_vvk"];
    self.omschrijving = [attributes objectForKeyOrNil:@"omsch"];
    self.datum = [attributes objectForKeyOrNil:@"datum"];
    self.periode = [attributes objectForKeyOrNil:@"periode"];
    self.startuur = [attributes objectForKeyOrNil:@"start"];
    self.sort = [NSNumber numberWithInt:[[attributes objectForKeyOrNil:@"sort"] intValue]];
    self.cat = [attributes objectForKeyOrNil:@"cat"];
    self.cat_id = [NSNumber numberWithInt:[[attributes objectForKeyOrNil:@"cat_id"] intValue]];
    self.url = [attributes objectForKeyOrNil:@"url"];
    self.loc = [attributes objectForKeyOrNil:@"loc"];
    self.loc_id = [NSNumber numberWithInt:[[attributes objectForKeyOrNil:@"loc_id"] intValue]];
    self.lat = [NSNumber numberWithFloat:[[attributes objectForKeyOrNil:@"lat"] floatValue]];
    self.lon = [NSNumber numberWithFloat:[[attributes objectForKeyOrNil:@"lon"] floatValue]];
    self.korting = [attributes objectForKeyOrNil:@"korting"];   
}

- (void)toggleFavorite:(bool)status {
    self.fav = [NSNumber numberWithBool:status];
}

+ (int)countWithManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *countRequest = [[NSFetchRequest alloc] init];
    [countRequest setEntity:[self entityInManagedObjectContext:context]];
    int count = [context countForFetchRequest:countRequest error:nil];
    return count;
}


+ (NSMutableArray *)getRandomAmountServerIds:(NSInteger)amount withDate:(int)timestamp withCategories:(NSMutableArray *)interests UsingManagedObjectContext:(NSManagedObjectContext *)moc {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[GFEvent entityName]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"datum = %i AND cat_id IN %@", timestamp, interests]];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];
    
    if (error || [results count] == 0) {
        return nil;
    }

    NSMutableArray *serverIds = [[NSMutableArray alloc] init];

    for (int i = 0; i < amount; i++) {
        int randIndex = arc4random() % [results count];
        [serverIds addObject:[[results objectAtIndex:randIndex] serverId]];
    }
    
    return serverIds;
}


@end
