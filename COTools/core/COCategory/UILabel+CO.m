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

//+ (void)load{
//    //定制字体
//    [self customLoadFont];
//}

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
    UIFont *currentFont = oldFont;
    if (myCustomFontName && ![@"" isEqual:myCustomFontName]) {
        currentFont = [UIFont fontWithName:myCustomFontName size:oldFont.pointSize];
    }
    //用Invork来做
    SEL targetSEL = @selector(customSetFont:);
    //获得类和方法的签名
    NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:targetSEL];
    //从签名获得调用对象
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTarget:self];
    [invocation setSelector:targetSEL];
    //形参,从2开始,0是self本身,1是_cmd
    [invocation setArgument:&currentFont atIndex:2];
    [invocation retainArguments];
    [invocation invoke];
    //得到返回值，此时不会再调用，只是返回值
//    [invocation getReturnValue:&returnValue];
    
//    [self customSetFont:currentFont];
}


//根据文字内容设置高度
- (void)setAutoHeightWithContent{
    float height = [UILabel sizeWithContent:self.text withFont:self.font withWidth:self.width];
    self.height=height;
}

//根据内容和宽度获取高度
+ (float )sizeWithContent:(NSString *)content withFont:(UIFont *)font withWidth:(float )width{
    NSMutableDictionary *atts = [[NSMutableDictionary alloc] init];
    [atts setObject:font forKey:NSFontAttributeName];
    CGFloat height = 0;
    if (IOS7_OR_LATER) {
        CGRect rect = [content boundingRectWithSize:CGSizeMake(width,100000)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:atts
                                            context:nil];
        height = rect.size.height;
    } else {
        CGSize theSize = [content sizeWithFont:font constrainedToSize:CGSizeMake(width,100000)];
        height = theSize.height;
    }
    //    CGRect rect = [content boundingRectWithSize:CGSizeMake(width,100000)
    //                                          options:NSStringDrawingUsesLineFragmentOrigin
    //                                       attributes:atts
    //                                          context:nil];
    return height;
}

@end
