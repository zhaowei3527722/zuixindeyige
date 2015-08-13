//
//  EmailForgetViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/23.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "EmailForgetViewController.h"
#import "PrefixHeader.pch"

@interface EmailForgetViewController ()<MyTextFiedNoimageDelegete,UIScrollViewDelegate,MyTextFiedDelegete>


@end

@implementation EmailForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cuostom];//布局
    self.indextX = self.view.frame.size.width / 320;
    self.indextY = self.view.frame.size.height / 480;
    
    
    
    // Do any additional setup after loading the view.
}
-(void)cuostom
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    self.phoneScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.phoneScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 20 );
    self.phoneScrollView.backgroundColor = COLOR(243, 233, 221, 1);
    self.phoneScrollView.delegate = self;
    [self.phoneScrollView addGestureRecognizer:tap];
    [self.view addSubview:self.phoneScrollView];
    
    
    // 布局登录
    
    
    //2
    self.nickNameMY  = [[MyTextFiedNoimage alloc]initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, 40)];
    self.nickNameMY.mytextField.placeholder = @"请输入您的昵称";
    
    self.userNameMY  = [[MyTextFiedNoimage alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width - 20, 40)];
    self.userNameMY.mytextField.placeholder = @"请输入您绑定的邮箱";
    
    self.nickNameMY.delegate = self;
    self.userNameMY.delegate  = self;
    
    
    [self.phoneScrollView addSubview:self.nickNameMY];
    [self.phoneScrollView addSubview:self.userNameMY];
    
    //点击注册
    self.registerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.registerButton.frame = CGRectMake(10,150, self.view.frame.size.width - 20, 40);
    [self.registerButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.registerButton  setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景@2x.png"] forState:(UIControlStateNormal)];
    [self.registerButton addTarget:self action:@selector(registerButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.phoneScrollView addSubview:self.registerButton];
    
    
    
    
}
//========点击事件==============
//确定点击事件
-(void)registerButton:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

//键盘出来走的方法
-(void) keyboardWillShow:(NSNotification *)note
{
    
}
//点击return

-(void)ReturnAction:(UITextField *)textfield
{
    
    [textfield resignFirstResponder];
    
    
    
}
-(void)tap:(UITapGestureRecognizer *)tap
{
    
    [self.nickNameMY.mytextField resignFirstResponder];
    [self.userNameMY.mytextField resignFirstResponder];
    
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
