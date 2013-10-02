//
//  GFWebViewController.m
//  #GF13
//
//  Created by Tim Leytens on 16/06/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//
#import "GFWebViewController.h"
#import "GFCustomToolBar.h"

@interface GFWebViewController ()

@end

@implementation GFWebViewController

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

    self.view.backgroundColor = UIColorFromRGB(0x005470);

    GFCustomToolBar *toolbar = [[GFCustomToolBar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.height, 44);
    
    UIImage *closeButtonImage = [UIImage imageNamed:@"close.png"];
    UIImage *closeButtonImageActive = [UIImage imageNamed:@"close.png"];
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [closeButton setBackgroundImage:closeButtonImage forState:UIControlStateNormal];
    [closeButton setBackgroundImage:closeButtonImageActive forState:UIControlStateHighlighted];

    [closeButton setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.height - (padding / 2) - closeButtonImage.size.width, padding / 2, closeButtonImage.size.width, closeButtonImage.size.height)];

    [closeButton addTarget:self
                    action:@selector(dismissModal:)
          forControlEvents:UIControlEventTouchDown];

    [toolbar addSubview:closeButton];

    [self.view addSubview:toolbar];


    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, toolbar.frame.size.height + 1, self.view.frame.size.height, self.view.frame.size.width - toolbar.frame.size.height)];
    webview.scalesPageToFit = YES;

    NSURL *nsurl = [NSURL URLWithString:_url];
    NSURLRequest *nsrequest = [NSURLRequest requestWithURL:nsurl];
    [webview loadRequest:nsrequest];
    [self.view addSubview:webview];

    self.trackedViewName = @"More info";
    
}


- (void)dismissModal:(id)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
