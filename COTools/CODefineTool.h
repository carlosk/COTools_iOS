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
//界面的宽
#define kFBaseWidth [[UIScreen mainScreen]bounds].size.width
//界面的高
#define kFBaseHeight [[UIScreen mainScreen]bounds].size.height
//没有状态条的高度
#define kFBaseHeightNoStatus (kFBaseHeight-kFBaseStatusHeight)
//没有状态条和导航栏的高度
#define kFBaseHeightNoStatusNoNav (kFBaseHeight-kFBaseStatusHeight - kFBaseNavHeight)
#define kFInit(varName,className,x,y,w,h) className *varName = [[className alloc]initWithFrame:CGRectMake(x, y, w, h)];
#define kInit(varName,className) className *varName = [[className alloc]init];

#define kUIsIphone5 kFBaseHeight == 568

@interface CODefineTool : COBaseTool

@end
