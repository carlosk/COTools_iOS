//
//  UILabel+CO.m
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//

#import "UILabel+CO.h"
#import "UIView+CO.h"
@implementation UILabel (CO)
//根据文字内容设置高度
- (void)setAutoHeightWithContent{
    float height = [self sizeWithContent];
    [self setH:height];
}

//根据内容和宽度获取高度
-(float )sizeWithContent{
    
    return [self.text sizeWithFont:self.font  constrainedToSize:CGSizeMake(self.frame.size.width,100000)  lineBreakMode:NSLineBreakByWordWrapping].height;
    
//    NSMutableDictionary *atts = [[NSMutableDictionary alloc] init];
//    [atts setObject:self.font forKey:NSFontAttributeName];
//    
//    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width,100000)
//                                       options:NSStringDrawingUsesLineFragmentOrigin
//                                    attributes:atts
//                                       context:nil];
//    
//    return rect.size.height;
}

@end
