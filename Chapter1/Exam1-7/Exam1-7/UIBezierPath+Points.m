//
//  UIBezierPath+Points.m
//  Exam1-7
//
//  Created by 박경준 on 2013. 11. 4..
//  Copyright (c) 2013년 박경준. All rights reserved.
//

#import "UIBezierPath+Points.h"
#define VALUE(_INDEX_) [NSValue valueWithCGPoint:points[_INDEX_]]

@implementation UIBezierPath (Points)

void getPointsFromBezier(void *info, const CGPathElement *element)
{
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    
    // 경로 요소의 타입과 지점 정보를 가져옴
    CGPathElementType type = element->type;
    CGPoint *points = element->points;
    
    // 하위 경로의 마지막 지점이 아닌 경우, 타입별로 새 지점을 추가
    if(type != kCGPathElementCloseSubpath)
    {
        [bezierPoints addObject:VALUE(0)];
        if((type != kCGPathElementAddLineToPoint) && (type != kCGPathElementMoveToPoint))
        {
            [bezierPoints addObject:VALUE(1)];
        }
    }
    if(type == kCGPathElementAddCurveToPoint)
    {
        [bezierPoints addObject:VALUE(2)];
    }
}

- (NSArray *)points
{
    NSMutableArray *points =[NSMutableArray array];
    CGPathApply(self.CGPath, (__bridge void *)points, getPointsFromBezier);
    
    return points;
}

@end
