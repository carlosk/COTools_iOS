//
//  COImagePickerTool.m
//  COTools
//
//  Created by carlos on 13-12-19.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COImagePickerTool.h"

@interface COImagePickerTool()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,copy)BaseOnClickObject mBlock;
@end

@implementation COImagePickerTool

+(COImagePickerTool *)single{
    static COImagePickerTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[COImagePickerTool alloc] init];
    });
    tool.mBlock = nil;
    return tool;
    
}

+ (void)showImagePickerWithVC:(UIViewController *)vc WithType:(UIImagePickerControllerSourceType )sourceType withBlock:(BaseOnClickObject) block withAllowsEditing:(BOOL)edit{
    COImagePickerTool *tool = [self single];
    tool.mBlock = block;
    
    UIImagePickerController *imagePicker = [[ UIImagePickerController alloc ] init ];
    imagePicker. sourceType = sourceType ;
    imagePicker.allowsEditing = edit;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        imagePicker.showsCameraControls = YES;
    }
    imagePicker. delegate = tool ;
    [vc presentViewController:imagePicker animated:YES completion:nil];
    
}
//显示图片选择器 并用block返回结果
+ (void)showImagePickerWithVC:(UIViewController *)vc WithType:(UIImagePickerControllerSourceType )sourceType withBlock:(BaseOnClickObject) block{
    [self showImagePickerWithVC:vc WithType:sourceType withBlock:block withAllowsEditing:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image{
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (self.mBlock) {
        self.mBlock(info);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    if (self.mBlock) {
        self.mBlock(nil);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
