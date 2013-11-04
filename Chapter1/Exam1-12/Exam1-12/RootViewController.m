//
//  RootViewController.m
//
//  Created by 박경준 on 2013. 11. 3..
//  Copyright (c) 2013년 Delpini. All rights reserved.
//

#import "RootViewController.h"
#import "DragView.h"
#import "PullView.h"
#import "UIColor-Random.h"

#define COOKBOOK_PURPLE_COLOR       [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR)  [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

#define IS_IPAD	(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define SIDE		(IS_IPAD ? 160.0f : 80.0f)
#define NUM_OBJECTS	10

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

- (void)viewDidAppear:(BOOL)animated
{
    scrollView.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, SIDE);
}

- (void) viewDidLayoutSubviews
{
    [self viewDidAppear:NO];
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
	self.navigationItem.rightBarButtonItem = BARBUTTON(@"Clear", @selector(clear));
	self.navigationItem.leftBarButtonItem = BARBUTTON(@"Colors", @selector(recolor));
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
	scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	scrollView.contentSize = CGSizeMake(SIDE * NUM_OBJECTS, SIDE);
    [self.view addSubview:scrollView];
    
	[self setColors];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (UIDeviceOrientationIsLandscape(toInterfaceOrientation));
}

#pragma mark - Method
- (void) clear
{
	for (UIView *view in self.view.subviews)
    {
        if (view != scrollView)
        {
            [view removeFromSuperview];
        }
    }
}

// Set the random contents of the scroll view
- (void) setColors
{
	float offset = 0.0f;
	for (int i = 0; i < NUM_OBJECTS; i++)
	{
		UIImage *image = randomBlockImage(SIDE, IS_IPAD ? 30.0f : 15.0f);
		PullView *pullView = [[PullView alloc] initWithImage:image];
		pullView.frame = CGRectMake(offset, 0.0f, SIDE, SIDE);
		[scrollView addSubview:pullView];
		
		offset += SIDE;
	}
}

// Force an update of the scroll view elements
- (void) recolor
{
	for (UIView *view in scrollView.subviews)
		if ([[view class] isKindOfClass:[PullView class]])
			[view removeFromSuperview];
	
	[self setColors];
}

@end
