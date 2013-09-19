//
//  COAppTool.h
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseTool.h"

@interface COAppTool : COBaseTool
//获取应用名
+ (NSString *)appName;
//获取版本号
+ (NSString *)appVersionName;
//获取系统Version
+ (float )mSystemVersion;
//评论url
+ (NSString *)commonUrl:(NSString *)appId;
//appurl
+ (NSString *)appUrl:(NSString *)appId;

@end
