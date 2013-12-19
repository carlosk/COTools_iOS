//
//  COAppTool.h
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseTool.h"
#define IOS7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )
#define IS_IPHONE                       ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IPAD                         ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)


@interface COAppTool : COBaseTool
//获取应用名
+ (NSString *)appName;
//获取版本号
+ (NSString *)appVersionName;
//获取系统Version
+ (float )osVersion;
//评论url
+ (NSString *)commonUrl:(NSString *)appId;
//appurl
+ (NSString *)appUrl:(NSString *)appId;

//是否越狱
+ (BOOL)isJailBroken;
@end
