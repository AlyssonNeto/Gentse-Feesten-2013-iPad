//
//  GFCalendarCategoryViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFCalendarCategoryViewController.h"
#import "GFCategories.h"
#import "GFCustomCell.h"
#import "GFEventsViewController.h"

@interface GFCalendarCategoryViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *categories;

@end

@implementation GFCalendarCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super calledFromNavigationController];


    _categories = [GFCategories sharedInstance];

    _tableView = [super addTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [super addTableViewHeaderWithTitle:[NSLocalizedString(@"CATEGORIES", nil) uppercaseString]];
    [_tableView registerClass:[GFCustomCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];

    self.trackedViewName = @"Program categories";

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <= _categories.count) {
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
    return _categories.count + 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row < _categories.count) {
        static NSString *CellIdentifier = @"customCell";
        GFCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.label.text = [[_categories objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);
        return cell;
    }
    else if (indexPath.row == _categories.count) {
        static NSString *CellIdentifier = @"customCell";
        GFCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.label.text = NSLocalizedString(@"ALL_CATEGORIES", nil);
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
    detail.programType = @"thema";
    if (indexPath.row < _categories.count) {
        detail.categoryID = [[[_categories objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
        detail.screenTitle = [[_categories objectAtIndex:indexPath.row] objectForKey:@"name"];
    }
    else {
        detail.categoryID = 0;
        detail.screenTitle = NSLocalizedString(@"ALL_CATEGORIES", nil);
    }

    [self.navigationController pushViewController:detail animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
