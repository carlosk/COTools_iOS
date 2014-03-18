//
//  COBaseDomain.m
//  COTools
//
//  Created by carlos on 13-12-19.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseDomain.h"
#import "COCommTool.h"
#import <objc/runtime.h>
@implementation COBaseDomain
-(id)initWithJson:(NSDictionary *)json{
    self = [super init];
    if (!self) {
        return self;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (![json isKindOfClass:[NSDictionary class]]) {
        return self;
    }
    Class mClass1 = [self class];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(mClass1, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithFormat:@"%s",property_getName(property)];
        id value = [json objectForKey:key];
        //如果value是array类型的，则解析成domain数组
        if ([value isKindOfClass:[NSArray class]] || [[[value class] description] isEqualToString:@"__NSCFArray"]) {
            if ([value count]) {
                if ([value[0] isKindOfClass:[NSDictionary class]] || [[[value[0] class] description] isEqualToString:@"__NSCFDictionary"] ) {
                    NSMutableArray *selfArr = [[NSMutableArray alloc] init];
                    //根据key的名字构造sel，sel必须以[key]ChildClass为名字，且返回class类型
                    SEL classSel = NSSelectorFromString([NSString stringWithFormat:@"%@ChildClass",key]);
                    if ([[self class] respondsToSelector:classSel]) {
                        Class arrClass = [[self class] performSelector:classSel];
                        for (NSDictionary *dicValue in value) {
                            id arrayObj = [[arrClass alloc] initWithJson:dicValue];
                            [selfArr addObject:arrayObj];
                        }
                        if (selfArr.count) {
                            [self setValue:selfArr forKey:key];
                        }
                    }
                }
            }
        }else
            //如果value是dictionary类型的，则解析成domain
            if ([value isKindOfClass:[NSDictionary class]] || [[[value class] description] isEqualToString:@"__NSCFDictionary"]) {
                //根据key的名字构造sel，sel必须以[key]Class为名字，且返回class类型
                SEL classSel = NSSelectorFromString([NSString stringWithFormat:@"%@Class",key]);
                //获取leix
                if ([[self class] respondsToSelector:classSel]) {
                    Class domainClass = [[self class] performSelector:classSel];
                    id domainObj = [[domainClass alloc] initWithJson:value];
                    [self setValue:domainObj forKey:key];
                }
            }else
        if (value) {
            [self setValue:value forKey:key];
        }
    }
    free (properties);
#pragma clang diagnostic pop

    
//    [COCommTool fillself:self withJSONDict:json];
    
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithFormat:@"%s",property_getName(property)];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:[NSString stringWithFormat:@"co_%@",key]];
    }
    free (properties);
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *key1 = [NSString stringWithFormat:@"%s",property_getName(property)];
            NSString *key2 = [NSString stringWithFormat:@"co_%@",key1];
            id value = [aDecoder decodeObjectForKey:key2];
            [self setValue:value forKey:key1];
        }
        free (properties);
    }
    return self;
}


- (NSString *)description{
    NSMutableString *result = [NSMutableString stringWithString:@""];
    //形参
    [result appendFormat:@"%s [",class_getName([self class])];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithFormat:@"%s",property_getName(property)];
        NSString *value = [self valueForKey:key];
        [result appendFormat:@"%@=%@",key,value];
        if (i < outCount -1) {
            [result appendString:@","];
        }
    }
    free (properties);
    [result appendString:@"]"];
    
    return result;
}


@end
