//
//  UILabel+CO.m
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//

#import "UILabel+CO.h"
#import "UIView+CO.h"
#import <objc/runtime.h>
@implementation UILabel (CO)

+ (void)load{
    //定制字体
    [self customLoadFont];
}

static NSString *myCustomFontName;
/**
 *  在load的时候加入
 */
+ (void)customLoadFont{
    SEL originSEL = @selector(setFont:);
    SEL nowSEL = @selector(customSetFont:);
    Method originMethod = class_getInstanceMethod([self class], originSEL);
    IMP originIMP = class_getMethodImplementation([self class], originSEL);
    Method nowMethod = class_getInstanceMethod([self class], nowSEL);
    IMP nowIMP = class_getMethodImplementation([self class], nowSEL);
    method_setImplementation(nowMethod, originIMP);
    method_setImplementation(originMethod, nowIMP);
}
/**
 *  设置自定义的字体名
 *
 *  @param fontName
 */
+ (void)setCustomFontName:(NSString *)fontName{
    myCustomFontName = fontName;
}
/**
 *  子类要继承并且复写这个
 *  @param font
 */
- (void)customSetFont:(UIFont *)oldFont{
    //自定义内容
    if (myCustomFontName && ![@"" isEqual:myCustomFontName]) {
        [self customSetFont:[UIFont fontWithName:myCustomFontName size:oldFont.pointSize]];
    }else{
        [self customSetFont:oldFont];
    }
}


//根据文字内容设置高度
- (void)setAutoHeightWithContent{
    float height = [self sizeWithContent];
    self.height=height;
}

//根据内容和宽度获取高度
-(float )sizeWithContent{
//    return [self.text sizeWithFont:self.font  constrainedToSize:CGSizeMake(self.frame.size.width,100000)  lineBreakMode:NSLineBreakByWordWrapping].height;
    
    NSMutableDictionary *atts = [[NSMutableDictionary alloc] init];
    [atts setObject:self.font forKey:NSFontAttributeName];
    
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width,100000)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:atts
                                       context:nil];
    
    return rect.size.height;
}

@end
