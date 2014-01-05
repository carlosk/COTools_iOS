//
//  UIScrollView+CO.m
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//

#import "UIScrollView+CO.h"

@implementation UIScrollView (CO)
//设置scrollview的总高度，根据最后的view的y 和底部的距离
- (void)coSetContentSizeWithLastView:(UIView *)lastView withBottomH:(float)h{
    CGSize size = CGSizeMake(self.frame.size.width, lastView.frame.origin.y + lastView.frame.size.height + h);
    self.contentSize = size;
}
@end
