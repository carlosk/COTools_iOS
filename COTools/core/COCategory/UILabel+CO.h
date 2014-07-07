//
//  UILabel+CO.h
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CO)
//根据文字内容设置高度
- (void)setAutoHeightWithContent;

//根据内容和宽度获取高度
+ (float )sizeWithContent:(NSString *)content withFont:(UIFont *)font withWidth:(float )width;

/**
 *  设置自定义的字体名
 *
 *  @param fontName
 */
+ (void)setCustomFontName:(NSString *)fontName;

@end
