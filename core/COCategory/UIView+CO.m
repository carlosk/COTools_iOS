//
//  UIView+CO.m
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//

#import "UIView+CO.h"
#import <objc/runtime.h>

@implementation UIView (CO)
//view转换成图片
- (UIImage*)convertViewToImage{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
//根据Xib文件创建View
+(id) createWithXib:(NSString *)xibName;
{
    if (!xibName) {
        id temp = [[[self class] alloc]init];
        return temp;
    }else{
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
        return [nibView objectAtIndex:0];
    }
}

//根据Xib文件创建View
+(id) createWithXib{
    NSString *className =NSStringFromClass([self class]);
    return [self createWithXib:className];
}

//把所有的子View加在父View里
-(void) addSubVs:(UIView *)object, ...
{
    va_list argp = NULL;
    va_start(argp, object);
    UIView *tempObject = nil;
    tempObject = object;
    while(tempObject != nil){
        [self addSubview:tempObject];
        tempObject = va_arg(argp, UIView *);
    }
    va_end(argp);
}

//给view添加按键事件
-(void) addTagEven:(SEL) mSel withTarget:(id)target{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:mSel];
    [self addGestureRecognizer:singleTap];
}


//给view添加按键事件

//-(void)showWithCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

static char addTagEvenBlockKey;
//添加view的tag事件到block上
-(void) addTagEvenBlock:(void (^)(UIView *sender))block{
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:mSel];
//    [self addGestureRecognizer:singleTap];
    
    objc_setAssociatedObject(self, &addTagEvenBlockKey, block, OBJC_ASSOCIATION_COPY);
    [self addTagEven:@selector(onClickTagBlock:) withTarget:self];
}


//点击view的除了textview和textfiled的地方就隐藏
- (void)hideKeyboardWithOutTapTextFiledAndTextView:(NSArray *)views{
    [self addTagEvenBlock:^(UIView *sender) {
        if (![sender isKindOfClass:[UITextField class]] && ![sender isKindOfClass:[UITextView class]]) {
            for (UIView *eachView in views) {
                if ([eachView isKindOfClass:[UITextView class]]) {
                    [((UITextView *)eachView) resignFirstResponder];
                }else if ([eachView isKindOfClass:[UITextField class]]) {
                    [((UITextField *)eachView) resignFirstResponder];
                }
            }
        }
    }];
}

- (void)onClickTagBlock:(UITapGestureRecognizer *)singleTap{
    void (^block)(UIView *sender)  = objc_getAssociatedObject(self,&addTagEvenBlockKey);
    if (block) {
        block(singleTap.view);
    }
}

#pragma mark Frame

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint) origin {
    return self.frame.origin;
}

- (void) setOrigin:(CGPoint) point {
    self.frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)bottom {
    return self.y + self.height;
}

- (void)setBottom:(CGFloat)bottom {
    self.frame = CGRectMake(self.x, bottom - self.height, self.width, self.height);
}

- (CGFloat)right {
    return self.x + self.width;
}

- (void)setRight:(CGFloat)right {
    self.frame = CGRectMake(right - self.width, self.y, self.width, self.height);
}


//设置Y坐标，距离aboveView的interval距离
-(void) setYAbove:(float)interval withView:(UIView *)aboveView{
    self.y = aboveView.y + aboveView.height+interval;
}
//在父控件中左右居中
-(void) autoWCenter{
    self.x = self.superview.width/2 - self.width/2;
}
//在父控件中上下居中
- (void) autoHCenter{
    self.y = self.superview.height/2 - self.height/2;
}

//清理背景色
- (void) clearBackground{
    self.backgroundColor = [UIColor clearColor];
}

@end
