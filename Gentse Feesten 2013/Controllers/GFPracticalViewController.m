//
//  GFPracticalViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 12/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFPracticalViewController.h"
#import "GFParkingListViewController.h"
#import "GFCustomCell.h"
#import "GFPoiMapViewController.h"

@interface GFPracticalViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *menu;

@end

@implementation GFPracticalViewController

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

    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    _menu = [[NSArray alloc] initWithObjects:@"Publiek sanitair", @"Parkings", nil];

    _tableView = [super addTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [super addTableViewHeaderWithTitle:@"PRAKTISCH"];
    [_tableView registerClass:[GFCustomCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];

    self.trackedViewName = @"Practical";

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menu.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"customCell";
    GFCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.label.text = [_menu objectAtIndex:indexPath.row];
    cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [super addTableViewFooter];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.row == 0) {
        GFPoiMapViewController *detail = [[GFPoiMapViewController alloc] initWithNibName:nil bundle:nil];
        detail.calledFromNavigationController = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if (indexPath.row == 1) {
        GFParkingListViewController *detail = [[GFParkingListViewController alloc] initWithNibName:nil bundle:nil];
        detail.calledFromNavigationController = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

@end
