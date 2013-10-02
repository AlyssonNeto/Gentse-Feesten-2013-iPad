//
//  GFDateViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 31/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFDateViewController.h"
#import "GFCustomCell.h"
#import "GFDates.h"
#import "GFCalendarCategoryViewController.h"
#import "GFEventsViewController.h"
#import "GFLocationViewController.h"


@interface GFDateViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dates;

@property time_t today;

@end

@implementation GFDateViewController

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

    if (_calledFromNavigationController == YES) {
        [super calledFromNavigationController];
    }
    else {
        [self.navigationItem setHidesBackButton:YES animated:NO];
    }
    NSString *screenTitle = [[NSString alloc] init];
    if ([_programType isEqualToString:@"thema"]) {
        self.trackedViewName = @"Program category: Dates";
        screenTitle = [NSLocalizedString(@"CATEGORIES", nil) uppercaseString];
    }
    else if ([_programType isEqualToString:@"free"]) {
        self.trackedViewName = @"Program free: Dates";
        screenTitle = [NSLocalizedString(@"FREE", nil) uppercaseString];
    }
    else if ([_programType isEqualToString:@"location"]) {
        self.trackedViewName = @"Program location: Dates";
        screenTitle = [NSLocalizedString(@"LOCATION", nil) uppercaseString];
    }
    else {
        self.trackedViewName = @"Program festival: Dates";
        screenTitle = [NSLocalizedString(@"FESTIVALS", nil) uppercaseString];
    }

    _dates = [GFDates sharedInstance];

    _tableView = [super addTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [super addTableViewHeaderWithTitle:screenTitle];
    [_tableView registerClass:[GFCustomCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    _today = (time_t) [[calendar dateFromComponents:components] timeIntervalSince1970];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _dates.count) {
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
    return _dates.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row < _dates.count) {
        static NSString *CellIdentifier = @"customCell";
        GFCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.label.text = [[_dates objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);
        if (_today == (time_t) [[[_dates objectAtIndex:indexPath.row] objectForKey:@"id"] intValue]) {
            cell.containerView.backgroundColor = UIColorFromRGB(0xfadbda);
        }
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

    if ([_programType isEqualToString:@"thema"]) {
        GFCalendarCategoryViewController *detail = [[GFCalendarCategoryViewController alloc] initWithNibName:nil bundle:nil];
        detail.timestamp = [[_dates objectAtIndex:indexPath.row] objectForKey:@"id"];
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if ([_programType isEqualToString:@"free"]) {
        GFEventsViewController *detail = [[GFEventsViewController alloc] initWithNibName:nil bundle:nil];
        detail.timestamp = [[_dates objectAtIndex:indexPath.row] objectForKey:@"id"];
        detail.programType = @"free";
        detail.screenTitle = NSLocalizedString(@"FREE", nil);
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if ([_programType isEqualToString:@"location"]) {
        GFLocationViewController *detail = [[GFLocationViewController alloc] initWithNibName:nil bundle:nil];
        detail.timestamp = [[_dates objectAtIndex:indexPath.row] objectForKey:@"id"]; 
        [self.navigationController pushViewController:detail animated:YES];
    }
    else {
        GFEventsViewController *detail = [[GFEventsViewController alloc] initWithNibName:nil bundle:nil];
        detail.timestamp = [[_dates objectAtIndex:indexPath.row] objectForKey:@"id"];
        detail.programType = @"festival";
        detail.screenTitle = NSLocalizedString(@"FESTIVALS", nil);
        [self.navigationController pushViewController:detail animated:YES];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
