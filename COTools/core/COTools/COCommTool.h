//
//  COCommTool.h
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseTool.h"
//单例
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

@interface COCommTool : COBaseTool
/**
 *  json字典填充一个Object对象
 *
 *  @param object 一般传入的为self
 *  @param json   json的字典
 */
+ (void)fillObject:(id )object withJSONDict:(NSDictionary *)json;

//根据key存入value
+(void)saveValue:(id)value byKey:(NSString *)key;
//根据key获取value
+(id )valueByKey:(NSString *)key;
@end
