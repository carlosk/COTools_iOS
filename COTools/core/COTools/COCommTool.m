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
/**
 *  json字典填充一个Object对象
 *
 *  @param object 一般传入的为self
 *  @param json   json的字典
 */
+ (void)fillObject:(id )object withJSONDict:(NSDictionary *)json{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (!object || ![json isKindOfClass:[NSDictionary class]]) {
        return;
    }
    Class mClass1 = [object class];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(mClass1, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithFormat:@"%s",property_getName(property)];
        id value = [json objectForKey:key];
        //如果value是array类型的，则解析成domain数组
        if ([value isKindOfClass:[NSArray class]] || [[[value class] description] isEqualToString:@"__NSCFArray"]) {
            if ([value count]) {
                if ([value[0] isKindOfClass:[NSDictionary class]] || [[[value[0] class] description] isEqualToString:@"__NSCFDictionary"] ) {
                    NSMutableArray *objectArr = [[NSMutableArray alloc] init];
                    //根据key的名字构造sel，sel必须以[key]ChildClass为名字，且返回class类型
                    SEL classSel = NSSelectorFromString([NSString stringWithFormat:@"%@ChildClass",key]);
                    if ([[object class] respondsToSelector:classSel]) {
                        Class arrClass = [[object class] performSelector:classSel];
                        for (NSDictionary *dicValue in value) {
                            id arrayObj = [[arrClass alloc] init];
                            [COCommTool fillObject:arrayObj withJSONDict:dicValue];
                            [objectArr addObject:arrayObj];
                        }
                        if (objectArr.count) {
                            [object setValue:objectArr forKey:key];
                        }
                    }
                }
            }
        }else
            //如果value是dictionary类型的，则解析成domain
            if ([value isKindOfClass:[NSDictionary class]] || [[[value class] description] isEqualToString:@"__NSCFDictionary"]) {
                //根据key的名字构造sel，sel必须以[key]Class为名字，且返回class类型
                SEL classSel = NSSelectorFromString([NSString stringWithFormat:@"%@Class",key]);
                if ([[object class] respondsToSelector:classSel]) {
                    Class domainClass = [[object class] performSelector:classSel];
                    id domainObj = [[domainClass alloc] init];
                    [COCommTool fillObject:domainObj withJSONDict:value];
                    [object setValue:domainObj forKey:key];
                }
            }else
        if (value) {
            [object setValue:value forKey:key];
        }
    }
    free (properties);
#pragma clang diagnostic pop
}

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
