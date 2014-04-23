//
//  NSString+COString.m
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//

#import "NSString+CO.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (CO)

#define JavaNotFound -1

- (BOOL) contains:(NSString*) str {
    NSRange range = [self rangeOfString:str];
    return (range.location != NSNotFound);
}

- (BOOL) startsWith:(NSString*)prefix {
    return [self hasPrefix:prefix];
}

- (BOOL) equals:(NSString*) anotherString {
    return [self isEqual:anotherString];
}

- (BOOL) equalsIgnoreCase:(NSString*) anotherString {
    return [[self toLowerCase] equals:[anotherString toLowerCase]];
}

- (NSString *) substringFromIndex:(int)beginIndex toIndex:(int)endIndex {
    if (endIndex <= beginIndex) {
        return @"";
    }
    NSRange range = NSMakeRange(beginIndex, endIndex - beginIndex);
    return [self substringWithRange:range];
}

- (NSString *) toLowerCase {
    return [self lowercaseString];
}

- (NSString *) toUpperCase {
    return [self uppercaseString];
}

- (NSString *) trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement {
    return [self stringByReplacingOccurrencesOfString:origin withString:replacement];
}

- (NSArray *) split:(NSString*) separator {
    return [self componentsSeparatedByString:separator];
}
//MD5加密
-(NSString *)md5{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}



#pragma mark verify
//校验手机号码
-(BOOL) verifyPhone{
    return [self verifyBase:@"^(((15[012356789]{1})|(18[02356789]{1})|(13[0-9]{1})|(14[57]{1}))+[0-9]{8})$"];
}

//校验身份证
- (BOOL) verifyIdentityCard{
    NSString *regexStr = @"\\d{15}|\\d{18}";
    return [self verifyBase:regexStr];
}
//校验email
- (BOOL) verifyEmail{

    return [self verifyBase:@"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"];
}
//基本的校验方法
- (BOOL) verifyBase:(NSString *)regexStr{
    if (!regexStr) {
        return NO;
    }
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr
                                                                          options:NSRegularExpressionCaseInsensitive    // 还可以加一些选项，例如：不区分大小写
                                                                            error:&error];
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:self
                                      options:0
                                        range:NSMakeRange(0, [self length])];
    
    return matches.count>0;

}


//字符串是否为空
+(BOOL)isStringEmpty:(NSString *)string{
    
    return !string || [@"" isEqual:string];
}
//字符串是否不为空
+(BOOL)isStringNotEmpty:(NSString *)string{
    return string && ![@"" isEqual:string];
}
@end
