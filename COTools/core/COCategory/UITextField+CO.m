//
//  UITextField+CO.m
//  COTools
//
//  Created by carlos on 14-1-5.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import "UITextField+CO.h"
#import "UIControl+CO.h"
#import <objc/runtime.h>

@interface UITextFiledDelegateHandler : NSObject <UITextFieldDelegate>
@property(nonatomic,assign) id<UITextFieldDelegate> oldDelegate;
@property(nonatomic,copy) BOOL(^checkBlock)(NSString  *strNew,NSString *strOld);
@property(nonatomic,copy)id(^actionTypeBlock)(UITextField *textF,UITextFieldActionType type);
@end

@implementation UITextFiledDelegateHandler

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.actionTypeBlock) {
        return [self.actionTypeBlock(textField,TextFieldShouldBeginEditingType) boolValue];
    }
    if ([self.oldDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
    {
        return [self.oldDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (self.actionTypeBlock) {
        self.actionTypeBlock(textField,TextFieldDidBeginEditingType);
        return;
    }
    if ([self.oldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
    {
        [self.oldDelegate textFieldDidBeginEditing:textField];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (self.actionTypeBlock) {
        return [self.actionTypeBlock(textField,TextFieldShouldEndEditingType) boolValue];
    }
    
    if ([self.oldDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
    {
        return [self.oldDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.actionTypeBlock) {
        [self.actionTypeBlock(textField,TextFieldDidEndEditingType) boolValue];
        return ;
    }
    if ([self.oldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
    {
        [self.oldDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //如果检查的block,则使用这个block
    if (self.checkBlock) {
        NSString *strNew = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *strOld = textField.text;
        if (self.checkBlock(strNew,strOld)) {
            if ([self.oldDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
            {
                return [self.oldDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
            }
        }else{
            return NO;
        }
    }
    
    if ([self.oldDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
    {
        return [self.oldDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
     return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    if (self.actionTypeBlock) {
        return [self.actionTypeBlock(textField,TextFieldShouldClearType) boolValue];
    }
    
    if ([self.oldDelegate respondsToSelector:@selector(textFieldShouldClear:)])
    {
        return [self.oldDelegate textFieldShouldClear:textField];
    }
     return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.actionTypeBlock) {
        return [self.actionTypeBlock(textField,TextFieldShouldReturnType) boolValue];
    }
    if ([self.oldDelegate respondsToSelector:@selector(textFieldShouldReturn:)])
    {
        return [self.oldDelegate textFieldShouldReturn:textField];
    }
     return YES;
}

@end

@implementation UITextField (CO)
#define kLimitTextLengthKey @"kLimitTextLengthKey"
- (void)setMaxLength:(int)length
{
    [self setCheckEditContentBlock:^BOOL(NSString *strNew, NSString *strOld) {
        return strNew.length <=length;
    }];
}
//设置检查输入内容的block
- (void)setCheckEditContentBlock:(BOOL(^)(NSString  *strNew,NSString *strOld))checkBlock{
    UITextFiledDelegateHandler *handler = objc_getAssociatedObject(self, (const void *)(kLimitTextLengthKey));
    if (!handler) {
        handler = [[UITextFiledDelegateHandler alloc]init];
        objc_setAssociatedObject(self, (const void *)(kLimitTextLengthKey), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    handler.checkBlock = checkBlock;
    if (handler != self.delegate) {
        handler.oldDelegate = self.delegate;
    }
    self.delegate = handler;
}

//设置textField的动作的block监听
- (void)setActionTypeBlock:(id(^)(UITextField *textF,UITextFieldActionType type))actionTypeBlock{
    UITextFiledDelegateHandler *handler = objc_getAssociatedObject(self, (const void *)(kLimitTextLengthKey));
    if (!handler) {
        handler = [[UITextFiledDelegateHandler alloc]init];
        objc_setAssociatedObject(self, (const void *)(kLimitTextLengthKey), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    handler.actionTypeBlock = actionTypeBlock;
    if (handler != self.delegate) {
        handler.oldDelegate = self.delegate;
    }
    self.delegate = handler;
}
@end
