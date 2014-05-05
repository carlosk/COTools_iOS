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

/*属性名key 获取的是新的key.这是用来json的key跟字段名不一样的情况
 *属性名ChildClass 指的是是如果该属性是数组的话则用这个方法获取每个元素的class
 *属性名Class 指的是该属性如果是自定义对象的话,通过这个方法获取这个元素的class
 *如果数组里的内容是number,则不需要解析
 */
-(id)initWithJson:(NSDictionary *)json{
    self = [super init];
    if (!self) {
        return self;
    }

    if (![json isKindOfClass:[NSDictionary class]]) {
        return self;
    }
    Class mClass1 = [self class];
    [self parseWithClass:mClass1 withJsonContent:json];

    
    return self;
}

- (void)parseWithClass:(Class )mClass1 withJsonContent:(NSDictionary *)json{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(mClass1, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithFormat:@"%s",property_getName(property)];
        id value = [json objectForKey:key];
        //如果不存在,则查看是否有新的key
        if (!value) {
            SEL newKeySEL = NSSelectorFromString([NSString stringWithFormat:@"%@Key",key]);
            if ([[self class] respondsToSelector:newKeySEL]) {
                NSString *newKey = [[self class] performSelector:newKeySEL];
                value = [json objectForKey:newKey];
            }
        }
        
        //如果value是array类型的，则解析成domain数组
        if ([value isKindOfClass:[NSArray class]] || [[[value class] description] isEqualToString:@"__NSCFArray"]) {
            if ([value count]) {
                NSLog(@"%@",[value[0] class]);
                if ([value[0] isKindOfClass:[NSDictionary class]] || [[[value[0] class] description] isEqualToString:@"__NSCFDictionary"] || [[[value[0] class] description] isEqualToString:@"__NSCFNumber"] ) {
                    NSMutableArray *selfArr = [[NSMutableArray alloc] init];
                    //根据key的名字构造sel，sel必须以[key]ChildClass为名字，且返回class类型
                    SEL classSel = NSSelectorFromString([NSString stringWithFormat:@"%@ChildClass",key]);
                                        //如果是Number类型的话
                    Class eachClass = nil;
                    if ([[self class] respondsToSelector:classSel]) {
                        eachClass = [[self class] performSelector:classSel];
                    }
                    for (NSDictionary *dicValue in value) {
                        if ([dicValue isKindOfClass:[NSNumber class]]) {
                            [selfArr addObject:dicValue];
                        }else if (eachClass){
                            id eachObject = [[eachClass alloc] initWithJson:dicValue];
                            [selfArr addObject:eachObject];
                        }else{
                            
                        }
                        
                    }
                    if (selfArr.count) {
                        [self setValue:selfArr forKey:key];
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
            }else{
                if (value) {
                    //如果有查找value的方法,则查找
                    SEL valueSel = NSSelectorFromString([NSString stringWithFormat:@"%@Value:",key]);
                    if ([[self class] respondsToSelector:valueSel]) {
                        id newValue = [[self class] performSelector:valueSel withObject:value];
                        if (newValue) {
                            value = newValue;
                        }
                    }
                    [self setValue:value forKey:key];
                }
            
            }
    }
    free (properties);

    if ([mClass1 superclass]) {
        [self parseWithClass:[mClass1 superclass] withJsonContent:json];
    }
#pragma clang diagnostic pop
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
