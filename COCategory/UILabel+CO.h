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
-(float )sizeWithContent;
@end
