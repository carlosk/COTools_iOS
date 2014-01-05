//
//  UIControl+CO.h
//  COTools
//
//  Created by carlos on 14-1-5.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (CO)
//把UIControlEvents改成block
- (void)handleControlEvent:(UIControlEvents)event withBlock:(void(^)(id sender))block;
- (void)removeHandlerForEvent:(UIControlEvents)event;
@end
