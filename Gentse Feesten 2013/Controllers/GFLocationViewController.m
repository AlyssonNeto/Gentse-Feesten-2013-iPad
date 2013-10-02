//
//  GFLocationViewController.m
//  #GF13
//
//  Created by Tim Leytens on 22/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFLocationViewController.h"
#import "GFCustomCell.h"
#import "GFLocations.h"
#import "GFEventsViewController.h"

@interface GFLocationViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *locations;

@end

@implementation GFLocationViewController

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

    self.trackedViewName = @"Program locations";

    _locations = [GFLocations sharedInstance];

    _tableView = [super addTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [super addTableViewHeaderWithTitle:[NSLocalizedString(@"LOCATION", nil) uppercaseString]];
    [_tableView registerClass:[GFCustomCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <= _locations.count) {
        return 56;
    }
    else {
        return 25;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _locations.count + 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row < _locations.count) {
        static NSString *CellIdentifier = @"customCell";
        GFCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.label.text = [[_locations objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);
        return cell;
    }
    else if (indexPath.row == _locations.count) {
        static NSString *CellIdentifier = @"customCell";
        GFCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.label.text = NSLocalizedString(@"ALL_LOCATIONS", nil);
        cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);
        return cell;
    }
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        UIView *footer = [super addTableViewFooter];
        footer.frame = CGRectMake(0, 10, footer.frame.size.width, footer.frame.size.height);
        [cell.contentView addSubview:footer];

        UIView *myBackView = [[UIView alloc] initWithFrame:cell.frame];
        myBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackground.png"]];
        cell.backgroundView = myBackView;

        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];

    GFEventsViewController *detail = [[GFEventsViewController alloc] initWithNibName:nil bundle:nil];
    
    detail.timestamp = _timestamp;
    detail.programType = @"location";
    
    if (indexPath.row < _locations.count) {
        detail.locationID = [[[_locations objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
        detail.screenTitle = [[_locations objectAtIndex:indexPath.row] objectForKey:@"name"];
    }
    else {
        detail.screenTitle = NSLocalizedString(@"ALL_LOCATIONS", nil);
    }

    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
