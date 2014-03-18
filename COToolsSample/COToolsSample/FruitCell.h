//
//  FruitCell.h
//  COToolsSample
//
//  Created by carlos on 14-3-4.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import "COBaseCell.h"

@interface FruitCell : COBaseCell
@property(nonatomic,weak)IBOutlet UIImageView *iconIV;//图片
@property(nonatomic,weak)IBOutlet UILabel *titleL;//标题
@property(nonatomic,weak)IBOutlet UILabel *priceL;//价格
- (void)fillData:(id)item withIndexPath:(NSIndexPath *)indexPath;
@end
