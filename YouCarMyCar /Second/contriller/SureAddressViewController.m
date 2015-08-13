//
//  SureAddressViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/29.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "SureAddressViewController.h"
#import "PrefixHeader.pch"


@interface SureAddressViewController ()

@end

@implementation SureAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认地址";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
    [self coustom];//布局
    
    
}
-(void)coustom


{
    self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 550)];
    self.myScrollView.contentSize = CGSizeMake(0, 550);
    self.myScrollView.backgroundColor = COLOR(243, 233, 221, 1);
    
    [self.view addSubview:self.myScrollView];
    
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kMainWidth, 30)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"请您确认信息,以便我们准确发货";
    lable.textColor = [UIColor whiteColor];
    lable.backgroundColor = [UIColor blueColor];
    [self.myScrollView addSubview:lable];
    
    
    self.myNameMY  = [[MyTextFiedNoimage alloc]initWithFrame:CGRectMake(15, 50, kMainWidth - 30, 40)];
    self.myNameMY.mytextField.placeholder = @"用户名";
    
    self.myAddressMY = [[MyTextFiedNoimage alloc]initWithFrame:CGRectMake(15, 100, kMainWidth - 30, 40)];
    self.myAddressMY.mytextField.placeholder = @"用户地址";
    
    self.myPhoneNumberMy = [[MyTextFiedNoimage alloc]initWithFrame:CGRectMake(15, 150, kMainWidth - 30, 40)];
    self.myPhoneNumberMy.mytextField .placeholder = @"手机号";
    
    self.myEmailMY = [[MyTextFiedNoimage alloc]initWithFrame:CGRectMake(15, 200, kMainWidth - 30, 40)];
    self.myEmailMY.mytextField.placeholder = @"邮编";
    
    [self.myScrollView addSubview:self.myNameMY];
    [self .myScrollView  addSubview:self.myAddressMY];
    [self.myScrollView addSubview:self.myPhoneNumberMy];
    [self.myScrollView addSubview:self.myEmailMY];
    
    
    self.mySureButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.mySureButton.frame = CGRectMake(10, 260, kMainWidth - 20, 43);
    [self.myScrollView addSubview:self.mySureButton];
    [self.mySureButton  setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景@2x.png"] forState:(UIControlStateNormal)];
    [self.mySureButton setTitle:@"确认" forState:(UIControlStateNormal)];
    [self.mySureButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.mySureButton addTarget:self action:@selector(mySureButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    
    
}
//点击确定的方法

-(void)mySureButton:(UIButton *)button
{
    NSLog(@"确认收货地址");
    
}
-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
