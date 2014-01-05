//
//  COBaseVC.h
//  COTools
//
//  Created by carlos on 13-10-15.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//这是最基本的VC

#import <UIKit/UIKit.h>
#import "COTools.h"
@interface COBaseVC : UIViewController
#pragma mark 子类继承的方法
//在初始化的时候初始化views
-(void)createViews;
//在界面即将显示的时候填充view
-(void)fillViewsOnResume;
//在初始化的时候创建数据
- (void)createData;
//在界面即将显示的时候填充数据
-(void)fillDataOnResume;
//创建事件
-(void)createEven;


#pragma mark 弹出框
//显示提示信息
- (void)alertMsg:(NSString *)msg;
//显示提示信息
- (void)alertMsg:(NSString *)msg withEvent:(BaseOnClickOne )onClickConfrim;

//取消和确定对话框显示提示信息
- (void)alert2BtnMsg:(NSString *)msg withEvent:(BaseOnClickOne )onClickConfrim;
@end
