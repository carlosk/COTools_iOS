//
//  COKeyChainHandler.h
//  IAPTest
//
//  Created by carlos on 13-7-3.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COKeyChainTool : NSObject
//根据key获取一个数据
+(NSString *)valueByKey:(NSString *)key;
//添加或更新一个数据
+(void)putValue:(NSString *) value key:(NSString *)key;
//删除一个数据
+(void)deleteByKey:(NSString *)key;

/**
 *  获取uuid
 *
 *  @return 返回的是uuid的字符串
 */
+ (NSString *)uuid;
@end
