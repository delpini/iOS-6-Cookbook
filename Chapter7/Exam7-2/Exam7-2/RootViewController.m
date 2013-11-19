//
//  RootViewController.m
//  Exam7-2
//
//  Created by 박경준 on 2013. 11. 19..
//  Copyright (c) 2013년 박경준. All rights reserved.
//

#import "RootViewController.h"

#define BARBUTTON(TITLE, SELECTOR) [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"Action", @selector(action:));
    
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:[@"Slide*Fade*Flip*Curl" componentsSeparatedByString:@"*"]];
    sc.selectedSegmentIndex = 0;
    //sc.segmentedControlStyle = UISegmentedControlStyleBar;
    self.navigationItem.titleView = sc;
}

#pragma mark - method
- (void)action: (id)sender
{
    // story board
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Modal~iPhone" bundle:[NSBundle mainBundle]];
    UINavigationController *nc = [sb instantiateViewControllerWithIdentifier:@"infoNavigationController"];
    
    // Select the transition style
	int styleSegment = [(UISegmentedControl *)self.navigationItem.titleView selectedSegmentIndex];
	int transitionStyles[4] = {UIModalTransitionStyleCoverVertical, UIModalTransitionStyleCrossDissolve, UIModalTransitionStyleFlipHorizontal, UIModalTransitionStylePartialCurl};
	nc.modalTransitionStyle = transitionStyles[styleSegment];
    
    [self.navigationController presentViewController:nc animated:YES completion:nil];
}

@end
