//
//  GFMenuViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFMenuViewController.h"

#import "GFCustomToolBar.h"
#import "GFMenu.h"
#import "GFCustomViewController.h"
#import "GFPoiMapViewController.h"
#import "GFHomeViewController.h"
#import "GFNavigationViewController.h"
#import "GFAboutViewController.h"
#import "GFSettingsViewController.h"
#import "GFFavoritesViewController.h"
#import "GFProgramViewController.h"
#import "GFParkingListViewController.h"
#import "GFPracticalViewController.h"
#import "GFFontSmall.h"
#import "GFEvent.h"
#import "GFEventsDataModel.h"
#import "GFEventDetailViewController.h"

#import "GFDateViewController.h"

#import "GFAppDelegate.h"

@interface GFMenuViewController() <UISearchDisplayDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UISearchDisplayController *searchController;

@property (nonatomic, strong) UITableView *menuTableView;

@property (nonatomic, strong) NSArray *menu;

@property (nonatomic, strong) NSMutableArray *searchResults;

@end

@implementation GFMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupSearchBar];
        [self setupTableView];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    _appDelegate = (GFAppDelegate *)[[UIApplication sharedApplication] delegate];

    [self setupMenu];

}

- (void)setupMenu {

    _menu = [GFMenu sharedInstance];

    [_menuTableView reloadData];
}


- (void)setupSearchBar {

    GFCustomToolBar *toolbar = [[GFCustomToolBar alloc] init];
    toolbar.frame = CGRectMake(0, 0, 320, 44);

    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, toolbar.frame.size.width, navBarHeight)];

    [[_searchBar.subviews objectAtIndex:0] removeFromSuperview];
    [_searchBar setBackgroundColor:[UIColor clearColor]];

    if (IS_IOS_7) {
        _searchBar.tintColor = [UIColor whiteColor];
    }

    _searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchController.searchResultsDataSource = self;
    _searchController.searchResultsDelegate = self;
    _searchController.delegate = self;

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, toolbar.frame.size.width, navBarHeight)];
    [containerView addSubview:_searchBar];

    [toolbar addSubview:containerView];

    [self.view addSubview:toolbar];
    
    
}


