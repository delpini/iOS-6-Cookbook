//
//  DragView.h
//  Exam1-1
//
//  Created by 박경준 on 2013. 11. 3..
//  Copyright (c) 2013년 Delpini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragView : UIImageView<UIGestureRecognizerDelegate> {
    CGFloat tx;     // x축 이동
    CGFloat ty;     // y축 이동
    CGFloat scale;  // 크기 변환
    CGFloat theta;  // 회전 각도
}

@end
