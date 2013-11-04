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
    if(self = [super initWithImage:image]) {
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *panRecognizer = [[UILongPressGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(pressed:)];
        [self addGestureRecognizer:panRecognizer];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
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

#pragma mark - Method
- (void)pressed: (UILongPressGestureRecognizer *)recognizer
{
    if (![self becomeFirstResponder])
    {
        NSLog(@"Could not become first responder");
        return;
    }
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    UIMenuItem *pop = [[UIMenuItem alloc] initWithTitle:@"Pop" action:@selector(popSelf)];
    UIMenuItem *rotate = [[UIMenuItem alloc] initWithTitle:@"Rotate" action:@selector(rotateSelf)];
    UIMenuItem *ghost = [[UIMenuItem alloc] initWithTitle:@"Ghost" action:@selector(ghostSelf)];
    [menu setMenuItems:@[pop, rotate, ghost]];
    
    [menu setTargetRect:self.bounds inView:self];
    menu.arrowDirection = UIMenuControllerArrowDown;
    [menu update];
    
    [menu setMenuVisible:YES];
}

- (void)popSelf
{
    [UIView animateWithDuration:0.25f
                     animations:^(){self.transform = CGAffineTransformMakeScale(1.5f, 1.5f);}
                     completion:^(BOOL done){[UIView animateWithDuration:0.1f animations:^(){self.transform = CGAffineTransformIdentity;}];
                     }];
}

- (void) rotateSelf
{
    // This is harder than it looks
    [UIView animateWithDuration:0.25f animations:^(){self.transform = CGAffineTransformMakeRotation(M_PI * .95);} completion:^(BOOL done){
        [UIView animateWithDuration:0.25f animations:^(){self.transform = CGAffineTransformMakeRotation(M_PI * 1.5);} completion:^(BOOL done){self.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void) ghostSelf
{
    [UIView animateWithDuration:1.25f animations:^(){self.alpha = 0.0f;} completion:^(BOOL done){
        [UIView animateWithDuration:1.25f animations:^(){} completion:^(BOOL done){
            [UIView animateWithDuration:0.5f animations:^(){self.alpha = 1.0f;}];
        }];
    }];
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
