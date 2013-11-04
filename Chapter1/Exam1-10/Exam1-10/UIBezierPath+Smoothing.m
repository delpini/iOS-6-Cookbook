//
//  UIBezierPath+Smoothing.m
//  Exam1-7
//
//  Created by 박경준 on 2013. 11. 4..
//  Copyright (c) 2013년 박경준. All rights reserved.
//

#import "UIBezierPath+Smoothing.h"
#import "UIBezierPath+Points.h"

#define POINT(_INDEX_) [(NSValue *)[points objectAtIndex:_INDEX_] CGPointValue]

@implementation UIBezierPath (Smoothing)
- (UIBezierPath *)smoothedPath:(int)granularity
{
    NSMutableArray *points = [self.points mutableCopy];
    if(points.count < 4)
    {
        return [self copy];
    }
    
    // 연산 수행을 위해 수정 가능한 지점을 추가
    [points insertObject:[points objectAtIndex:0] atIndex:0];
    [points addObject:[points lastObject]];
    
    UIBezierPath *smoothedPath = [UIBezierPath bezierPath];
    // 경로를 복사
    smoothedPath.lineWidth = self.lineWidth;
    // 최초의 세 개 지점을 그림으로 표시(0..2)
    [smoothedPath moveToPoint:POINT(0)];
    
    for(int index = 1; index < 3; index++)
    {
        [smoothedPath addLineToPoint:POINT(index)];
    }
    
    for(int index = 4; index < points.count; index++)
    {
        CGPoint p0 = POINT(index - 3);
        CGPoint p1 = POINT(index - 2);
        CGPoint p2 = POINT(index - 1);
        CGPoint p3 = POINT(index);
        
        // p2에 Catmull-Rom 알고리즘 적용을 할 때까지, p1 + dx / dy에서 시작되는 n개의 지점을 추가
        for(int i = 1; i < granularity; i++)
        {
            float t = (float)i * (1.0f / (float)granularity);
            float tt = t * t;
            float ttt = tt * t;
            
            CGPoint pi;
            pi.x = 0.5 * (2*p1.x+(p2.x-p0.x)*t + (2*p0.x-5*p1.x+4*p2.x-p3.x)*tt + (3*p1.x-p0.x-3*p2.x+p3.x)*ttt);
            pi.y = 0.5 * (2*p1.y+(p2.y-p0.y)*t + (2*p0.y-5*p1.y+4*p2.y-p3.y)*tt + (3*p1.y-p0.y-3*p2.y+p3.y)*ttt);
            [smoothedPath addLineToPoint:pi];
        }
        
        // add p2
        [smoothedPath addLineToPoint:p2];
    }
    // 마지막 지점을 추가하고 결과값을 반환
    [smoothedPath addLineToPoint:POINT(points.count - 1)];
    
    return smoothedPath;
}

@end
