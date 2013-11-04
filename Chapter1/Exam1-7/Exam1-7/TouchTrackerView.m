//
//  TouchTrackerView.m
//  Exam1-7
//
//  Created by 박경준 on 2013. 11. 4..
//  Copyright (c) 2013년 박경준. All rights reserved.
//

#import "TouchTrackerView.h"
#import "UIBezierPath+Smoothing.h"

#define COOKBOOK_PURPLE_COLOR        [UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]

@implementation TouchTrackerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 사용자 제스쳐 인식을 위한 새 경로 초기화
    path = [UIBezierPath bezierPath];
    path.lineWidth = 4.0f;
    UITouch *touch = [touches anyObject];
    [path moveToPoint:[touch locationInView:self]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 경로에 터치로 인식된 새 지점 추가
    UITouch *touch = [touches anyObject];
    [path addLineToPoint:[touch locationInView:self]];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [path addLineToPoint:[touch locationInView:self]];
    path = [path smoothedPath:4];
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)drawRect:(CGRect)rect
{
    [COOKBOOK_PURPLE_COLOR set];
    [path stroke];
}

- (void)clear
{
    path = nil;
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
