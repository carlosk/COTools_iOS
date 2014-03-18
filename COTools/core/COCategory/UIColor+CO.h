//
//  UIColor+CO.h
//  COCategory
//
//  Created by carlos on 13-9-10.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CO)
//颜色转换成Image
- (UIImage *)transformImage;

//16进制转换成UIColor
+ (UIColor *)colorWithRGBHex:(UInt32)hex;

+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha;

//根据字符串创建Color,比如d16c11
+(UIColor *)createColorWithString:(NSString *)colorStr;
@end
