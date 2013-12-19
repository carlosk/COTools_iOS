//
//  UIImage+CO.h
//  COTools
//
//  Created by carlos on 13-12-8.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CO)
//图片旋转
- (UIImage *)imageWithRotation:(UIImageOrientation)orientation;

//裁剪
-(UIImage*)cropSubImage:(CGRect)rect;
//等比缩放
-(UIImage*)scaleToSize:(CGSize)size;
@end
