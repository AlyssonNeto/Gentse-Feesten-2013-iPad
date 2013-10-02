//
//  GFHomeViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "GFHomeViewController.h"
#import "GFCustomEventCell.h"
#import "GFEventsDataModel.h"
#import "GFEvent.h"
#import "AFNetworking.h"
#import "GFAPIClient.h"
#import "GFFontSmall.h"
#import "GFDates.h"
#import "GFCategories.h"
#import "GFEventDetailViewController.h"
#import "PHFRefreshControl.h"

@interface GFHomeViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property time_t today;

@property int timestamp;

@property (nonatomic, strong) NSArray *categories;

@end

@implementation GFHomeViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES animated:NO];

    _tableView = [super addTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height - 320 - padding * 2, 60)];

    UIImage *stuntDude = [UIImage imageNamed:@"stunt-dude.png"];
    UIImageView *stuntDudeView = [[UIImageView alloc] initWithImage:stuntDude];

    [containerView addSubview:stuntDudeView];

    stuntDudeView.frame = CGRectMake((self.view.frame.size.height - 320 - stuntDudeView.frame.size.width) / 2, stuntDudeView.frame.origin.y, stuntDudeView.frame.size.width, stuntDudeView.frame.size.height);

    UIImage *tableTop = [UIImage imageNamed:@"tableTop.png"];
    UIImageView *tableTopView = [[UIImageView alloc] initWithImage:tableTop];
    tableTopView.frame = CGRectMake(0, stuntDudeView.frame.size.height + stuntDudeView.frame.origin.y, tableTop.size.width, tableTop.size.height);
    [containerView addSubview:tableTopView];

    containerView.frame = CGRectMake(containerView.frame.origin.x, containerView.frame.origin.y, containerView.frame.size.width, stuntDudeView.frame.size.height + stuntDudeView.frame.origin.y);

    _tableView.tableHeaderView = containerView;

    [_tableView registerClass:[GFCustomEventCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];
    [self addRefreshControlToTableView];

    self.trackedViewName = @"Home";

}

- (void)addRefreshControlToTableView {
    PHFRefreshControl *refreshControl = [PHFRefreshControl new];
    [refreshControl setTintColor:UIColorFromRGB(0xeeeeee)];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [[self tableView] setRefreshControl:refreshControl];
}

