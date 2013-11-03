//
//  RootViewController.m
//  Exam1-2
//
//  Created by 박경준 on 2013. 11. 3..
//  Copyright (c) 2013년 Delpini. All rights reserved.
//

#import "RootViewController.h"
#import "DragView.h"

#define COOKBOOK_PURPLE_COLOR       [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR)  [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor blackColor];
    
    NSInteger maxFlowers = 12;
    NSArray *flowerArray = @[@"blueFlower.png", @"pinkFlower.png", @"orangeFlower.png"];
    
    for(int i = 0; i < maxFlowers; i++)
    {
        NSString *whichFlower = [flowerArray objectAtIndex:(random() % flowerArray.count)];
        DragView *flowerDragger = [[DragView alloc] initWithImage:[UIImage imageNamed:whichFlower]];
        [self.view addSubview:flowerDragger];
    }
    // Provide a "Randomize" button
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"Randomize", @selector(layoutFlowers));
}

#pragma mark - Method
- (void)layoutFlowers
{
    [UIView animateWithDuration:0.3f animations:^(){
        for(UIView *flowerDragger in self.view.subviews) {
            flowerDragger.center = [self randomFlowerPosition];
        }
    }];
}

- (CGPoint) randomFlowerPosition
{
    CGFloat halfFlower = 32.0f;
    
    CGSize insetSize = CGRectInset(self.view.bounds, 2 * halfFlower, 2 * halfFlower).size;
    
    CGFloat randomX = random() % ((int)insetSize.width) + halfFlower;
    CGFloat randomY = random() % ((int)insetSize.height) + halfFlower;
    
    return CGPointMake(randomX, randomY);
}

@end
