//
//  COKeyChainHandler.m
//  IAPTest
//
//  Created by carlos on 13-7-3.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COKeyChainHandler.h"
#import <Security/Security.h>
@implementation COKeyChainHandler
//根据key获取一个数据
+(NSString *)valueByKey:(NSString *)key{
    NSString* ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:key];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr)
    {
        @try
        {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)keyData];
        }
        @catch (NSException *e)
        {
            NSLog(@"Unarchive of %@ failed: %@", key, e);
        }
        @finally
        {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;

}
//添加或更新一个数据
+(void)putValue:(NSString *) value key:(NSString *)key{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)key {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            key, (id)kSecAttrService,
            key, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}
//删除一个数据
+(void)deleteByKey:(NSString *)key{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

@end
