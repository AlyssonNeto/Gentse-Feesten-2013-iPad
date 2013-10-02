//
//  GFCustomViewController.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GAITrackedViewController.h"
#import "GFCustomYellowLabel.h"

@interface GFCustomViewController : GAITrackedViewController

-(UIBarButtonItem *)showMenuButton;

-(void)showAlertNoInternetConnection;

-(void)back;

-(UITableView *)addTableView;

-(UIView *)addTableViewHeaderWithTitle:(NSString *)title;

-(UIView *)addTableViewFooter;

-(void)calledFromNavigationController;

-(GFCustomYellowLabel *)headerLabel:(NSString *)title;

-(CGFloat)getHeightForString:(NSString *)string;

-(CGFloat)getHeightForString:(NSString *)string withWidth:(float)width;

-(CGFloat)getHeightForHeader:(NSString *)string withWidth:(float)width;

@end
