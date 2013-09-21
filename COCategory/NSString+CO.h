//
//  NSString+COString.h
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//我在18：02更新了

#import <Foundation/Foundation.h>

@interface NSString (CO)

- (BOOL) contains:(NSString*) str;

- (BOOL) startsWith:(NSString*)prefix;

- (BOOL) equals:(NSString*) anotherString;

- (BOOL) equalsIgnoreCase:(NSString*) anotherString;


- (int) lastIndexOfString:(NSString*)str;

- (int) lastIndexOfString:(NSString*)str fromIndex:(int)index;

- (NSString *) substringFromIndex:(int)beginIndex toIndex:(int)endIndex;

- (NSString *) toLowerCase;

- (NSString *) toUpperCase;

- (NSString *) trim;

- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement;

- (NSArray *) split:(NSString*) separator;

//MD5加密
-(NSString *)md5;

#pragma mark verify
//校验手机号码
-(BOOL) verifyPhone;
//校验身份证
- (BOOL) verifyIdentityCard;
//校验email
- (BOOL) verifyEmail;
//基本的校验方法
- (BOOL) verifyBase:(NSString *)regexStr;
@end
