#import "_GFEvent.h"

@interface GFEvent : _GFEvent {}

+ (GFEvent *)eventWithServerId:(NSInteger)serverId usingManagedObjectContext:(NSManagedObjectContext *)moc;

- (void)updateAttributes:(NSDictionary *)attributes;

- (void)toggleFavorite:(bool)status;

+ (int)countWithManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSMutableArray *)getRandomAmountServerIds:(NSInteger)amount withDate:(int)timestamp withCategories:(NSMutableArray *)interests UsingManagedObjectContext:(NSManagedObjectContext *)moc;

@end
