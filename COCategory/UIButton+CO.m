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
- (void)setTitle:(NSString  *)title{
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setBgImage:(UIImage *)image{
    [self setBackgroundImage:image forState:UIControlStateNormal];
}
- (void)setBgNormalImage:(UIImage *)image withPressImage:(UIImage *)image1{
    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:image1 forState:UIControlStateHighlighted];
}
- (void)setImage:(UIImage  *)image{
    [self setImage:image forState:UIControlStateNormal];
}
- (void)setNormalImage:(UIImage *)image withPressImage:(UIImage *)image1{
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:image1 forState:UIControlStateHighlighted];
}
@end
