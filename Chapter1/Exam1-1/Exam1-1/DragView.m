//
//  DragView.m
//  Exam1-1
//
//  Created by 박경준 on 2013. 11. 3..
//  Copyright (c) 2013년 Delpini. All rights reserved.
//

#import "DragView.h"

@implementation DragView

- (id)initWithImage:(UIImage *)image
{
    if(self = [super initWithImage:image]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 오프셋 값을 계산한 후 저장하고, 필요에 따라 하위 뷰를 앞으로 이동.
    startLocation = [[touches anyObject] locationInView:self];
    [self.superview bringSubviewToFront:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 오프셋 값을 계산
    CGPoint pt = [[touches anyObject] locationInView:self];
    float dx = pt.x - startLocation.x;
    float dy = pt.y - startLocation.y;
    CGPoint newCenter = CGPointMake(self.center.x + dx,
                                    self.center.y + dy);
    // 새로운 위치 설정
    self.center = newCenter;
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
