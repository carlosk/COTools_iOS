//
//  NSData+CO.m
//  COCategory
//
//  Created by carlos on 13-9-19.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "NSData+CO.h"

@implementation NSData (CO)
//转换成中文GBK编码
- (NSString *) converGBKString{
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding ( kCFStringEncodingGB_18030_2000 );
    NSString *content = [[ NSString alloc ] initWithData :self encoding :gbkEncoding];
    return content;
}
//转换成UTF8的字符串
- (NSString *) converUTF8String{
    NSString* content = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    return content;
}
@end