- (void)setupTableView {
    _menuTableView = [[UITableView alloc] initWithFrame:
                  CGRectMake(0, navBarHeight, self.view.frame.size.width - padding * 2, self.view.frame.size.height - navBarHeight)];
    
    _menuTableView.backgroundColor = [UIColor clearColor];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.separatorColor = UIColorFromRGB(0x174e61);
    
    if (IS_IOS_7) {
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    _menuTableView.backgroundColor = UIColorFromRGB(0x12414f);
    [self.view addSubview:_menuTableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _menuTableView) {
        return _menu.count;
    }
    else {
        return self.searchResults.count;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _menuTableView) {
        return 39;
    }
    else {
        return 50;
    }
}


- (void)filterProductsForTerm:(NSString *)term {
    [_searchResults removeAllObjects];

    NSManagedObjectContext *context = [[GFEventsDataModel sharedDataModel] mainContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    fetchRequest.entity = [GFEvent entityInManagedObjectContext:context];

    NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSSortDescriptor *sortDateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"datum" ascending:YES];
    NSSortDescriptor *sortSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sort" ascending:YES];

    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor, sortDateDescriptor, sortSortDescriptor, nil];

    [fetchRequest setSortDescriptors:sortDescriptors];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", term];
    fetchRequest.predicate = predicate;
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    if (results == nil) {
        [NSException raise:NSGenericException format:@"Error filtering for term: %@ -- %@", term, error];
    }

    _searchResults = [[NSMutableArray alloc] initWithArray:results];
        
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterProductsForTerm:searchString];
    return YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

    [self.searchBar resignFirstResponder];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView == _menuTableView) {

    UILabel *title;
    UIImageView *imgView;

    static NSString *cellIdentifer = @"cell";

    UITableViewCell *cell = [_menuTableView dequeueReusableCellWithIdentifier:cellIdentifer];

    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];

        
        title = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.view.frame.size.width - 50, 38)];

        title.textColor = UIColorFromRGB(0x7eb5c2);
        title.shadowColor = [UIColor blackColor];
        title.shadowOffset = CGSizeMake(0, 1);
        title.tag = 1;
        if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"bold"] integerValue] == 1) {
            title.font = [GFFontSmall sharedInstance];
            UIView *myBackView = [[UIView alloc] initWithFrame:cell.frame];
            myBackView.backgroundColor = UIColorFromRGB(0x12414f);
            cell.backgroundView = myBackView;
        }
        else {
            title.font = [GFFontSmall sharedInstance];
            UIView *myBackView = [[UIView alloc] initWithFrame:cell.frame];
            myBackView.backgroundColor = UIColorFromRGB(0x0e3845);
            cell.backgroundView = myBackView;
        }
        title.backgroundColor = [UIColor clearColor];
        title.highlightedTextColor = [UIColor whiteColor];
        [title setText:[[_menu objectAtIndex:indexPath.row] objectForKey:@"title"]];
        [cell.contentView addSubview:title];

        cell.accessoryType = UITableViewCellAccessoryNone;

        UIView *mySelectedBackView = [[UIView alloc] initWithFrame:cell.frame];
        mySelectedBackView.backgroundColor = UIColorFromRGB(0xe64a45);
        cell.selectedBackgroundView = mySelectedBackView;

        if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"icon"] length] != 0) {
            UIImage *image = [UIImage imageNamed:[[_menu objectAtIndex:indexPath.row] objectForKey:@"icon"]];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, (38 - image.size.height) / 2 , image.size.width, image.size.height)];
            [imgView setImage:image];
                
            imgView.tag = 2;
            [cell.contentView addSubview:imgView];
        }
        
    }
    else {
        title = (UILabel *) [cell.contentView viewWithTag:1];
        title.text = [[_menu objectAtIndex:indexPath.row] objectForKey:@"title"];

        imgView = (UIImageView *)[cell.contentView viewWithTag:2];
        UIImage *image = [UIImage imageNamed:[[_menu objectAtIndex:indexPath.row] objectForKey:@"icon"]];
        [imgView setImage:image];
    }

        return cell;
    }
    else {
        static NSString *searchCellIdentifer = @"searchCell";

        UITableViewCell *searchCell = [tableView dequeueReusableCellWithIdentifier:searchCellIdentifer];

        if (!searchCell) {
            searchCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:searchCellIdentifer];

            UIView *myBackView = [[UIView alloc] initWithFrame:searchCell.frame];
            myBackView.backgroundColor = UIColorFromRGB(0xe64a45);
            searchCell.selectedBackgroundView = myBackView;
        }

        GFEvent *event = [self.searchResults objectAtIndex:indexPath.row];
        searchCell.textLabel.text = event.name;

        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[event.datum intValue]];

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM"];

        NSString *formattedDateString = [dateFormatter stringFromDate:date];

        NSString *tijdstip = [event.sort intValue] == 0 ? @"Hele dag" : event.startuur;

        searchCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@  |  %@", formattedDateString, tijdstip, event.loc];

        return searchCell;
    }    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


    [self.appDelegate.splitViewController viewWillDisappear:YES];
    NSMutableArray *viewControllerArray = [[NSMutableArray alloc] initWithArray:[[self.appDelegate.splitViewController.viewControllers objectAtIndex:1] viewControllers]];
    [viewControllerArray removeLastObject];
    

    if (tableView == _menuTableView) {

        if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"home"]) {
            GFHomeViewController *detailViewController = [[GFHomeViewController alloc] initWithNibName:nil bundle:nil];
            
            [viewControllerArray addObject:detailViewController];

        }
        else if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"about"]) {
            GFAboutViewController *detailViewController = [[GFAboutViewController alloc] initWithNibName:nil bundle:nil];

            [viewControllerArray addObject:detailViewController];
        }
        else if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"settings"]) {
            GFSettingsViewController *detailViewController = [[GFSettingsViewController alloc] initWithNibName:nil bundle:nil];

            [viewControllerArray addObject:detailViewController];            
        }
        else if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"favorites"]) {
            GFFavoritesViewController *detailViewController = [[GFFavoritesViewController alloc] initWithNibName:nil bundle:nil];
            [viewControllerArray addObject:detailViewController];
        }
        else if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"program"]) {
            GFProgramViewController *detailViewController = [[GFProgramViewController alloc] initWithNibName:nil bundle:nil];
            [viewControllerArray addObject:detailViewController];
        }
        else if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"free"]) {
            GFDateViewController *detailViewController = [[GFDateViewController alloc] initWithNibName:nil bundle:nil];
            detailViewController.programType = @"free";
            [viewControllerArray addObject:detailViewController];
        }
        else if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"location"]) {
            GFDateViewController *detailViewController = [[GFDateViewController alloc] initWithNibName:nil bundle:nil];
            detailViewController.programType = @"location";
            [viewControllerArray addObject:detailViewController];
        }
        else if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"thema"]) {
            GFDateViewController *detailViewController = [[GFDateViewController alloc] initWithNibName:nil bundle:nil];
            detailViewController.programType = @"thema";
            [viewControllerArray addObject:detailViewController];
        }
        else if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"festival"]) {
            GFDateViewController *detailViewController = [[GFDateViewController alloc] initWithNibName:nil bundle:nil];
            detailViewController.programType = @"festival";
            [viewControllerArray addObject:detailViewController];
        }
        else if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"parkings"]) {
            GFParkingListViewController *detailViewController = [[GFParkingListViewController alloc] initWithNibName:nil bundle:nil];
            [viewControllerArray addObject:detailViewController];
        }
        else if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"practical"]) {
            GFPracticalViewController *detailViewController = [[GFPracticalViewController alloc] initWithNibName:nil bundle:nil];
            [viewControllerArray addObject:detailViewController];
        }
        else {
            GFPoiMapViewController *detailViewController = [[GFPoiMapViewController alloc] initWithNibName:nil bundle:nil];
            [viewControllerArray addObject:detailViewController];
        }

    }

    else {
        [self.searchBar resignFirstResponder];
        GFEventDetailViewController *detail = [[GFEventDetailViewController alloc] initWithNibName:nil bundle:NULL];
        detail.event = [self.searchResults objectAtIndex:indexPath.row];
        [viewControllerArray addObject:detail];
    }

    [[self.appDelegate.splitViewController.viewControllers objectAtIndex:1] setViewControllers:viewControllerArray animated:NO];
    [self.appDelegate.splitViewController viewWillAppear:YES];

}

@end
