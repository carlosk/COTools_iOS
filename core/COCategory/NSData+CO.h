//
//  NSData+CO.h
//  COCategory
//
//  Created by carlos on 13-9-19.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CO)
//转换成中文GBK编码
- (NSString *) converGBKString;
//转换成UTF8的字符串
- (NSString *) converUTF8String;
@end
