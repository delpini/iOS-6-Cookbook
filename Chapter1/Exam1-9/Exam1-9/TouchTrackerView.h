//
//  TouchTrackerView.h
//
//  Created by 박경준 on 2013. 11. 4..
//  Copyright (c) 2013년 박경준. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchTrackerView : UIView
{
    NSMutableArray *strokes;
    NSMutableDictionary *touchPaths;
}
- (void)clear;
@end
