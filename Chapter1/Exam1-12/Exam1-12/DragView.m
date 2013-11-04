//
//  DragView.m
//
//  Created by 박경준 on 2013. 11. 3..
//  Copyright (c) 2013년 Delpini. All rights reserved.
//

#import "DragView.h"

@implementation DragView

- (id)initWithImage:(UIImage *)image
{
    if(self = [super initWithImage:image])
    {
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(handlePan:)];
        self.gestureRecognizers = @[panRecognizer];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 터치한 뷰를 맨 앞으로 이동
    [self.superview bringSubviewToFront:self];
    // 원래의 중심 위치를 저장
    previousLocation = self.center;
}

#pragma mark - Method
- (void) handlePan: (UIPanGestureRecognizer*) uigr
{
    CGPoint translation = [uigr translationInView:self.superview];
	self.center = CGPointMake(previousLocation.x + translation.x, previousLocation.y + translation.y);
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
