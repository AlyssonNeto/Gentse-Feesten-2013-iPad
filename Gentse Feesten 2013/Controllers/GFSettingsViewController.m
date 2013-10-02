//
//  GFSettingsViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "GFSettingsViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "GFEventsDataModel.h"
#import "GFEvent.h"
#import "GFAPIClient.h"
#import "GFCategories.h"
#import "GFCustomInterestsCell.h"

@interface GFSettingsViewController () {
    MBProgressHUD *_hud;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *categories;

@end

@implementation GFSettingsViewController

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

    self.trackedViewName = @"Settings";

    _categories = [GFCategories sharedInstance];
    
    _tableView = [super addTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height - 320 - padding * 2, 185)];
    GFCustomYellowLabel *headerLabel = [[GFCustomYellowLabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.height - 320 - padding * 2, 28)];
    headerLabel.text = [NSLocalizedString(@"SETTINGS", nil) uppercaseString];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.backgroundColor = UIColorFromRGB(0x005470);

    [containerView addSubview:headerLabel];

    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [updateButton addTarget:self
                     action:@selector(updateProgram)
           forControlEvents:UIControlEventTouchDown];
    [updateButton setTitle:[NSLocalizedString(@"UPDATE_PROGRAM", nil) uppercaseString] forState:UIControlStateNormal];
    updateButton.frame = CGRectMake(0, headerLabel.frame.origin.y + headerLabel.frame.size.height + padding, self.view.frame.size.height - 320 - (padding * 2), 55.0);
    updateButton.backgroundColor = UIColorFromRGB(0xed4e40);

    updateButton.layer.masksToBounds = NO;
    updateButton.layer.shadowColor = UIColorFromRGB(0x043c4b).CGColor;
    updateButton.layer.shadowOpacity = 1;
    updateButton.layer.shadowRadius = 0;
    updateButton.layer.shadowOffset = CGSizeMake(2.0f, 3.0f);

    [containerView addSubview:updateButton];

    GFCustomYellowLabel *interestsLabel = [[GFCustomYellowLabel alloc] initWithFrame:CGRectMake(0, updateButton.frame.origin.y + updateButton.frame.size.height + (padding * 3), self.view.frame.size.height - 320 - padding * 2, 28)];
    interestsLabel.text = [NSLocalizedString(@"INTERESTS", nil) uppercaseString];
    interestsLabel.textAlignment = NSTextAlignmentCenter;
    interestsLabel.backgroundColor = UIColorFromRGB(0x005470);

    [containerView addSubview:interestsLabel];

    UIImage *tableTop = [UIImage imageNamed:@"tableTop.png"];
    UIImageView *tableTopView = [[UIImageView alloc] initWithImage:tableTop];
    tableTopView.frame = CGRectMake(0, interestsLabel.frame.size.height + interestsLabel.frame.origin.y + padding, tableTop.size.width, tableTop.size.height);
    [containerView addSubview:tableTopView];
    
    _tableView.tableHeaderView = containerView;

    [_tableView registerClass:[GFCustomInterestsCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];

}


-(void)updateProgram {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }

    [_hud setMode:MBProgressHUDModeIndeterminate];
    [_hud setLabelText:NSLocalizedString(@"FETCHING", nil)];
    [self.view addSubview:_hud];
    
    [[GFAPIClient sharedInstance] getPath:@"events/list.json" parameters:nil
                                          success:^(AFHTTPRequestOperation *operation, id response) {
                                              [self parseEvents:response];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              [super showAlertNoInternetConnection];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              [_hud show:NO];
                                          }];

    [_hud show:YES];
    _hud.dimBackground = YES;
}

- (void)parseEvents:(id)events {
    [_hud setMode:MBProgressHUDModeDeterminate];
    [_hud setProgress:0];
    [_hud setLabelText:NSLocalizedString(@"IMPORTING", nil)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSInteger totalRecords = [events count];
        NSInteger currentRecord = 0;

        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:[[GFEventsDataModel sharedDataModel] persistentStoreCoordinator]];

        for (NSDictionary *dictionary in events) {
            NSInteger serverId = [[dictionary objectForKey:@"id"] intValue];
            GFEvent *event = [GFEvent eventWithServerId:serverId usingManagedObjectContext:context];
            if (event == nil) {
                event = [GFEvent insertInManagedObjectContext:context];
                [event setServerId:[NSNumber numberWithInteger:serverId]];
            }

            [event updateAttributes:dictionary];

            currentRecord++;

            dispatch_async(dispatch_get_main_queue(), ^{
                float percent = ((float)currentRecord) / totalRecords;
                [_hud setProgress:percent];
            });
        }

        NSError *error = nil;
        if ([context save:&error]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_hud setLabelText:NSLocalizedString(@"DONE", nil)];
                _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                _hud.mode = MBProgressHUDModeCustomView;
                [_hud hide:YES afterDelay:2.0];
            });
        } else {
            exit(1);
        }
    });
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _categories.count) {
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
    return _categories.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row < _categories.count) {
        static NSString *CellIdentifier = @"customCell";
        GFCustomInterestsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.label.text = [[_categories objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);

        UISwitch *onoff = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 105, 15, 0, 0)];

        [onoff addTarget: self action: @selector(toggleInterests:) forControlEvents: UIControlEventValueChanged];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        id key = [NSString stringWithFormat:@"interests-%@", [[_categories objectAtIndex:indexPath.row] objectForKey:@"id"]];
        bool value = [defaults boolForKey:key];

        onoff.on = value;
        
        [cell.containerView addSubview:onoff];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

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
}

- (void)toggleInterests:(UISwitch*)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        id key = [NSString stringWithFormat:@"interests-%@", [[_categories objectAtIndex:indexPath.row] objectForKey:@"id"]];

        bool newValue = sender.on ? YES : NO;

        [defaults setBool:newValue forKey:key];
        [defaults synchronize];
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
