//
//  CODefineTool.h
//  COTools
//
//  Created by carlos on 13-12-19.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//一些define的工具

#import "COBaseTool.h"
//导航栏的高度
#define kFBaseNavHeight 44
//状态栏的高度
#define kFBaseStatusHeight 20

//tabbar的高度
#define kFTabbarHeight 49

//界面的宽
#define kFBaseWidth [[UIScreen mainScreen]bounds].size.width
//界面的高
#define kFBaseHeight [[UIScreen mainScreen]bounds].size.height
//没有状态条的高度
#define kFBaseHeightNoStatus (kFBaseHeight-kFBaseStatusHeight)
//没有状态条和导航栏的高度
#define kFBaseHeightNoStatusNoNav (kFBaseHeight-kFBaseStatusHeight - kFBaseNavHeight)

#pragma mark 一些方法的简化

#define kFRect(x,y,w,h) CGRectMake(x, y, w, h)
#define kFRect2(viweName,x,y,w,h) CGRect viweName = kFRect(x, y, w, h);

#define kFInit(varName,className,x,y,w,h) className *varName = [[className alloc]initWithFrame:CGRectMake(x, y, w, h)];
#define kInit(varName,className) className *varName = [[className alloc]init];

//键盘的高度
#define kFKeyboardiPhonePortrait 264
#define kFKeyboardiPhoneLandscape 352
#define kFKeyboardiPadPortrait 216
#define kFKeyboardiPadLandscape 140


#define kUIsIphone5 kFBaseHeight == 568


#pragma mark 默认的文字信息

#define kWCancel @"取消"
#define kWBack @"返回"
#define kWConfrim @"确定"


#define NotifyRemove(o) [[NSNotificationCenter defaultCenter] removeObserver:o];
#define NotifyAdd(notifyName,function)         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(function) name:notifyName object:nil];

#define NotifyPost(nofityName,mObject)         [[NSNotificationCenter defaultCenter] postNotificationName:nofityName object:mObject];

@interface CODefineTool : COBaseTool

@end
