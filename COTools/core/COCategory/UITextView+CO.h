//
//  UITextView+CO.h
//  COTools
//
//  Created by carlos on 14-1-5.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (CO)
- (void)setMaxLength:(int)length;
//设置检查输入内容的block
- (void)setCheckEditContentBlock:(BOOL(^)(NSString  *strNew,NSString *strOld))checkBlock;
@end

