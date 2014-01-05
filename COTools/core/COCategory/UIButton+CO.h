//
//  UIButton+CO.h
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CO)
//添加按键事件
-(void)coAddOnClickEven:(SEL )selector withTarget:(id)target;
- (void)setTitle:(NSString  *)title;

- (void)setBgImage:(UIImage *)image;
- (void)setBgNormalImage:(UIImage *)image withPressImage:(UIImage *)image1;
- (void)setImage:(UIImage  *)image;
- (void)setNormalImage:(UIImage *)image withPressImage:(UIImage *)image1;
@end
