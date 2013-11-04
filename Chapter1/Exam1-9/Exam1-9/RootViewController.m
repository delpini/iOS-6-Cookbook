//
//  RootViewController.m
//
//  Created by 박경준 on 2013. 11. 3..
//  Copyright (c) 2013년 Delpini. All rights reserved.
//

#import "RootViewController.h"
#import "TouchTrackerView.h"

#define COOKBOOK_PURPLE_COLOR       [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR)  [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

#define RESIZABLE(_VIEW_) [_VIEW_ setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth]

@interface RootViewController ()

@end

@implementation RootViewController

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
	// Do any additional setup after loading the view.
    self.title = NSBundle.mainBundle.infoDictionary  [@"CFBundleDisplayName"];
}

- (void)loadView
{
    [super loadView];
    self.view = [[TouchTrackerView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    RESIZABLE(self.view);
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self clear];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
- (void) clear
{
    
}

@end
