//
//  COImagePickerTool.h
//  COTools
//
//  Created by carlos on 13-12-19.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//用来处理ImagePicker使用的

#import "COBaseTool.h"
#import "COBlockTool.h"
@interface COImagePickerTool : COBaseTool

+ (void)showImagePickerWithVC:(UIViewController *)vc WithType:(UIImagePickerControllerSourceType )sourceType withBlock:(BaseOnClickObject) block withAllowsEditing:(BOOL)edit;
//显示图片选择器 并用block返回结果
+ (void)showImagePickerWithVC:(UIViewController *)vc WithType:(UIImagePickerControllerSourceType )sourceType withBlock:(BaseOnClickObject) block;
@end