- (void)refresh {
    int64_t delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[[self tableView] refreshControl] endRefreshing];
        _fetchedResultsController = nil;
        [_fetchedResultsController performFetch:nil];
        [_tableView reloadData];
    });
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][indexPath.section];
    if (indexPath.row < [sectionInfo numberOfObjects]) {

        GFEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
        return [super getHeightForString:event.name] + 30 + 1;
    }
    else {
        return 25;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][indexPath.section];

    if (indexPath.row < [sectionInfo numberOfObjects]) {
        static NSString *CellIdentifier = @"customCell";
        GFCustomEventCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        GFEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];

        cell.label.text = event.name;

        if ([event.sort isEqualToNumber:[NSNumber numberWithInt:0]]) {
            cell.timeLabel.text = NSLocalizedString(@"ALL_DAY", nil);
        }
        else {
            cell.timeLabel.text = event.startuur;
        }

        CGFloat height = [super getHeightForString:event.name];

        cell.label.frame = CGRectMake(55, cell.label.frame.origin.y, 550, height + 30);

        cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);

        cell.containerView.frame = CGRectMake(padding, 0, [[UIScreen mainScreen] bounds].size.height - 320 - (padding * 4) - 2, height + 30);

        cell.bottomBorder.frame = CGRectMake(0, height + 30, cell.containerView.frame.size.width, 1);

        UIImage *favButtonImage = [UIImage imageNamed:@"fav_off.png"];
        UIImage *favButtonImageActive = [UIImage imageNamed:@"fav_on.png"];
        UIButton *favButton = [UIButton buttonWithType:UIButtonTypeCustom];

        if ([event.fav isEqualToNumber:[NSNumber numberWithInt:1]]) {
            favButton.selected = YES;
        }
        else {
            favButton.selected = NO;
        }

        [favButton setBackgroundImage:favButtonImage forState:UIControlStateNormal];
        [favButton setBackgroundImage:favButtonImageActive forState:UIControlStateSelected];

        [favButton setFrame:CGRectMake(620, 0, favButtonImage.size.width, favButtonImage.size.height)];
        [favButton addTarget:self
                      action:@selector(addEventToFavorites:)
            forControlEvents:UIControlEventTouchDown];
        [cell.containerView addSubview:favButton];

        return cell;
    }
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        UIView *footer = [super addTableViewFooter];
        footer.frame = CGRectMake(0, 10, footer.frame.size.width, 15);
        [cell.contentView addSubview:footer];

        UIView *myBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, footer.frame.size.width, 15)];
        myBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackground.png"]];
        cell.backgroundView = myBackView;

        return cell;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects] + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSFetchedResultsController *)fetchedResultsController
{

    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    _categories = [GFCategories sharedInstance];

    NSMutableArray *interests = [[NSMutableArray alloc] init];
    for(id category in _categories) {
        id key = [NSString stringWithFormat:@"interests-%@", [category objectForKey:@"id"]];
        if ([defaults boolForKey:key]) {
            [interests addObject:[category objectForKey:@"id"]];
        }
    }

    NSMutableArray *allInterests = [[NSMutableArray alloc] init];
    for(id category in _categories) {
        [allInterests addObject:[category objectForKey:@"id"]];
    }

    NSManagedObjectContext *context = [[GFEventsDataModel sharedDataModel] mainContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [GFEvent entityInManagedObjectContext:context];

    [fetchRequest setEntity:entity];

    [fetchRequest setReturnsObjectsAsFaults:NO];

    [fetchRequest setFetchLimit:10];
       
    NSSortDescriptor *sortSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sort" ascending:YES];

    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortSortDescriptor, nil];

    [fetchRequest setSortDescriptors:sortDescriptors];


    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];

    _today = (time_t) [[calendar dateFromComponents:components] timeIntervalSince1970];

    if ((int) _today <= 1374271200) {
        _timestamp = 1374271200;
    }
    else if ((int) _today >= 1375048800) {
        _timestamp = 1375048800;
    }
    else {
        _timestamp = (int) _today;
    }

    NSArray *randomServerIds = [GFEvent getRandomAmountServerIds:10 withDate:_timestamp withCategories:interests UsingManagedObjectContext:context];

    if ([randomServerIds count] > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"serverId IN %@", [GFEvent getRandomAmountServerIds:10 withDate:_timestamp withCategories:interests UsingManagedObjectContext:context]];
        fetchRequest.predicate = predicate;
    }
    else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"serverId IN %@", [GFEvent getRandomAmountServerIds:10 withDate:_timestamp withCategories:allInterests UsingManagedObjectContext:context]];
        fetchRequest.predicate = predicate;
    }
     
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;

	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        abort();
	}

    return _fetchedResultsController;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    GFEventDetailViewController *detail = [[GFEventDetailViewController alloc] initWithNibName:nil bundle:NULL];
    GFEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    detail.event = event;
    detail.calledFromNavigationController = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(padding, 0, [[UIScreen mainScreen] bounds].size.height - 320 - (padding * 4) - 2, 55)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, headerView.frame.size.width - (padding * 2), 55)];
    label.font = [GFFontSmall sharedInstance];
    label.textColor = UIColorFromRGB(0x002d46);
    label.backgroundColor = [UIColor whiteColor];

    for (id date in [GFDates sharedInstance]) {
        if ([[date objectForKey:@"id"] isEqualToString:[NSString stringWithFormat:@"%i", _timestamp]]) {
            label.text = [[NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"SPOTLIGHT", nil), [date objectForKey:@"name"]] uppercaseString];
        }
    }
    
    label.textAlignment = UITextAlignmentCenter;
    [headerView addSubview:label];

    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(padding, 55, headerView.frame.size.width, 1);
    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                     alpha:1.0f].CGColor;
    [headerView.layer addSublayer:bottomBorder];

    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackground.png"]];

    return headerView;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56.0;
}


- (void)addEventToFavorites:(UIButton*)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {

        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:[[GFEventsDataModel sharedDataModel] persistentStoreCoordinator]];

        NSInteger serverId = [[[self.fetchedResultsController objectAtIndexPath:indexPath] serverId] intValue];
        GFEvent *event = [GFEvent eventWithServerId:serverId usingManagedObjectContext:context];
        bool status;
        if ([event.fav isEqualToNumber:[NSNumber numberWithInt:1]]) {
            status = NO;
        }
        else {
            status = YES;
        }
        sender.selected = status;
        [event toggleFavorite:status];
        [[self.fetchedResultsController objectAtIndexPath:indexPath] toggleFavorite:status];
        [context save:nil];
        [self.fetchedResultsController performFetch:nil];
        [_tableView reloadData];
        
    }
}

@end
