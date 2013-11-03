//
//  RootViewController.m
//  Exam1-5
//
//  Created by 박경준 on 2013. 11. 3..
//  Copyright (c) 2013년 Delpini. All rights reserved.
//

#import "RootViewController.h"
#import "DragView.h"

#define COOKBOOK_PURPLE_COLOR       [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR)  [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

#define MAXCIRCLES  12
#define SIDELENGTH  96.0f
#define HALFCIRCLE  48.0f
#define INSET_AMT   4

#define RANDOMLEVEL        ((random() % 128) / 256.0f)

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
    self.view.backgroundColor = [UIColor blackColor];
    // Add the circle
    for(int i = 0; i < MAXCIRCLES; i++)
    {
        DragView *dragger = [[DragView alloc] initWithImage:[self createImage]];
        dragger.center = [self randomPosition:self.interfaceOrientation];
        dragger.tag = 100 + i;
        // 테스트용 회색 백그라운드
        dragger.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:dragger];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
- (UIImage *) createImage
{
    UIColor *color = [UIColor colorWithRed:RANDOMLEVEL green:RANDOMLEVEL blue:RANDOMLEVEL alpha:1.0f];
    CGSize size = CGSizeMake(SIDELENGTH, SIDELENGTH);
    CGRect rect = (CGRect){.size = size};   // TODO : 문법?
    UIGraphicsBeginImageContext(size);
    
    // create a filled ellipse
    [color setFill];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path fill];
    
    // outline the circle a couple of times
    [[UIColor whiteColor] setStroke];
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect, INSET_AMT, INSET_AMT)];
    [path appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect, 2 * INSET_AMT, 2 * INSET_AMT)]];
    [path stroke];
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
- (CGPoint) randomPosition: (UIInterfaceOrientation) orientation
{
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
    CGFloat max = fmaxf(rect.size.width, rect.size.height);
    CGFloat min = fminf(rect.size.width, rect.size.height);
    
    CGFloat destw = min;
    CGFloat desth = max;
    if(UIInterfaceOrientationIsLandscape(orientation))
    {
        destw = max;
        desth = min;
    }
    CGFloat x = random() % ((int)(destw - 2 * HALFCIRCLE)) + HALFCIRCLE;
    CGFloat y = random() % ((int)(desth - 2 * HALFCIRCLE)) + HALFCIRCLE;
    return CGPointMake(x, y);
}

@end
