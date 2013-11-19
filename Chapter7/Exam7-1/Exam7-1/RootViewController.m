//
//  RootViewController.m
//  Exam7-1
//
//  Created by 박경준 on 2013. 11. 19..
//  Copyright (c) 2013년 박경준. All rights reserved.
//

#import "RootViewController.h"

#define BARBUTTON(TITLE, SELECTOR) [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]
#define CONSTRAIN(VIEW, FORMAT)     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:(FORMAT) options:0 metrics:nil views:NSDictionaryOfVariableBindings(VIEW)]]
#define PREPCONSTRAINTS(VIEW) [VIEW setTranslatesAutoresizingMaskIntoConstraints:NO]

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
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"Push", @selector(push:));
    seg = [[UISegmentedControl alloc] initWithItems:[@"Foo*Bar*Bax*Qux" componentsSeparatedByString:@"*"]];
    seg.selectedSegmentIndex = 0;
    [self.view addSubview:seg];
    
    PREPCONSTRAINTS(seg);
    CONSTRAIN(seg, @"H:|-[seg(>=0)]-|");
    CONSTRAIN(seg, @"V:|-100-[seg]");
    
    UILabel *label = [self labelWithTitle:@"Select Title for Pushed Controller"];
    [self.view addSubview:label];
    PREPCONSTRAINTS(label);
    CONSTRAIN(label, @"H:|-[label(>=0)]-|");
    CONSTRAIN(label, @"V:|-70-[label]");
}

#pragma mark - selector
- (void)push:(id)sender
{
    NSString *newTitle = [@"Foo*Bar*Baz*Qux" componentsSeparatedByString:@"*"][seg.selectedSegmentIndex];
    
    UIViewController *newController = [[RootViewController alloc] init];
    newController.title = newTitle;
    
    [self.navigationController pushViewController:newController animated:YES];
}

#pragma mark - method
- (UILabel *) labelWithTitle: (NSString *) aTitle
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = aTitle;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Futura" size: 18.0f];
    label.numberOfLines = 999;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    return label;
}

@end
