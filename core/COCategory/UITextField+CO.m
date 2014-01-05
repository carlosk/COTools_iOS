//
//  UITextField+CO.m
//  COTools
//
//  Created by carlos on 14-1-5.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import "UITextField+CO.h"
#import "UIControl+CO.h"
#import <objc/runtime.h>


@implementation UITextField (CO)
#define kLimitTextLengthKey @"kLimitTextLengthKey"
- (void)setMaxLength:(int)length

{
    if (length <= 0) {
        return;
    }
    
    objc_setAssociatedObject(self, (const void *)(kLimitTextLengthKey), [NSNumber numberWithInt:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTarget:self action:@selector(textFieldTextLengthLimit:) forControlEvents:UIControlEventEditingChanged];
    [self handleControlEvent:UIControlEventEditingChanged withBlock:^(id sender) {
        NSNumber *lengthNumber = objc_getAssociatedObject(self, (const void *)(kLimitTextLengthKey));
        
        int length = [lengthNumber intValue];
        
        if(self.text.length > length){
            
            self.text = [self.text substringToIndex:length];
            
        }

    }];
    
}
-(int)maxLength{
    NSNumber *lengthNumber = objc_getAssociatedObject(self, (const void *)(kLimitTextLengthKey));

    return [lengthNumber intValue];
}



- (void)textFieldTextLengthLimit:(id)sender

{
    
    NSNumber *lengthNumber = objc_getAssociatedObject(self, (const void *)(kLimitTextLengthKey));
    
    int length = [lengthNumber intValue];
    
    if(self.text.length > length){
        
        self.text = [self.text substringToIndex:length];
        
    }
    
}
@end
