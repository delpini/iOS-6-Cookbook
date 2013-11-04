//
//  TouchTrackerView.m
//
//  Created by 박경준 on 2013. 11. 4..
//  Copyright (c) 2013년 박경준. All rights reserved.
//

#import "TouchTrackerView.h"
#import "UIBezierPath+Smoothing.h"

#define IS_IPAD        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define COOKBOOK_PURPLE_COLOR        [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]

@implementation TouchTrackerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled = YES;
        strokes = [NSMutableArray array];
        touchPaths = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(UITouch * touch in touches)
    {
        NSString *key = [NSString stringWithFormat:@"%d", (int)touch];
        CGPoint pt = [touch locationInView:self];
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth = IS_IPAD ? 8.0f : 4.0f;
        path.lineCapStyle = kCGLineCapRound;
        [path moveToPoint:pt];
        [touchPaths setObject:path forKey:key];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        NSString *key = [NSString stringWithFormat:@"%d", (int) touch];
        UIBezierPath *path = [touchPaths objectForKey:key];
        if (!path)
        {
            break;
        }
        
        CGPoint pt = [touch locationInView:self];
        [path addLineToPoint:pt];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        NSString *key = [NSString stringWithFormat:@"%d", (int) touch];
        UIBezierPath *path = [touchPaths objectForKey:key];
        if (path) {
            path = [path smoothedPath:4];
            [strokes addObject:path];
        }
        [touchPaths removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)drawRect:(CGRect)rect
{
    [COOKBOOK_PURPLE_COLOR set];
    for (UIBezierPath *path in strokes)
    {
        [path stroke];
    }
    [[COOKBOOK_PURPLE_COLOR colorWithAlphaComponent:0.5f] set];
    for (UIBezierPath *path in [touchPaths allValues])
    {
        [path stroke];
    }
}

# pragma mark - Method
// clear메소드가 실행되면 현재 그리고 있는 선을 제외하고 기존의 모든 선을 삭제한다.
- (void)clear
{
    [strokes removeAllObjects];
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
