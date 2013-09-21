//
//  NSObject+CO.h
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//haha

#import <Foundation/Foundation.h>

@interface NSObject (CO)
//是否是空的
- (BOOL)isEmpty;
//是否是不为空的
- (BOOL)isNotEmpty;
//延迟调用block
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
@end
