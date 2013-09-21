//
//  UIButton+CO.m
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//

#import "UIButton+CO.h"

@implementation UIButton (CO)

//添加按键事件
-(void)coAddOnClickEven:(SEL )selector withTarget:(id)target{
    [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

@end
