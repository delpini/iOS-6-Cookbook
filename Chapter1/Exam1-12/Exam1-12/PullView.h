//
//  PullView.h
//
//  Created by 박경준 on 2013. 11. 5..
//  Copyright (c) 2013년 Delpini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DragView.h"

@interface PullView : UIImageView <UIGestureRecognizerDelegate>
{
    DragView *dv;
    BOOL gestureWasHandled;
	int pointCount;
	CGPoint startPoint;
	NSUInteger touchtype;
}

@end
