//
//  GFParkingListViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 11/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "GFParkingListViewController.h"
#import "GFDatatankAPIClient.h"
#import "AFNetworking.h"
#import "GFParkingDetailViewController.h"
#import "GFParkingsCustomCell.h"
#import "GFFontSmall.h"

@interface GFParkingListViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *responseData;

@end

@implementation GFParkingListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad {

    [super viewDidLoad];

    if (_calledFromNavigationController == YES) {
        [super calledFromNavigationController];
    }
    else {
        [self.navigationItem setHidesBackButton:YES animated:NO];
    }

    _tableView = [super addTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [super addTableViewHeaderWithTitle:[NSLocalizedString(@"PARKINGS", nil) uppercaseString]];
    [_tableView registerClass:[GFParkingsCustomCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];

    [[GFDatatankAPIClient sharedInstance] getPath:@"Mobiliteitsbedrijf/Parkings11.json" parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id response) {

                                      _responseData = [NSMutableArray array];
                                      for (id parking in [[response objectForKey:@"Parkings11"] objectForKey:@"parkings"]) {
                                          [_responseData addObject:parking];
                                      }
                                      [self.tableView reloadData];
                                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                                      [super showAlertNoInternetConnection];
                                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                  }];

    self.trackedViewName = @"Parkings";
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _responseData.count > 0 ? _responseData.count : 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_responseData.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(padding * 2, 0, self.view.frame.size.height - 320 - padding * 4, 55)];
        label.font = [GFFontSmall sharedInstance];
        label.textColor = [UIColor darkGrayColor];
        label.highlightedTextColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"LOADING_PARKINGS", nil);
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
        static NSString *CellIdentifier = @"customCell";
        GFParkingsCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.label.text = [[_responseData objectAtIndex:indexPath.row] objectForKey:@"description"];
        cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);
        cell.count.text = [[_responseData objectAtIndex:indexPath.row] objectForKey:@"availableCapacity"];
        if ([[[_responseData objectAtIndex:indexPath.row] objectForKey:@"availableCapacity"] isEqual: @"VOL"]) {
            cell.count.textColor = UIColorFromRGB(0xe64a45);
        }
        else {
            cell.count.textColor = UIColorFromRGB(0x00bb42);
        }
        return cell;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [super addTableViewFooter];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_responseData.count > 0) {
        [_tableView deselectRowAtIndexPath:indexPath animated:NO];
        GFParkingDetailViewController *detail = [[GFParkingDetailViewController alloc] initWithNibName:nil bundle:nil];
        detail.latitude = [[[_responseData objectAtIndex:indexPath.row] objectForKey:@"latitude"] floatValue];
        detail.longitude = [[[_responseData objectAtIndex:indexPath.row] objectForKey:@"longitude"] floatValue];
        detail.label = [[[_responseData objectAtIndex:indexPath.row] objectForKey:@"description"] uppercaseString];

        detail.description = [NSString stringWithFormat:@"%@: %@", [[_responseData objectAtIndex:indexPath.row] objectForKey:@"name"], [[_responseData objectAtIndex:indexPath.row] objectForKey:@"description"]];
        detail.description = [detail.description stringByAppendingFormat:@"\n%@", [[[_responseData objectAtIndex:indexPath.row] objectForKey:@"address"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"]];
        detail.description = [detail.description stringByAppendingFormat:@"\n%@", [[_responseData objectAtIndex:indexPath.row] objectForKey:@"contactInfo"]];
        detail.description = [detail.description stringByAppendingFormat:@"\n%@", [[_responseData objectAtIndex:indexPath.row] objectForKey:@"openingHours"]];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

@end
