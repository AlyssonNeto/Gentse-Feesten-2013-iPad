// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GFEvent.m instead.

#import "_GFEvent.h"

const struct GFEventAttributes GFEventAttributes = {
	.cat = @"cat",
	.cat_id = @"cat_id",
	.datum = @"datum",
	.fav = @"fav",
	.festival = @"festival",
	.gratis = @"gratis",
	.korting = @"korting",
	.lat = @"lat",
	.loc = @"loc",
	.loc_id = @"loc_id",
	.lon = @"lon",
	.name = @"name",
	.omschrijving = @"omschrijving",
	.periode = @"periode",
	.prijs = @"prijs",
	.prijs_vvk = @"prijs_vvk",
	.serverId = @"serverId",
	.sort = @"sort",
	.startuur = @"startuur",
	.url = @"url",
};

const struct GFEventRelationships GFEventRelationships = {
};

const struct GFEventFetchedProperties GFEventFetchedProperties = {
};

@implementation GFEventID
@end

@implementation _GFEvent

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GFEvent" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GFEvent";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GFEvent" inManagedObjectContext:moc_];
}

- (GFEventID*)objectID {
	return (GFEventID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"cat_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"cat_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"favValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"fav"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"festivalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"festival"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"gratisValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"gratis"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"latValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"lat"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"loc_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"loc_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"lonValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"lon"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"serverIdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"serverId"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"sortValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sort"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic cat;






@dynamic cat_id;



- (int16_t)cat_idValue {
	NSNumber *result = [self cat_id];
	return [result shortValue];
}

- (void)setCat_idValue:(int16_t)value_ {
	[self setCat_id:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveCat_idValue {
	NSNumber *result = [self primitiveCat_id];
	return [result shortValue];
}

- (void)setPrimitiveCat_idValue:(int16_t)value_ {
	[self setPrimitiveCat_id:[NSNumber numberWithShort:value_]];
}





@dynamic datum;






@dynamic fav;



- (BOOL)favValue {
	NSNumber *result = [self fav];
	return [result boolValue];
}

- (void)setFavValue:(BOOL)value_ {
	[self setFav:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveFavValue {
	NSNumber *result = [self primitiveFav];
	return [result boolValue];
}

- (void)setPrimitiveFavValue:(BOOL)value_ {
	[self setPrimitiveFav:[NSNumber numberWithBool:value_]];
}





@dynamic festival;



- (BOOL)festivalValue {
	NSNumber *result = [self festival];
	return [result boolValue];
}

- (void)setFestivalValue:(BOOL)value_ {
	[self setFestival:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveFestivalValue {
	NSNumber *result = [self primitiveFestival];
	return [result boolValue];
}

- (void)setPrimitiveFestivalValue:(BOOL)value_ {
	[self setPrimitiveFestival:[NSNumber numberWithBool:value_]];
}





@dynamic gratis;



- (BOOL)gratisValue {
	NSNumber *result = [self gratis];
	return [result boolValue];
}

- (void)setGratisValue:(BOOL)value_ {
	[self setGratis:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveGratisValue {
	NSNumber *result = [self primitiveGratis];
	return [result boolValue];
}

- (void)setPrimitiveGratisValue:(BOOL)value_ {
	[self setPrimitiveGratis:[NSNumber numberWithBool:value_]];
}





@dynamic korting;






@dynamic lat;



- (float)latValue {
	NSNumber *result = [self lat];
	return [result floatValue];
}

- (void)setLatValue:(float)value_ {
	[self setLat:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLatValue {
	NSNumber *result = [self primitiveLat];
	return [result floatValue];
}

- (void)setPrimitiveLatValue:(float)value_ {
	[self setPrimitiveLat:[NSNumber numberWithFloat:value_]];
}





@dynamic loc;






@dynamic loc_id;



- (int16_t)loc_idValue {
	NSNumber *result = [self loc_id];
	return [result shortValue];
}

- (void)setLoc_idValue:(int16_t)value_ {
	[self setLoc_id:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveLoc_idValue {
	NSNumber *result = [self primitiveLoc_id];
	return [result shortValue];
}

- (void)setPrimitiveLoc_idValue:(int16_t)value_ {
	[self setPrimitiveLoc_id:[NSNumber numberWithShort:value_]];
}





@dynamic lon;



- (float)lonValue {
	NSNumber *result = [self lon];
	return [result floatValue];
}

- (void)setLonValue:(float)value_ {
	[self setLon:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLonValue {
	NSNumber *result = [self primitiveLon];
	return [result floatValue];
}

- (void)setPrimitiveLonValue:(float)value_ {
	[self setPrimitiveLon:[NSNumber numberWithFloat:value_]];
}





@dynamic name;






@dynamic omschrijving;






@dynamic periode;






@dynamic prijs;






@dynamic prijs_vvk;






@dynamic serverId;



- (int16_t)serverIdValue {
	NSNumber *result = [self serverId];
	return [result shortValue];
}

- (void)setServerIdValue:(int16_t)value_ {
	[self setServerId:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveServerIdValue {
	NSNumber *result = [self primitiveServerId];
	return [result shortValue];
}

- (void)setPrimitiveServerIdValue:(int16_t)value_ {
	[self setPrimitiveServerId:[NSNumber numberWithShort:value_]];
}





@dynamic sort;



- (int16_t)sortValue {
	NSNumber *result = [self sort];
	return [result shortValue];
}

- (void)setSortValue:(int16_t)value_ {
	[self setSort:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveSortValue {
	NSNumber *result = [self primitiveSort];
	return [result shortValue];
}

- (void)setPrimitiveSortValue:(int16_t)value_ {
	[self setPrimitiveSort:[NSNumber numberWithShort:value_]];
}





@dynamic startuur;






@dynamic url;











@end
