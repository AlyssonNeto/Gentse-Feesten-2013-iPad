//
//  GFEventsViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 2/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFEventsViewController.h"
#import "GFCustomEventCell.h"
#import "GFFontSmall.h"
#import "GFEventsDataModel.h"
#import "GFEvent.h"
#import "GFEventDetailViewController.h"
#import "SDSegmentedControl.h"
#import "GFDates.h"
#import "GFCustomCell.h"

@interface GFEventsViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GFEventsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [super calledFromNavigationController];

    if ([_programType isEqualToString:@"thema"]) {
        self.trackedViewName = @"Program category: Events";
    }
    else if ([_programType isEqualToString:@"free"]) {
        self.trackedViewName = @"Program free: Events";
    }
    else if ([_programType isEqualToString:@"location"]) {
        self.trackedViewName = @"Program location: Events";
    }
    else {
        self.trackedViewName = @"Program festival: Events";
    }

    int i = 0;
    int index = 0;
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    for (id date in [GFDates sharedInstance]) {
        if ([[date objectForKey:@"id"] isEqual:_timestamp]) {
            index = i;
        }
        i++;
        [itemArray addObject:[date objectForKey:@"shortName"]];
    }
    
    SDSegmentedControl *segmentedControl = [[SDSegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(0, IS_IOS_7 ? navBarHeight : 0, self.view.frame.size.width, 50);
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    
    
    segmentedControl.selectedSegmentIndex = index;
    [segmentedControl addTarget:self
                         action:@selector(changeDate:)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];

    _tableView = [super addTableView];
    _tableView.frame = CGRectMake(padding, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + padding, self.view.frame.size.height - 320 - padding * 2, IS_IOS_7 ? self.view.frame.size.width : self.view.frame.size.width - navBarHeight - segmentedControl.frame.size.height);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [super addTableViewHeaderWithTitle:[_screenTitle uppercaseString]];
    [_tableView registerClass:[GFCustomEventCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][0];
    if (indexPath.row < [sectionInfo numberOfObjects]) {
        
        GFEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
        return [super getHeightForString:event.name] + 30 + 1;
    }
    else if ([sectionInfo numberOfObjects] == 0 && indexPath.row == 0) {
        return [super getHeightForString: [NSLocalizedString(@"NO_RESULT", nil) uppercaseString]] + 30 + 1;
    }
    else {
        return 25;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    if ([sectionInfo numberOfObjects] > 0) {
        return [sectionInfo numberOfObjects] + 1;
    }
    else {
        return 1;
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

        if ([sectionInfo numberOfObjects] == 0 && indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(padding * 2, 0, self.view.frame.size.width - padding * 4, 55)];
            label.font = [GFFontSmall sharedInstance];
            label.textColor = [UIColor darkGrayColor];
            label.highlightedTextColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            label.text = NSLocalizedString(@"NO_RESULT", nil);
            [cell.contentView addSubview:label];

            UIView *footer = [super addTableViewFooter];
            footer.frame = CGRectMake(0, label.frame.origin.y + label.frame.size.height, footer.frame.size.width, 15);
            [cell.contentView addSubview:footer];

            UIView *myBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, footer.frame.size.width, 15)];
            myBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackground.png"]];
            cell.backgroundView = myBackView;
            
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
}


-(void)changeDate:(SDSegmentedControl*)sender {

    _timestamp = [[[GFDates sharedInstance] objectAtIndex:sender.selectedSegmentIndex] objectForKey:@"id"];
    _fetchedResultsController = nil;
    [_fetchedResultsController performFetch:nil];
    [_tableView reloadData];

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

    }
}


- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }


    NSManagedObjectContext *context = [[GFEventsDataModel sharedDataModel] mainContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [GFEvent entityInManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];

    [fetchRequest setReturnsObjectsAsFaults:NO];

    [fetchRequest setFetchBatchSize:20];

    NSSortDescriptor *sortSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sort" ascending:YES];
    NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];

    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortSortDescriptor, sortNameDescriptor, nil];

    [fetchRequest setSortDescriptors:sortDescriptors];

    if ([_programType isEqualToString:@"thema"]) {
        if (_categoryID > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cat_id == %i and datum == %@", _categoryID, _timestamp];
            fetchRequest.predicate = predicate;
        }
        else {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"datum == %@", _timestamp];
            fetchRequest.predicate = predicate;
        }
    }
    else if ([_programType isEqualToString:@"free"]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"gratis == 1 and datum == %@", _timestamp];
        fetchRequest.predicate = predicate;
    }
    else if ([_programType isEqualToString:@"location"]) {
        if (_locationID) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loc_id == %i and datum == %@", _locationID, _timestamp];
            fetchRequest.predicate = predicate;
        }
        else {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"datum == %@", _timestamp];
            fetchRequest.predicate = predicate;
        }
    }
    else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"festival == 1 and datum == %@", _timestamp];
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

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][indexPath.section];
    if ([sectionInfo numberOfObjects] > 0) {
        GFEventDetailViewController *detail = [[GFEventDetailViewController alloc] initWithNibName:nil bundle:NULL];
        GFEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
        detail.event = event;
        detail.calledFromNavigationController = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
