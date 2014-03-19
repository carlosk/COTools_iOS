//
//  COPListTool.h
//  COToolsSample
//
//  Created by carlos on 19/03/2014.
//  Copyright (c) 2014 carlosk. All rights reserved.
//PList文件操作的工具类

#import "COBaseTool.h"

@interface COPListTool : COBaseTool
//根据文件名和
+(id)valueByPListName:(NSString *)pListName withKey:(NSString *)key;
//根据plist文件名 存入数据
+(void )setByFileName:(NSString *)fileName WithKey:(NSString *)key withValue:(id)value;
//在UserDefault里获取
+(id)valueByDefaultWithKey:(NSString *)key;
//在UserDefault里添加
+(void)setByDefaulWithKey:(NSString *)key withValue:(id)value;
@end
