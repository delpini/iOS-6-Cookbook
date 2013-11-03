//
//  DragView.m
//  Exam1-3
//
//  Created by 박경준 on 2013. 11. 3..
//  Copyright (c) 2013년 Delpini. All rights reserved.
//

#import "DragView.h"

@implementation DragView

- (id)initWithImage:(UIImage *)image
{
    // 초기화 후 터치 가능 영역으로 설정
    if(!(self = [super initWithImage:image])) return nil;
    self.userInteractionEnabled = YES;
    
    // 모든 위치 값 초기화
    self.transform = CGAffineTransformIdentity;
    tx = 0.0f;
    ty = 0.0f;
    scale = 1.0f;
    theta = 0.0f;
    // 통합된 제스처 인식자 구현
    UIRotationGestureRecognizer *rot = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleRotation:)];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handlePinch:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(handlePan:)];
    self.gestureRecognizers = @[rot, pinch, pan];
    for(UIGestureRecognizer *recognizer in self.gestureRecognizers)
    {
        recognizer.delegate = self;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 터치한 뷰를 맨 앞으로 이동
    [self.superview bringSubviewToFront:self];
    // 이동 오프셋 값을 초기화
    tx = self.transform.tx;
    ty = self.transform.ty;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(touch.tapCount == 3)
    {
        // 트리플 탭 동작 시, 모든 위치 값 초기화
        self.transform = CGAffineTransformIdentity;
        tx = 0.0f;
        ty = 0.0f;
        scale = 1.0f;
        theta = 0.0f;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark - Method
- (void)handlePan: (UIPanGestureRecognizer*) uigr
{
    CGPoint translation = [uigr translationInView:self.superview];
    [self updateTransformWithOffset:translation];
}

- (void)handleRotation: (UIRotationGestureRecognizer *) uigr
{
    theta = uigr.rotation;
    [self updateTransformWithOffset:CGPointZero];
}

- (void)handlePinch: (UIPinchGestureRecognizer *) uigr
{
    scale = uigr.scale;
    [self updateTransformWithOffset:CGPointZero];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)updateTransformWithOffset: (CGPoint) translation
{
    // 이동, 회전, 크기 변환을 혼합한 객체 생성
    self.transform = CGAffineTransformMakeTranslation(translation.x + tx, translation.y + ty);
    self.transform = CGAffineTransformRotate(self.transform, theta);
    self.transform = CGAffineTransformScale(self.transform, scale, scale);
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
