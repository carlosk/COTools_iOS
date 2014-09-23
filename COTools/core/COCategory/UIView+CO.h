//
//  UIView+CO.h
//  MyFamework
//
//  Created by carlos on 13-9-7.
//  Copyright (c) 2013年 carlos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CO)

@property (nonatomic, readwrite) CGFloat x;
@property (nonatomic, readwrite) CGFloat y;
@property (nonatomic, readwrite) CGFloat width;
@property (nonatomic, readwrite) CGFloat height;
@property (nonatomic, readwrite) CGSize size;
@property (nonatomic, readwrite) CGPoint origin;
@property (nonatomic, readwrite) CGFloat bottom;
@property (nonatomic, readwrite) CGFloat right;


//view转换成图片
- (UIImage*)convertViewToImage;
//根据Xib文件创建View
+(id) createWithXib:(NSString *)xibName;
//根据Xib文件创建View
+(id) createWithXib;

//给view添加按键事件
-(void) addTagEven:(SEL) mSel withTarget:(id)target;
//添加view的tag事件到block上
-(void) addTagEvenBlock:(void (^)(UIView *sender))block;
//如果tag为-1或者0,则不选择
-(void) fillSubViewsWithBlock:(void (^)(UIView *childV))block withTag:(NSInteger )tag;
//设置字体和颜色
-(void)setFontAndColorWithFont:(UIFont *)font withColor:(UIColor *)color withTag:(int )tag;
//点击view的除了textview和textfiled的地方就隐藏
- (void)hideKeyboardWithOutTapTextFiledAndTextView:(NSArray *)views;
#pragma mark Frame

//设置Y坐标，距离aboveView的interval距离
-(void) setYAbove:(float)interval withView:(UIView *)aboveView;
//在父控件中左右居中
-(void) autoWCenter;
//在父控件中上下居中
- (void) autoHCenter;
//清理背景色
- (void) clearBackground;

@end
