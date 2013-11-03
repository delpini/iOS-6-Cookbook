//
//  DragView.m
//  Exam1-5
//
//  Created by 박경준 on 2013. 11. 3..
//  Copyright (c) 2013년 Delpini. All rights reserved.
//

#import "DragView.h"

#define SIDELENGTH  96.0f

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
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// 원 내부에서만 터치 이벤트를 받을 수 있게 한다.
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint pt;
    float HALFSIDE = SIDELENGTH / 2.0f;
    // 중앙 원점 초기화
    pt.x = (point.x - HALFSIDE) / HALFSIDE;
    pt.y = (point.y - HALFSIDE) / HALFSIDE;
    // x^2 + y^2 = radios ^2
    float xsquared = pt.x * pt.x;
    float ysquared = pt.y * pt.y;
    
    // 반지름이 1 이하이면 터치 지점은 원 내부에 있음
    if((xsquared + ysquared) <= 1.0)
    {
        return YES;
    }
    return NO;   
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
    CGPoint newcenter = CGPointMake(previousLocation.x + translation.x,
                                    previousLocation.y + translation.y);
    // 부모 뷰의 경계선으로 이동을 제한
    float halfx = CGRectGetMidX(self.bounds);
    newcenter.x = MAX(halfx, newcenter.x);
    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
    
    float halfy = CGRectGetMidY(self.bounds);
    newcenter.y = MAX(halfy, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
    
    // 새로운 중심 위치 설정
    super.center = newcenter;
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
