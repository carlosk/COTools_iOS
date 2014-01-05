//
//  UITextView+CO.h
//  COTools
//
//  Created by carlos on 14-1-5.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum  _UITextViewActionType{
    TextViewShouldBeginEditingType = 1,
    TextViewShouldEndEditingType,
    TextViewDidBeginEditingType,
    TextViewDidEndEditingType,
    TextViewDidChangeType,
    TextViewDidChangeSelectionType
    
}UITextViewActionType;

@interface UITextView (CO)
- (void)setMaxLength:(int)length;
//设置检查输入内容的block
- (void)setCheckEditContentBlock:(BOOL(^)(NSString  *strNew,NSString *strOld))checkBlock;

//设置textView的动作的block监听
- (void)setActionTypeBlock:(id(^)(UITextView *textF,UITextViewActionType type))actionTypeBlock;
@end

