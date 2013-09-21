//
//  UIColor+CO.m
//  COCategory
//
//  Created by carlos on 13-9-10.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "UIColor+CO.h"

@implementation UIColor (CO)
//颜色转换成Image
- (UIImage *)transformImage
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
//16进制转换成UIColor
+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
    return [UIColor colorWithRGBHex:hex alpha:1.0f];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:alpha];
}


@end
