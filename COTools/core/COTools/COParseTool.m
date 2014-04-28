//
//  COParseTool.m
//  COToolsSample
//
//  Created by carlos on 14-1-5.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import "COParseTool.h"
#import "COBaseDomain.h"
#import "COLogTool.h"
#import "NSData+CO.h"
@implementation COParseTool
+(NSArray *)parserData:(NSString *)jsonContent withClass:(Class)mClass withKey:(NSString *)key
{
    NSDictionary *json = [self jsonContentParseDict:jsonContent];
    if (json == nil) {
        CLog(@"json parse failed \r\n");
        return nil;
    }
    
    NSArray *arr = [json objectForKey:key];
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *eachItem in arr) {
        //        DLog(@"%@",eachItem);
        COBaseDomain *domain = [[mClass alloc]initWithJson:eachItem];
        [result addObject:domain];
    }
    
    return result;
}

//根据json字符串解析成对象
+(id)parser:(NSString *)jsonContent withClass:(Class)mClass withKey:(NSString *)key{
    
    NSDictionary *json = [self jsonContentParseDict:jsonContent];
    if (json == nil) {
        CLog(@"json parse failed \r\n");
        return nil;
    }
    
    if (key) {
        json = [json objectForKey:key];
    }
    COBaseDomain *domain = [[mClass alloc]initWithJson:json];
    return domain;
}

//通过key查找value
+(id )parseValueWith:(NSString *)jsonContent withKey:(NSString *)key{
    NSDictionary *json = [self jsonContentParseDict:jsonContent];
    if (json == nil) {
        CLog(@"json parse failed \r\n");
        return nil;
    }
    return [json objectForKey:key];
    
}
//字符串转换成字段
+ (NSDictionary *)jsonContentParseDict:(NSString *)jsonContent{
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    return json;
}
//字典转换成json data
+(NSData*)dictParseJsonData:(NSDictionary *)dict{
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (error != nil) {
        NSLog(@"NSArray JSONString error: %@", [error localizedDescription]);
        return nil;
    } else {
        return jsonData;
    }
}

//字典转换成json字符串
+(NSString *)dictParseJsonContent:(NSDictionary *)dict{
    NSData *data = [self dictParseJsonData:dict];
    if (data) {
        return [data converUTF8String];
    }
    return nil;
}
@end
