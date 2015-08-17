//
//  PhoneForgetViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/23.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "PhoneForgetViewController.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"

#import "CommUtils.h"



@interface PhoneForgetViewController ()<MyTextFiedNoimageDelegete,UIScrollViewDelegate,MyTextFiedDelegete,UIAlertViewDelegate>


@end

@implementation PhoneForgetViewController

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
    self.phoneScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 640);
    self.phoneScrollView.backgroundColor = COLOR(243, 233, 221, 1);
    self.phoneScrollView.delegate = self;
    [self.phoneScrollView addGestureRecognizer:tap];
    [self.view addSubview:self.phoneScrollView];
    
    self.userNameMY  = [[MyTextFied alloc]initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, 40)];
    self.userNameMY.mytextField.placeholder = @"请输入手机号";
    self.userNameMY.mytextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.userNameMY.mySmallimageView.frame =CGRectMake(0, 0, 40, 40);
    self.userNameMY.mySmallimageView.image = [UIImage imageNamed:@"+86@2x(1).png"];
    self.userNameMY.mytextField.frame = CGRectMake(40, 0, self.view.frame.size.width - 60, 40);
    
    
    
    self.numberMY  = [[MyTextFied alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width - 20, 40)];
    self.numberMY.mytextField.placeholder = @"输入您的手机验证码";
    self.numberMY.mytextField.frame = CGRectMake(100, 0, 200, 40);
    self.numberMY.mySmallimageView.frame = CGRectMake(0, 0, 100, 40);
    self.numberMY.mytextField.keyboardType = UIKeyboardTypeNumberPad;
    self.numberMY.mySmallimageView.image = [UIImage imageNamed:@"获取验证码@2x.png"];
    self.numberButton  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.numberButton.frame = CGRectMake(0, 0, 100, 40);
    [self.numberButton addTarget:self action:@selector(numberButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.numberMY addSubview:self.numberButton];
    
    
    
    self.pasWordMY1  = [[MyTextFiedNoimage alloc]initWithFrame:CGRectMake(10, 140, self.view.frame.size.width - 20, 40)];
    self.pasWordMY1.mytextField.placeholder = @"请您设置6位以上密码";
    self.psaWordMY2  = [[MyTextFiedNoimage alloc]initWithFrame:CGRectMake(10, 200, self.view.frame.size.width - 20, 40)];
    
    self.psaWordMY2.mytextField.placeholder = @"请确认您的密码";
    
//    self.nickNameMY.delegate = self;
    self.userNameMY.delegate  = self;
    self.numberMY.delegate = self;
    self.pasWordMY1.delegate = self;
    self.psaWordMY2.delegate = self;
    
    
//    [self.phoneScrollView addSubview:self.nickNameMY];
    [self.phoneScrollView addSubview:self.userNameMY];
    [self.phoneScrollView addSubview:self.numberMY];
    [self.phoneScrollView addSubview:self.pasWordMY1];
    [self.phoneScrollView addSubview:self.psaWordMY2];
    
    
    //点击注册
    self.registerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.registerButton.frame = CGRectMake(10,270, self.view.frame.size.width - 20, 40);
    [self.registerButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.registerButton  setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景@2x.png"] forState:(UIControlStateNormal)];
    [self.registerButton addTarget:self action:@selector(registerButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.phoneScrollView addSubview:self.registerButton];
    
    
    
}
//========点击事件==============
-(void)numberButton:(UIButton *)button
{
    NSLog(@"获取验证码");
    [self.userNameMY.mytextField resignFirstResponder];
    [self.numberMY.mytextField resignFirstResponder];
    [self.pasWordMY1.mytextField resignFirstResponder];
    [self.psaWordMY2.mytextField resignFirstResponder];
    
//    NSLog(@"%hhd",[CommUtils validatePhoneNumber:self.userNameMY.mytextField.text]);
    
    if ([CommUtils validatePhoneNumber:self.userNameMY.mytextField.text]) {
        
        NSString *url = [NSString stringWithFormat:@"%@?act=member_security&op=send_modify_mobile&mobile=%@",kMainHttp,self.userNameMY.mytextField.text];
        NSLog(@"  wode url = = %@",url);
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"%@",[responseObject valueForKey:@"code"]);
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
            
            
        }];
        
        
        
    }else {
        
        UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号有误 " delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [aller show];
        
        
        
    }
    
    
    

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}
//点击确定 的点击事件
-(void)registerButton:(UIButton *)button
{//act=member_security
//    •	op=reset_pwd
//    •	code 验证码
//    •	password 密码
//    •	password_confirm 确认密码
//    •	parameter 依照参数【手机号/邮箱】
//    •	type 类型，2手机号，3邮箱
//    

    
    
    NSString *strin = [NSString stringWithFormat:@"%@?act=member_security&op=reset_pwd&code=%@&password=%@&password_confirm=%@&parameter=%@&type=2",kMainHttp,self.numberMY.mytextField.text,self.pasWordMY1.mytextField.text,self.psaWordMY2.mytextField.text,self.userNameMY.mytextField.text];
    NSLog(@"123 == == =%@",strin);
    
    
    NSString *srtinF8 = [strin stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:srtinF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
   NSString *string =[[[responseObject valueForKey:@"datas"]valueForKey:@"error"] valueForKey:@"msg"];
        
            
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
        
        
        
                
            
     
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
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
    
//    [self.nickNameMY.mytextField resignFirstResponder];
    [self.userNameMY.mytextField resignFirstResponder];
    [self.numberMY.mytextField resignFirstResponder];
    [self.pasWordMY1.mytextField resignFirstResponder];
    [self.psaWordMY2.mytextField resignFirstResponder];
    
    
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
