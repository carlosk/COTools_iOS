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
@property(nonatomic,assign)int maxLength;//最大的值
@end

@implementation UITextViewDelegateHandler
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.oldDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
    {
        return [self.oldDelegate textViewShouldBeginEditing:textView];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([self.oldDelegate respondsToSelector:@selector(textViewShouldEndEditing:)])
    {
        return [self.oldDelegate textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.oldDelegate respondsToSelector:@selector(textViewDidBeginEditing:)])
    {
        [self.oldDelegate textViewDidBeginEditing:textView];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.oldDelegate respondsToSelector:@selector(textViewDidEndEditing:)])
    {
        [self.oldDelegate textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (range.location < self.maxLength || self.maxLength == 0) {
        if ([self.oldDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
        {
            return [self.oldDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
        }
        return YES;
    }
    return NO;
}
- (void)textViewDidChange:(UITextView *)textView{
    if ([self.oldDelegate respondsToSelector:@selector(textViewDidChange:)])
    {
        [self.oldDelegate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
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

    UITextViewDelegateHandler *handler = [[UITextViewDelegateHandler alloc]init];
    objc_setAssociatedObject(self, (const void *)(kUITextViewDelegateHandler), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    handler.maxLength = length;
    handler.oldDelegate = self.delegate;
    self.delegate = handler;
    
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

-(int)maxLength{
    UITextViewDelegateHandler *handler = objc_getAssociatedObject(self, (const void *)(kUITextViewDelegateHandler));
    return    handler.maxLength;
}
@end
