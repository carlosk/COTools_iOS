//
//  NSDate+CO.h
//  COCategory
//
//  Created by carlos on 13-9-15.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//时间管理

#import <Foundation/Foundation.h>

@interface NSDate (CO)
//字符串转换成日期
+(NSDate *) converToDate:(NSString *)mDateContent;
//字符串转换成日期
+(NSDate *) converToDate:(NSString *)mDateContent withFormat:(NSString *)format;

//根据日期获取年月日时分秒
- (NSString *) converToString;
//根据日期获取年月日时分秒
- (NSString *) converToStringWithFormat:(NSString *)format;
@end
