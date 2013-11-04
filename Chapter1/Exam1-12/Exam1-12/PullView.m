//
//  PullView.m
//
//  Created by 박경준 on 2013. 11. 5..
//  Copyright (c) 2013년 Delpini. All rights reserved.
//

#import "PullView.h"

#define DX(p1, p2)	(p2.x - p1.x)
#define DY(p1, p2)	(p2.y - p1.y)

#define SWIPE_DRAG_MIN 16
#define DRAGLIMIT_MAX 12

// 스와이프 유형의 터치 정의
typedef enum {
	TouchUnknown,
	TouchSwipeLeft,
	TouchSwipeRight,
	TouchSwipeUp,
	TouchSwipeDown,
} SwipeTypes;

@implementation PullView
// 내장된 팬 제스쳐 인식자를 이용할 수 있는 뷰 생성
- (id) initWithImage: (UIImage *) image
{
	if (self = [super initWithImage:image])
	{
		self.userInteractionEnabled = YES;
		UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        pan.delegate = self;
		self.gestureRecognizers = @[pan];
	}
	return self;
}

// 동시에 여러 터치 인식
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

// 스와이프 동작을 감지하면 팬 제스쳐로 처리
- (void) handlePan: (UIPanGestureRecognizer *) uigr
{
	// 스크롤 뷰의 상위 뷰에만 반응
	if (![self.superview isKindOfClass:[UIScrollView class]]) return;
    
    // 상위 뷰를 추출
	UIView *supersuper = self.superview.superview;
	UIScrollView *scrollView = (UIScrollView *) self.superview;
	
	// 터치의 위치를 계산
	CGPoint touchLocation = [uigr locationInView:supersuper];
	// 인식자의 상태 정보에 따라 터치 처리
	if (uigr.state == UIGestureRecognizerStateBegan)
	{
		// 초기화
		gestureWasHandled = NO;
		pointCount = 1;
		startPoint = touchLocation;
	}
	
    if (uigr.state == UIGestureRecognizerStateChanged)
    {
        pointCount++;
        
        // 스와이프 동작이 발생했는지 계산
        float dx = DX(touchLocation, startPoint);
        float dy = DY(touchLocation, startPoint);
        
        // 스와이프 타입 감지
        BOOL finished = YES;
        if ((dx > SWIPE_DRAG_MIN) && (ABS(dy) < DRAGLIMIT_MAX)) // hswipe left
        {
            touchtype = TouchSwipeLeft;
        }
        else if ((-dx > SWIPE_DRAG_MIN) && (ABS(dy) < DRAGLIMIT_MAX)) // hswipe right
        {
            touchtype = TouchSwipeRight;
        }
        else if ((dy > SWIPE_DRAG_MIN) && (ABS(dx) < DRAGLIMIT_MAX)) // vswipe up
        {
            touchtype = TouchSwipeUp;
        }
        else if ((-dy > SWIPE_DRAG_MIN) && (ABS(dx) < DRAGLIMIT_MAX)) // vswipe down
        {
            touchtype = TouchSwipeDown;
        }
        else
        {
            finished = NO;
        }
        
        // 종료된 터치 동작이 다른 제스처로 처리되지 않았고, 하향 스와이프 동작인 경우 새로운 드래그 뷰 생성
        if (!gestureWasHandled && finished && (touchtype == TouchSwipeDown))
        {
            dv = [[DragView alloc] initWithImage:self.image];
            dv.center = touchLocation;
            dv.backgroundColor = [UIColor clearColor];
            [supersuper addSubview:dv];
            scrollView.scrollEnabled = NO;
            gestureWasHandled = YES;
        }
        else if (gestureWasHandled)
        {
            // 터치 인식과 처리 후에도 계속 드래그
            dv.center = touchLocation;
        }
    }
    
    if (uigr.state == UIGestureRecognizerStateEnded)
    {
        // 터치 종료 후에도 스크롤 뷰는 계속 스크롤 가능하게 설정
        if (gestureWasHandled)
            scrollView.scrollEnabled = YES;
    }
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
