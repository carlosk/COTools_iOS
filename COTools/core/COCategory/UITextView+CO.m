//
//  UITextView+CO.m
//  COTools
//
//  Created by carlos on 14-1-5.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import "UITextView+CO.h"
#import <objc/runtime.h>



@interface UITextViewDelegateHandler : NSObject <UITextViewDelegate>
@property(nonatomic,assign) id<UITextViewDelegate> oldDelegate;
@property(nonatomic,copy) BOOL(^checkBlock)(NSString  *strNew,NSString *strOld);
@property(nonatomic,copy)id(^actionTypeBlock)(UITextView *textF,UITextViewActionType type);
@end

@implementation UITextViewDelegateHandler
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if (self.actionTypeBlock) {
        return [self.actionTypeBlock(textView,TextViewShouldBeginEditingType) boolValue];
    }
    if ([self.oldDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
    {
        return [self.oldDelegate textViewShouldBeginEditing:textView];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    if (self.actionTypeBlock) {
        return [self.actionTypeBlock(textView,TextViewShouldEndEditingType) boolValue];
    }
    
    if ([self.oldDelegate respondsToSelector:@selector(textViewShouldEndEditing:)])
    {
        return [self.oldDelegate textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if (self.actionTypeBlock) {
        self.actionTypeBlock(textView,TextViewDidBeginEditingType);
        return;
    }
    
    if ([self.oldDelegate respondsToSelector:@selector(textViewDidBeginEditing:)])
    {
        [self.oldDelegate textViewDidBeginEditing:textView];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (self.actionTypeBlock) {
        self.actionTypeBlock(textView,TextViewDidEndEditingType);
        return;
    }
    
    if ([self.oldDelegate respondsToSelector:@selector(textViewDidEndEditing:)])
    {
        [self.oldDelegate textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   
    //如果检查的block,则使用这个block
    if (self.checkBlock) {
        NSString *strNew = [textView.text stringByReplacingCharactersInRange:range withString:text];
        NSString *strOld = textView.text;
        if (self.checkBlock(strNew,strOld)) {
            if ([self.oldDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
            {
                return [self.oldDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
            }
        }else{
            return NO;
        }
    }

    if ([self.oldDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
    {
        return [self.oldDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if (self.actionTypeBlock) {
        self.actionTypeBlock(textView,TextViewDidChangeType);
        return;
    }
    
    if ([self.oldDelegate respondsToSelector:@selector(textViewDidChange:)])
    {
        [self.oldDelegate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    if (self.actionTypeBlock) {
        self.actionTypeBlock(textView,TextViewDidChangeSelectionType);
        return;
    }
    
    if ([self.oldDelegate respondsToSelector:@selector(textViewDidChangeSelection:)])
    {
        [self.oldDelegate textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0){
    
    if ([self.oldDelegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)])
    {
        return [self.oldDelegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0){
    if ([self.oldDelegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)])
    {
        return [self.oldDelegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}
@end

@implementation UITextView (CO)
#define kUITextViewDelegateHandler @"kUITextViewDelegateHandler"
- (void)setMaxLength:(int)length
{

    [self setCheckEditContentBlock:^BOOL(NSString *strNew, NSString *strOld) {
        return strNew.length <=length;
    }];
    
}

//设置检查输入内容的block
- (void)setCheckEditContentBlock:(BOOL(^)(NSString  *strNew,NSString *strOld))checkBlock{
        UITextViewDelegateHandler *handler = objc_getAssociatedObject(self, (const void *)(kUITextViewDelegateHandler));
    if (!handler) {
        handler = [[UITextViewDelegateHandler alloc]init];
        objc_setAssociatedObject(self, (const void *)(kUITextViewDelegateHandler), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    handler.checkBlock = checkBlock;
    if (handler != self.delegate) {
        handler.oldDelegate = self.delegate;
    }
    self.delegate = handler;
}
//设置textView的动作的block监听
- (void)setActionTypeBlock:(id(^)(UITextView *textF,UITextViewActionType type))actionTypeBlock{
    
    UITextViewDelegateHandler *handler = objc_getAssociatedObject(self, (const void *)(kUITextViewDelegateHandler));
    if (!handler) {
        handler = [[UITextViewDelegateHandler alloc]init];
        objc_setAssociatedObject(self, (const void *)(kUITextViewDelegateHandler), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (handler != self.delegate) {
        handler.oldDelegate = self.delegate;
    }
    self.delegate = handler;
    handler.actionTypeBlock = actionTypeBlock;
}
//- (void)setDelegate:(id<UITextViewDelegate>)delegate{
//   UITextViewDelegateHandler *handler = objc_getAssociatedObject(self, (const void *)(kUITextViewDelegateHandler));
//    if (handler) {
//        if (![delegate isKindOfClass:[UITextViewDelegateHandler class]]) {
//            handler.oldDelegate = self.delegate;
//        }
//        _delegate = handler;
//    }
//}
@end
