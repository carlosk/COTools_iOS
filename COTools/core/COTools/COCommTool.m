//
//  COCommTool.m
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COCommTool.h"
#import <objc/runtime.h>
#import "COLogTool.h"
#import "COUtils.h"
@implementation COCommTool

//根据key存入value
+(void)saveValue:(id)value byKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//根据key获取value
+(id )valueByKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

#pragma mark keyborad
static UIScrollView * scrollView;
static NSArray * inputViews;
static CGSize kbSize;//这是键盘的显示出来的size
+ (void)registerForKeyboardNotificationsWithScrollView:(UIScrollView *)scrllView withInputViews:(NSArray *)inputViews1
{
    scrollView = scrllView;
    inputViews = inputViews1;
    
    for (UIView *eachView in inputViews) {
        if ([eachView isKindOfClass:[UITextView class]]) {
            UITextView *textV = ((UITextView *)eachView);
            [textV setActionTypeBlock:^id(UITextView *textF, UITextViewActionType type) {
                 if (type == TextViewShouldBeginEditingType && kbSize.width>0&& kbSize.height > 0) {
                     CGPoint scrollPoint = CGPointMake(0.0, kbSize.height-(scrollView.frame.size.height - textF.frame.origin.y - textF.frame.size.height) + 10);
                     [scrollView setContentOffset:scrollPoint animated:YES];
                 }
                return @(YES);
            }];
        }else if ([eachView isKindOfClass:[UITextField class]]){
            UITextField *textF = ((UITextField *)eachView);
                [textF setActionTypeBlock:^id(UITextField *textField,UITextFieldActionType type) {
                    if (type == TextFieldDidBeginEditingType && kbSize.width>0&& kbSize.height > 0) {
                        CGPoint scrollPoint = CGPointMake(0.0, kbSize.height-(scrollView.frame.size.height - textField.frame.origin.y - textField.frame.size.height) + 10);
                        [scrollView setContentOffset:scrollPoint animated:YES];
                    }
                    return @(YES);
                }];
        }
    }

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

+ (void)keyboardWillShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];

    CGSize kbSize1 = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    kbSize  = kbSize1;
    UIView *focusView = nil;
    for (UIView *eachView in inputViews) {
        if ([eachView isKindOfClass:[UITextView class]]) {
            if (((UITextView *)eachView).isFirstResponder) {
                focusView = eachView;
            }
        }else if ([eachView isKindOfClass:[UITextField class]]){
            if (((UITextField *)eachView).isFirstResponder) {
                focusView = eachView;
            }
        }
    }
    CGPoint scrollPoint = CGPointMake(0.0, kbSize.height-(scrollView.frame.size.height - focusView.frame.origin.y - focusView.frame.size.height) + 10);
    
    if (scrollPoint.y >0) {
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}
//在键盘消失的通知处理事件中，简单的将UIScrollView恢复即可
+ (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    kbSize  = CGSizeMake(0, 0);
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}


@end
