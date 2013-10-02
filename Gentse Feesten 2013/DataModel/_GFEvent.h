// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GFEvent.h instead.

#import <CoreData/CoreData.h>


extern const struct GFEventAttributes {
	__unsafe_unretained NSString *cat;
	__unsafe_unretained NSString *cat_id;
	__unsafe_unretained NSString *datum;
	__unsafe_unretained NSString *fav;
	__unsafe_unretained NSString *festival;
	__unsafe_unretained NSString *gratis;
	__unsafe_unretained NSString *korting;
	__unsafe_unretained NSString *lat;
	__unsafe_unretained NSString *loc;
	__unsafe_unretained NSString *loc_id;
	__unsafe_unretained NSString *lon;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *omschrijving;
	__unsafe_unretained NSString *periode;
	__unsafe_unretained NSString *prijs;
	__unsafe_unretained NSString *prijs_vvk;
	__unsafe_unretained NSString *serverId;
	__unsafe_unretained NSString *sort;
	__unsafe_unretained NSString *startuur;
	__unsafe_unretained NSString *url;
} GFEventAttributes;

extern const struct GFEventRelationships {
} GFEventRelationships;

extern const struct GFEventFetchedProperties {
} GFEventFetchedProperties;























@interface GFEventID : NSManagedObjectID {}
@end

@interface _GFEvent : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GFEventID*)objectID;





@property (nonatomic, strong) NSString* cat;



//- (BOOL)validateCat:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* cat_id;



@property int16_t cat_idValue;
- (int16_t)cat_idValue;
- (void)setCat_idValue:(int16_t)value_;

//- (BOOL)validateCat_id:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* datum;



//- (BOOL)validateDatum:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* fav;



@property BOOL favValue;
- (BOOL)favValue;
- (void)setFavValue:(BOOL)value_;

//- (BOOL)validateFav:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* festival;



@property BOOL festivalValue;
- (BOOL)festivalValue;
- (void)setFestivalValue:(BOOL)value_;

//- (BOOL)validateFestival:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* gratis;



@property BOOL gratisValue;
- (BOOL)gratisValue;
- (void)setGratisValue:(BOOL)value_;

//- (BOOL)validateGratis:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* korting;



//- (BOOL)validateKorting:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* lat;



@property float latValue;
- (float)latValue;
- (void)setLatValue:(float)value_;

//- (BOOL)validateLat:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* loc;



//- (BOOL)validateLoc:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* loc_id;



@property int16_t loc_idValue;
- (int16_t)loc_idValue;
- (void)setLoc_idValue:(int16_t)value_;

//- (BOOL)validateLoc_id:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* lon;



@property float lonValue;
- (float)lonValue;
- (void)setLonValue:(float)value_;

//- (BOOL)validateLon:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* omschrijving;



//- (BOOL)validateOmschrijving:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* periode;



//- (BOOL)validatePeriode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* prijs;



//- (BOOL)validatePrijs:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* prijs_vvk;



//- (BOOL)validatePrijs_vvk:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* serverId;



@property int16_t serverIdValue;
- (int16_t)serverIdValue;
- (void)setServerIdValue:(int16_t)value_;

//- (BOOL)validateServerId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* sort;



@property int16_t sortValue;
- (int16_t)sortValue;
- (void)setSortValue:(int16_t)value_;

//- (BOOL)validateSort:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* startuur;



//- (BOOL)validateStartuur:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* url;



//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;






@end

@interface _GFEvent (CoreDataGeneratedAccessors)

@end

@interface _GFEvent (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCat;
- (void)setPrimitiveCat:(NSString*)value;




- (NSNumber*)primitiveCat_id;
- (void)setPrimitiveCat_id:(NSNumber*)value;

- (int16_t)primitiveCat_idValue;
- (void)setPrimitiveCat_idValue:(int16_t)value_;




- (NSString*)primitiveDatum;
- (void)setPrimitiveDatum:(NSString*)value;




- (NSNumber*)primitiveFav;
- (void)setPrimitiveFav:(NSNumber*)value;

- (BOOL)primitiveFavValue;
- (void)setPrimitiveFavValue:(BOOL)value_;




- (NSNumber*)primitiveFestival;
- (void)setPrimitiveFestival:(NSNumber*)value;

- (BOOL)primitiveFestivalValue;
- (void)setPrimitiveFestivalValue:(BOOL)value_;




- (NSNumber*)primitiveGratis;
- (void)setPrimitiveGratis:(NSNumber*)value;

- (BOOL)primitiveGratisValue;
- (void)setPrimitiveGratisValue:(BOOL)value_;




- (NSString*)primitiveKorting;
- (void)setPrimitiveKorting:(NSString*)value;




- (NSNumber*)primitiveLat;
- (void)setPrimitiveLat:(NSNumber*)value;

- (float)primitiveLatValue;
- (void)setPrimitiveLatValue:(float)value_;




- (NSString*)primitiveLoc;
- (void)setPrimitiveLoc:(NSString*)value;




- (NSNumber*)primitiveLoc_id;
- (void)setPrimitiveLoc_id:(NSNumber*)value;

- (int16_t)primitiveLoc_idValue;
- (void)setPrimitiveLoc_idValue:(int16_t)value_;




- (NSNumber*)primitiveLon;
- (void)setPrimitiveLon:(NSNumber*)value;

- (float)primitiveLonValue;
- (void)setPrimitiveLonValue:(float)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveOmschrijving;
- (void)setPrimitiveOmschrijving:(NSString*)value;




- (NSString*)primitivePeriode;
- (void)setPrimitivePeriode:(NSString*)value;




- (NSString*)primitivePrijs;
- (void)setPrimitivePrijs:(NSString*)value;




- (NSString*)primitivePrijs_vvk;
- (void)setPrimitivePrijs_vvk:(NSString*)value;




- (NSNumber*)primitiveServerId;
- (void)setPrimitiveServerId:(NSNumber*)value;

- (int16_t)primitiveServerIdValue;
- (void)setPrimitiveServerIdValue:(int16_t)value_;




- (NSNumber*)primitiveSort;
- (void)setPrimitiveSort:(NSNumber*)value;

- (int16_t)primitiveSortValue;
- (void)setPrimitiveSortValue:(int16_t)value_;




- (NSString*)primitiveStartuur;
- (void)setPrimitiveStartuur:(NSString*)value;




- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;




@end
