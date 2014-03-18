//
//  Test01.m
//  COToolsSample
//
//  Created by carlos on 14-3-4.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import "Test01.h"
#import "FruitCell.h"
#import "FruitDomain.h"

@interface Test01 ()
@property(nonatomic,weak)IBOutlet UITableView *mTableV;//这是我的tableview
@property(nonatomic,strong)NSMutableArray  * fruits;
@end

@implementation Test01

#pragma mark View初始化

- (void)viewDidLoad{
    [super viewDidLoad];
    [self createViews];
    [self createData];
    [self createEven];
}
-(void)createViews{
    self.fruits = [NSMutableArray array];
    [self.mTableV fillWithItems:self.fruits withFillCellBlock:nil withCOBaseCellClass:[FruitCell class]];
    
}
- (void)fillViewsOnResume{
    
}




#pragma mark 数据

- (void)createData
{
    //获取新的数据
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(aQueue, ^{
        //获取新的数据
        NSString *content = [self connect];
        //把数据解析成对象
        NSArray *newFruits = [self parserData:content];
        if (newFruits.count >0) {
            [self.fruits removeAllObjects];
            [self.fruits addObjectsFromArray:newFruits];
        }
        //刷新列表
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [self.mTableV reloadData];
        });
        
    });

}
//把json解析成数据对象
- (NSArray *)parserData:(NSString *)jsonContent{
    NSError *error = nil;
    if (!jsonContent) {
        return nil;
    }
    
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:[jsonContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *eachItem in arr) {
        //        DLog(@"%@",eachItem);
        FruitDomain *domain = [[FruitDomain alloc]initWithJson:eachItem];
        [result addObject:domain];
    }
    
    return result;
}

//从网络获取数据
- (NSString *)connect{
    //url
    NSString *urlAsString=@"http://192.168.1.118:5000/fruits";
    NSURL *url=[NSURL URLWithString:urlAsString];
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:url];
    //获取新的数据

    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    NSString* content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    CLog(@"data = %@",content);
    return  content;
    
}
- (void)fillDataOnResume{
    
}
#pragma mark 网络连接

#pragma mark 按钮事件
-(void)createEven{
    //    __block typeof(self)bSelf = self;
}
//点击了某个按钮
-(BOOL)onClick:(UIView *)sender{
    return NO;
}

//#pragma UITableViewDelegate
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    static NSString *CellIdentifier = @"FruitCell";
//    FruitCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[FruitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    FruitDomain *fuit = self.fruits[indexPath.row];
//    [cell fillData:fuit withIndexPath:indexPath];
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [FruitCell getCellHeight:nil withIndexPath:indexPath].floatValue;
//}






@end
