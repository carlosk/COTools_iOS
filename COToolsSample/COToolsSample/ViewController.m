//
//  ViewController.m
//  COTools
//
//  Created by carlos on 13-9-20.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "ViewController.h"
#import "TestCell.h"
#import "COUtils.h"
#import "TestDomain.h"
@interface ViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView  * mTableV;
@property(nonatomic,weak)IBOutlet UITextField *contentTF;
@property(nonatomic,weak)IBOutlet UITextView *contentTV;
@property(nonatomic,weak)IBOutlet UIScrollView *bgScrollView;


@end

@implementation ViewController

- (void)viewDidLoad
{
       self.contentTF.delegate = self;
    self.contentTF.maxLength = 2;
//    __block typeof(self)bSelf = self;

//    [self.view addTagEvenBlock:^(UIView *sender) {
//        if (![sender isKindOfClass:[UITextField class]]) {
//            [bSelf.contentTF resignFirstResponder];
//        }
//        CLogb(@"%@",sender);
//    }];
//    CGRect rect = CGRectMake(x, y, w, h);
    [self.view hideKeyboardWithOutTapTextFiledAndTextView:@[self.contentTF,self.contentTV]];
//    self.contentTV.delegate = self;
//    self.contentTV.maxLength = 3;
    NSString *test = @"";
    test.coObject = @(1);
    CLog(@"%@",test.coObject);
    [test receiveObject:^(id object) {
        CLog(@"%@",object);

    }];
    
    [test sendObject:@"aaa"];
    
    [test handlerDefaultEventWithBlock:^(NSString *test1,NSString *test2){
        CLog(@"%@=%@",test1,test2);

    }];

    void(^block)(NSString *test1,NSString *test2) = [test blockForDefaultEvent];
    block(@"t1",@"t2");

    //domain的desp
    TestDomain *doamin = [[TestDomain alloc]init];
    doamin.name = @"carlos";
    doamin.age = 123;
    doamin.address = @"上海市test";
    CLog(@"%@",doamin);

    //测试数据存储
    [TestDomain saveArchiverOne:doamin];
    id domain = [TestDomain getArchiverOne:[TestDomain class]];
    
    CLog(@"从文件里取出来的%@",domain);
    //测试数组的存入
    
    
    doamin = [[TestDomain alloc]init];
    doamin.name = @"a1";
    doamin.age = 12;
    doamin.address = @"addressaa";
    NSMutableArray *data = [NSMutableArray array];
    [data addObject:domain];
    doamin.name = @"a2";
    doamin.age = 12222;
    doamin.address = @"addressaa222";
    [data addObject:domain];
    [NSObject  saveArchiverArray:data withClass:[TestDomain class]];
    NSArray *data1 =[NSObject getArchiverArray:[TestDomain class]];
    for (TestDomain *eachDomain in data1) {
        CLog(@"%@",eachDomain);

    }
    
    //测试json domain的解析
    NSDictionary *dictTest = @{@"name":@"chen child",@"age":@(11),@"address":@"啊啊啊"};
        NSDictionary *dictTest1 = @{@"name":@"chen",@"age":@"3311",@"address":@"安师大发水电费",@"childDomain":dictTest};
    TestDomain *testDomain = [[TestDomain alloc]initWithJson:dictTest1];
    CLog(@"testDomain = %@",testDomain);

    //检测textview的内容block
    self.contentTV.delegate = self;
    [COCommTool registerForKeyboardNotificationsWithScrollView:self.bgScrollView withInputViews:@[self.contentTV,self.contentTF]];
//    [self.contentTV ];
    BOOL(^checkBlock)(NSString  *strNew,NSString *strOld) = ^BOOL (NSString  *strNew,NSString *strOld) {
        CLog(@"新的是%@,旧的是%@",strNew,strOld);
        return strNew.length < 4;
//        return YES;
    };
//    NSMutableArray *a = nil;

    [self.contentTV setCheckEditContentBlock:checkBlock];
//    int maxLength = 2;
//    [super viewDidLoad];
//    [self.contentTF.rac_textSignal map:^id(id value) {
//     
//      return @"test";
//    }];
//    [self.contentTF.rac_textSignal subscribeNext:^(NSString *x) {
//        CLog(@"%@",x);
//        if (x.length > maxLength) {
//            [self.contentTF.rac_newTextChannel distinctUntilChanged];
//        }
//        
//    }];
    
//    TestCell *cell = [TestCell createVWithXib];
//    self.mTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 400) style:UITableViewStylePlain];
////    [self.view addSubview:self.mTableV];
//    self.mTableV.backgroundColor = [UIColor clearColor];
//    self.mTableV.separatorStyle = UITableViewCellSelectionStyleNone;
//    NSArray *datas1 = @[@"第一个",@"第二个" ];
//    NSArray *datas2 = @[@"第三个",@"第四个" ];
//    NSMutableArray *setions = [NSMutableArray arrayWithArray:@[datas1,datas2]];
//    
//    UILabel *mTitleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 300, 21)];
//    mTitleL.text = @"测试1212312sdfadsfdadsfas";
//    mTitleL.font = [UIFont systemFontOfSize:18.f];
//    [self.view addSubview:mTitleL];
////    [self.mTableV fillWithItems:datas withFillCellBlock:^(id cell, id item, NSIndexPath *indexPath) {
////    } withCOBaseCellClass:[TestCell class]];
//    [self.mTableV fillWithSetions:setions withFillCellBlock:nil withCOBaseCellClass:[TestCell class]];
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(150, 20, 58, 70)];
    icon.backgroundColor  = [UIColor  yellowColor];
    [self.view addSubview:icon];
//    self.icon  = icon;
    icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tagGestuer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickIcon)];
    [icon addGestureRecognizer:tagGestuer];
    //    [self test2];
    //    NSLog(@"我是viewDidLoad");
    // Do any additional setup after loading the view from its nib.
}
- (void)onClickIcon{
    [COImagePickerTool showImagePickerWithVC:self WithType:UIImagePickerControllerSourceTypeCamera withBlock:^(id object) {
        CLog(@"%@",object);
    }];
}


#pragma mark TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}


@end
