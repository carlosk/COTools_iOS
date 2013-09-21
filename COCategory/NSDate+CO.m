//
//  NSDate+CO.m
//  COCategory
//
//  Created by carlos on 13-9-15.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "NSDate+CO.h"

@implementation NSDate (CO)
//字符串转换成日期
+(NSDate *) converToDate:(NSString *)mDateContent{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:mDateContent];
    return date;
}

//字符串转换成日期
+(NSDate *) converToDate:(NSString *)mDateContent withFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    NSDate *date=[formatter dateFromString:mDateContent];
    return date;
}

//根据日期获取年月日时分秒
- (NSString *) converToString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSDate *date=[formatter dateFromString:mDateContent];
    return [formatter stringFromDate:self];;
}

//根据日期获取年月日时分秒
- (NSString *) converToStringWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    //    NSDate *date=[formatter dateFromString:mDateContent];
    return [formatter stringFromDate:self];;
}
@end
