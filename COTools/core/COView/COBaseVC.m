//
//  COBaseVC.m
//  COTools
//
//  Created by carlos on 13-10-15.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseVC.h"

@interface COBaseVC ()

@end

@implementation COBaseVC
#pragma mark 子类继承的方法
//在初始化的时候初始化views
-(void)createViews{
}
//在界面即将显示的时候填充view
-(void)fillViewsOnResume{
}
//在初始化的时候创建数据
- (void)createData{
}
//在界面即将显示的时候填充数据
-(void)fillDataOnResume{
}
//创建事件
-(void)createEven{
}


#pragma mark 弹出框
//显示提示信息
- (void)alertMsg:(NSString *)msg{
    [self alertMsg:msg withEvent:^(){
        CLog(@"点击了确定按钮");
    }];
}
//显示提示信息
- (void)alertMsg:(NSString *)msg withEvent:(BaseOnClickOne )onClickConfrim
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[COAppTool appName]
                                                   message:msg
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                         otherButtonTitles:kWConfrim,nil];
    [alert.rac_buttonClickedSignal subscribeNext:^(NSNumber *x) {
        if (onClickConfrim) {
            onClickConfrim();
        }
    }];
    [alert show];
}
//取消和确定对话框显示提示信息
- (void)alert2BtnMsg:(NSString *)msg withEvent:(BaseOnClickOne )onClickConfrim{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[COAppTool appName]
                                                   message:msg
                                                  delegate:nil
                                         cancelButtonTitle:kWCancel
                                         otherButtonTitles:kWConfrim,nil];
    
    [alert.rac_buttonClickedSignal subscribeNext:^(NSNumber *x) {
        if (onClickConfrim && [x intValue] == 1) {
            onClickConfrim();
        }
    }];
    
    [alert show];
}
@end
