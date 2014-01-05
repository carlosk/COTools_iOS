//
//  COBaseView.h
//  COTools
//
//  Created by carlos on 13-10-15.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//外部的自定义View继承这个

#import <UIKit/UIKit.h>

@interface COBaseV : UIView
#pragma mark View初始化
-(void)createViews;


#pragma mark 数据
- (void)createData;

//点击事件
-(IBAction)onClickWithXib:(UIView *)sender;
//点击了某个按钮,返回值为YES则说明不由BaseVC继续下发处理
-(BOOL )onClick:(UIView *)sender;

//用静态创建
+(id )createVWithXib;
@end
