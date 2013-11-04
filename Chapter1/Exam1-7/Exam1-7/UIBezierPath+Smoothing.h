//
//  UIBezierPath+Smoothing.h
//  Exam1-7
//
//  Created by 박경준 on 2013. 11. 4..
//  Copyright (c) 2013년 박경준. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Smoothing)
- (UIBezierPath *) smoothedPath: (int) granularity;
@end
