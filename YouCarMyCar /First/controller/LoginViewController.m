//
//  LoginViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/4.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "LoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "ForgetViewController.h"
#import "RegistViewController.h"
#import "PrefixHeader.pch"


#import "AFNetworking.h"

@interface LoginViewController ()<UIActionSheetDelegate,UITextFieldDelegate,MyTextFiedDelegete,MBProgressHUDDelegate,UIAlertViewDelegate>

@end
@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载圈圈 (登录成功后移除 登录失败也移除)
    self.HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUD];
    
    self.HUD.delegate = self;
    self.HUD.labelText = @"正在登录";

    self.indextX = self.view.frame.size.width / 320;
    self.indextY = self.view.frame.size.height / 480;
    self.indext = NO;
    
    self.view.backgroundColor = COLOR(251, 246, 240, 1);
    
    self.title = @"登录界面";
    
    if (self.indextX == 1 && self.indextY == 1) {
        
        [self thour];//布局4;
        
        
    }else{
        
        [self coustom];//布局
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
    //分享按钮
    
    
    UIButton *share = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [share setTitle:@"一键分享" forState:(UIControlStateNormal)];
    share.frame = CGRectMake(0, 0, 80, 30);
    [share addTarget:self action:@selector(share:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:share ];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:share];
    self.navigationItem.rightBarButtonItem = right;
    
    
    
    
    //返回的箭头
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
    
    
    
    self.tabBarController.tabBar.hidden = YES;
    
    //注册键盘通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated

{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    
    
}
//布局4
-(void)thour
{
    
    // 布局登录
    
    //1photo
    self.photoImabeView  = [[UIImageView alloc]initWithFrame:CGRectMake(120, 84 , 80, 80)];
    self.photoImabeView.image = [UIImage imageNamed:@"头像@2x.png"];
    self.photoImabeView.layer.cornerRadius = 40;
    self.photoImabeView.layer.masksToBounds = YES;
    [self.view addSubview:self.photoImabeView];
    
    //username
    self.userNameMy = [[MyTextFied alloc]initWithFrame:CGRectMake(10, 170, 300, 40  )];
    self.userNameMy.mySmallimageView.image = [UIImage imageNamed:@"小人头像@2x.png"];
    self.userNameMy.mytextField.placeholder = @"请输入您的登录账号";
    [self.view addSubview:self.userNameMy];
    
    
    //password
    
    self.userPassWordMy = [[MyTextFied alloc]initWithFrame:CGRectMake(10, 220, 300, 40)];
    self.userPassWordMy.mytextField.placeholder = @"请输入您的登录密码";
    self.userPassWordMy.mySmallimageView.image = [UIImage imageNamed:@"我的密码@2x.png"];
    self.userPassWordMy.mytextField.secureTextEntry = YES;
    [self.view addSubview:self.userPassWordMy];
    self.userNameMy.delegate = self;
    self.userPassWordMy.delegate = self;
    
    
    self.forgetPasswordButton  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.forgetPasswordButton.frame = CGRectMake(230, 225, 80, 30);
    
    [self.forgetPasswordButton setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
    [self.forgetPasswordButton addTarget:self action:@selector(forget) forControlEvents:(UIControlEventTouchUpInside)];
    self.forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.forgetPasswordButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [self.view addSubview:self.forgetPasswordButton];
    
    
    UILabel *smallLable = [[UILabel alloc]initWithFrame:CGRectMake(60, 263, 80, 20)];
    smallLable.text = @"下次自动登录";
    smallLable.font = [UIFont systemFontOfSize:12];
    smallLable.textColor = [UIColor grayColor];
    [self.view addSubview:smallLable];
    
    //记住密码的button
    
    self.myZibutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.myZibutton.frame = CGRectMake(38, 265, 16, 16);
    [self.myZibutton setBackgroundImage:[UIImage imageNamed:@"为选择@2x.png"] forState:(UIControlStateNormal)];
    [self.myZibutton addTarget:self action: @selector(dian) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.myZibutton];
    
    
    
    
    //登录按钮
    
    self.loginButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.loginButton.frame = CGRectMake(10, 290 *self.indextY, 300 *self.indextX, 40);
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景@2x.png"] forState:(UIControlStateNormal)];
    //    self.loginButton.backgroundColor = [UIColor colorWithRed:95 / 255 green:220 / 255 blue:225 / 255 alpha:1];
    //
    [self.loginButton setTitle:@"登录" forState:(UIControlStateNormal)];
    [self.loginButton  setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.loginButton addTarget:self action:@selector(loginButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.loginButton];
    
    //
    //
    //    //注册按钮
    //
    self.registerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.registerButton.frame = CGRectMake(10, 290 *self.indextY + 55, 300 *self.indextX, 40);
    [self.registerButton setTitle:@"注册" forState:(UIControlStateNormal)];
    [self.registerButton  setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景@2x.png"] forState:(UIControlStateNormal)];
    [self.registerButton addTarget:self action:@selector(registerButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.registerButton];
    
    
    
    
    // 第三方登录
    
    
    self.qqImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, (460 - 55) *self.indextY, 50, 50)];
    self.qqImageView.image = [UIImage imageNamed:@"qq@2x.png"];
    [self.view addSubview:self.qqImageView];
    self.qqImageView.tag = 101;
    self.qqImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(login:)];
    [self.qqImageView addGestureRecognizer:tap];
    
    //
    self.weixinImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 25, (460 - 55) *self.indextY,50, 50)];
    self.weixinImageView.tag = 102;
    self.weixinImageView.userInteractionEnabled = YES;
    self.weixinImageView.image = [UIImage imageNamed:@"微信@2x.png"];
    UITapGestureRecognizer *tapweixin = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(login:)];
    [self.weixinImageView addGestureRecognizer:tapweixin];
    [self.view addSubview:self.weixinImageView];
    
    //
    self.xinlangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, (460 - 55) *self.indextY, 50,50)];
    self.xinlangImageView.image = [UIImage imageNamed:@"微博@2x.png"];
    UITapGestureRecognizer *tapxinlang = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(login:)];
    [self.xinlangImageView addGestureRecognizer:tapxinlang];
    self.xinlangImageView.tag = 103;
    self.xinlangImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.xinlangImageView];
    
    
    
}
//布局 除了4
-(void)coustom
{
    
    // 布局登录
    
    //1photo
    self.photoImabeView  = [[UIImageView alloc]initWithFrame:CGRectMake(kMainWidth / 2 - 40, 84 * self.indextY, 80, 80)];
    
    self.photoImabeView.image = [UIImage imageNamed:@"头像@2x.png"];
    self.photoImabeView.layer.cornerRadius = 40;
    self.photoImabeView.layer.masksToBounds = YES;
    [self.view addSubview:self.photoImabeView];
    
    //username
    self.userNameMy = [[MyTextFied alloc]initWithFrame:CGRectMake(10, 180 * self.indextY, 300*self.indextX, 40  )];
    self.userNameMy.mySmallimageView.image = [UIImage imageNamed:@"小人头像@2x.png"];
    self.userNameMy.mytextField.placeholder = @"请输入您的登录账号";
    [self.view addSubview:self.userNameMy];
    
    
    
    //password
    self.userPassWordMy = [[MyTextFied alloc]initWithFrame:CGRectMake(10, 180*self.indextY + 60, 300*self.indextX, 40)];
    self.userPassWordMy.mytextField.placeholder = @"请输入您的登录密码";
    self.userPassWordMy.mySmallimageView.image = [UIImage imageNamed:@"我的密码@2x.png"];
    [self.view addSubview:self.userPassWordMy];
    self.userNameMy.delegate = self;
    self.userPassWordMy.delegate = self;
    self.userPassWordMy.mytextField.secureTextEntry = YES;
    
    
    
    
    
    //    self.userPassWordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    //
    //
    self.forgetPasswordButton  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.forgetPasswordButton.frame = CGRectMake(230 * self.indextX, 180 * self.indextY + 60, 80, 40);
    
    [self.forgetPasswordButton setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
    [self.forgetPasswordButton addTarget:self action:@selector(forget) forControlEvents:(UIControlEventTouchUpInside)];
    self.forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    //self.forgetPasswordButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [self.forgetPasswordButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [self.view addSubview:self.forgetPasswordButton];
    
    //点击记住密码
    
    UILabel *smallLable = [[UILabel alloc]initWithFrame:CGRectMake(60, 265 *self.indextY, 80, 20)];
    smallLable.text = @"下次自动登录";
    smallLable.font = [UIFont systemFontOfSize:12];
    smallLable.textColor = [UIColor grayColor];
    [self.view addSubview:smallLable];
    self.myZibutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.myZibutton.frame = CGRectMake(38, 267*self.indextY, 16, 16);
    [self.myZibutton setBackgroundImage:[UIImage imageNamed:@"为选择@2x.png"] forState:(UIControlStateNormal)];
    [self.myZibutton addTarget:self action: @selector(dian) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.myZibutton];
    //登录按钮
    
    self.loginButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.loginButton.frame = CGRectMake(10, 290 *self.indextY, 300 *self.indextX, 40);
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景@2x(1).png"] forState:(UIControlStateNormal)];
    self.loginButton.backgroundColor = [UIColor purpleColor];
    [self.loginButton setTitle:@"登录" forState:(UIControlStateNormal)];
    [self.loginButton  setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.loginButton addTarget:self action:@selector(loginButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.loginButton];
    
    
    
    //注册按钮
    
    self.registerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.registerButton.frame = CGRectMake(10, 290 *self.indextY + 55, 300 *self.indextX, 40);
    [self.registerButton setTitle:@"注册" forState:(UIControlStateNormal)];
    [self.registerButton  setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景@2x.png"] forState:(UIControlStateNormal)];
    [self.registerButton addTarget:self action:@selector(registerButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.registerButton];
    //    // 第三方登录
    
    //
    
    self.qqImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, (460 - 55) *self.indextY, 50, 50)];
    self.qqImageView.image = [UIImage imageNamed:@"qq@2x.png"];
    [self.view addSubview:self.qqImageView];
    self.qqImageView.tag = 101;
    self.qqImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(login:)];
    [self.qqImageView addGestureRecognizer:tap];
    
    //
    self.weixinImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 25, (460 - 55) *self.indextY,50, 50)];
    self.weixinImageView.tag = 102;
    self.weixinImageView.userInteractionEnabled = YES;
    self.weixinImageView.image = [UIImage imageNamed:@"微信@2x.png"];
    UITapGestureRecognizer *tapweixin = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(login:)];
    [self.weixinImageView addGestureRecognizer:tapweixin];
    [self.view addSubview:self.weixinImageView];
    
    //
    self.xinlangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, (460 - 55) *self.indextY, 50,50)];
    self.xinlangImageView.image = [UIImage imageNamed:@"微博@2x.png"];
    UITapGestureRecognizer *tapxinlang = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(login:)];
    [self.xinlangImageView addGestureRecognizer:tapxinlang];
    self.xinlangImageView.tag = 103;
    self.xinlangImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.xinlangImageView];
    
    
    
    
    
}
//点击记住密码
-(void)dian
{
    if (self.indext == NO) {
        self.indext = YES;
        [self.myZibutton setBackgroundImage:[UIImage imageNamed:@"已选择@2x.png"] forState:(UIControlStateNormal)];
        
        
        
    }else if(self.indext == YES){
        
        
        [self.myZibutton setBackgroundImage:[UIImage imageNamed:@"为选择@2x.png"] forState:(UIControlStateNormal)];
        
        
        self.indext = NO;
        
        
    }
    
    
    
    
}
//Code from Brett Schumann
//键盘出来走的方法
-(void) keyboardWillShow:(NSNotification *)note
{
    
    
    if (self.indextX == 1) {
        
        [UIView beginAnimations:@"animat" context:nil];
        //设置时间
        [UIView setAnimationDuration:0.5f];
        self.view.transform = CGAffineTransformMakeTranslation(0, -84);
        self.view.transform = CGAffineTransformScale(self.view.transform, 1.01, 1.01);
        [UIView commitAnimations];
        
        
    }
}
//键盘回收走的方法
- (void) keyboardWillHide:(NSNotification *)note
{
    
    NSLog(@"没了");
    [UIView setAnimationDuration:0.5f];
    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    self.view.transform = CGAffineTransformScale(self.view.transform, 1.01, 1.01);
    [UIView commitAnimations];
    
    
    
    
}
//点击return

-(void)ReturnAction:(UITextField *)textfield
{
    
    [textfield resignFirstResponder];
    [UIView beginAnimations:@"animat" context:nil];
    //设置时间
    [UIView setAnimationDuration:0.5f];
    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    self.view.transform = CGAffineTransformScale(self.view.transform, 1.01, 1.01);
    [UIView commitAnimations];
    
    
    
    
}

//点击空白
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userPassWordMy.mytextField resignFirstResponder];
    [self.userNameMy.mytextField resignFirstResponder];
    [UIView beginAnimations:@"animat" context:nil];
    //设置时间
    [UIView setAnimationDuration:0.5f];
    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    self.view.transform = CGAffineTransformScale(self.view.transform, 1.01, 1.01);
    [UIView commitAnimations];
    
    
    
}
//点击登录按钮走的方法
-(void)loginButton:(UIButton *)button
{
    if (self.userNameMy.mytextField.text !=nil&&![self.userNameMy.mytextField.text isEqualToString:@""]&&self.userPassWordMy.mytextField.text !=nil&&![self.userPassWordMy.mytextField.text isEqualToString:@""]) {
        
        
        [self.HUD show:YES];
        
        NSDictionary *dic = @{@"act":@"login",@"username":self.userNameMy.mytextField.text,@"password":self.userPassWordMy.mytextField.text,@"client":@"wechat"};
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        [manager POST:kMainHttp parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {

            
            if ([[responseObject valueForKey:@"datas"] valueForKey:@"error"]) {
                UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:[[responseObject valueForKey:@"datas"] valueForKey:@"error"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                aller.tag = 100;
                
                
                [aller show];
                
                
            }
            
            if ([[responseObject valueForKey:@"datas"] valueForKey:@"key"]) {
                //存入用户的信息
                [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"key"] forKey:@"key"];
                
                [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"avatar"] forKey:@"avatar"];
                NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"avatar"]);
                
                [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"email"] forKey:@"email"];
                
                [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"sex"] forKey:@"sex"];
                
                
                

                //姓名
                
                if ([[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"true_name"]) {
                    [[NSUserDefaults standardUserDefaults]setValue:[[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"true_name"] forKey:@"true_name"];
                }
                
                
                
                //地址

                
                if ([[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"address"]) {
                    [[NSUserDefaults standardUserDefaults] setObject:[[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"address"] forKey:@"address"];
                }else {
                    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"address"];
                }
                
                //电话
                
                if ([[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"zip_code"]) {
                    [[NSUserDefaults standardUserDefaults]setValue:[[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"zip_code"] forKey:@"zip_code"];
                }
                
                //邮编
                
                if ([[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"mob_phone"]) {
                    [[NSUserDefaults standardUserDefaults]setValue:[[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"mob_phone"] forKey:@"mob_phone"];
                }
                
                [[NSUserDefaults standardUserDefaults]setValue:[[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"zip_code"] forKey:@"zip_code"];
                
                [[NSUserDefaults standardUserDefaults]setValue:[[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"true_name"] forKey:@"true_name"];
                
                
                
                
                
                
                
                


                [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"username"] forKey:@"username"];
        
                [[NSUserDefaults standardUserDefaults]setValue:[[responseObject valueForKey:@"datas"] valueForKey:@"member_truename"] forKey:@"member_truename"];
                
                
                [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"code"];
                
                
                
                [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"member_id"] forKey:@"member_id"];
                [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"mobile"]  forKey : @"mobile"];
                
                
    if ([[responseObject valueForKey:@"datas"] valueForKey:@"member_truename"] != [NSNull null])
    
    
    {
                    
        [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"member_truename"]  forKey : @"member_truename"];
                }
                
                
                //存入 用户的密码 以备不时之需
                [[NSUserDefaults standardUserDefaults] setObject:self.userPassWordMy.mytextField.text forKey:@"userPassWord"];
                
                UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您已成功登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                aller.tag = 101;
                
                [aller show];
                
                
                
                
            }
            
            [self.HUD removeFromSuperview];
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self.HUD removeFromSuperview];
            
            
            
        }];

    }else {
        
        
        UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名和密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [aller show];
        
        
        
    }
         
         
      
 }
         
         
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }

    }
    
}
- (void)hudWasHidden:(MBProgressHUD *)hud;
{
    NSLog(@"就是这个");
    
}

//点击注册走的方法

-(void)registerButton:(UIButton *)button
{
    NSLog(@"注册");
    
    RegistViewController *regis = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:regis animated:YES];
    
    
}


//忘记密码的点击事件
-(void)forget
{
    NSLog(@"忘记密码");
    
    [self.userNameMy.mytextField resignFirstResponder];
    [self.userPassWordMy.mytextField resignFirstResponder];
    
    //设置时间
    [UIView setAnimationDuration:0.5f];
    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    self.view.transform = CGAffineTransformScale(self.view.transform, 1.01, 1.01);
    [UIView commitAnimations];
    
    
    
    ForgetViewController *forget = [[ForgetViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
    
    
    
}
//点击分享走的方法

-(void)share:(UIButton *)share
{
    //1.定制分享的内容
    NSString* path = [[NSBundle mainBundle]pathForResource:@"fdssfsf" ofType:@"jpg"];
    id<ISSContent> publishContent = [ShareSDK content:@"Hello,nichewoche.com" defaultContent:nil image:[ShareSDK imageWithPath:path] title:@"This is title" url:@"http://nichewoche.com" description:@"This is description" mediaType:SSPublishContentMediaTypeNews];
    
    
    //    NSArray *shareList = [ShareSDK customShareListWithType:
    //                          SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),SHARE_TYPE_NUMBER(ShareTypeQQ),SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),nil];
    
    //2.调用分享菜单分享
    [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        //如果分享成功
        
        if (state == SSResponseStateSuccess) {
            NSLog(@"分享成功");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        //如果分享失败
        if (state == SSResponseStateFail) {
            NSLog(@"分享失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"分享失败，请看日记错误描述" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        if (state == SSResponseStateCancel){
            NSLog(@"分享取消");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"进入了分享取消状态" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
}
//第三方登录走的方法

-(void)login:(UITapGestureRecognizer *)sent
{
    [self.HUD show:YES];

    
    UIImageView *image = (UIImageView *)sent.view;
    if (image.tag == 101) {
        NSLog(@"QQ登录");
        id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
        
        [app setIsAllowWebAuthorize:YES];
        [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
            if (result) {
                NSLog(@"授权登陆成功，已获取用户信息");
                self.uid= [userInfo uid];
                self.nickname = [userInfo nickname];
                self.imageurl = [userInfo profileImage];
               
                [self login];//掉 登录的方法
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"授权失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                [self.HUD removeFromSuperview];

            }
        }];
        
        
    }else if (image.tag == 102){
        
        NSLog(@"微信登录");
        [ShareSDK getUserInfoWithType:ShareTypeWeixiSession authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
            if (result) {
               NSLog(@"授权登陆成功，已获取用户信息 %@",userInfo);
                 self.uid = [userInfo uid];
                self.nickname = [userInfo nickname];
                self.imageurl = [userInfo profileImage];
                
                
                [self login];
                
                
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"授权失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                [self.HUD removeFromSuperview];

            }
        }];
        
        
    }else if (image.tag == 103){
        
        NSLog(@"微博登录");
        id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
        [app setIsAllowWebAuthorize:YES];
        
        [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
            if (result) {
                self.uid = [userInfo uid];
                self.nickname = [userInfo nickname];
                self.imageurl = [userInfo profileImage];
                [self login];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"授权失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                
                [self.HUD removeFromSuperview];
                
            }
        }];
        
        
    }
    
    
    
    
    
}



-(void)login
{
    /*	请求参数：
     •	act = login
     •	op = other_login
     •	opened = 第三方唯一识别号
     •	truename = 昵称
     •	sex = 性别
     •	avatar 头像
     */
    [self.userNameMy.mytextField resignFirstResponder];
    [self .userPassWordMy.mytextField resignFirstResponder];
    

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@?act=login&op=other_login&openid=%@&truename=%@&sex=&avatar=%@",kMainHttp,self.uid,self.nickname,self.imageurl];
    NSLog(@" name = %@ uid = %@ ima = %@",self.nickname,self.uid,self.imageurl);
    NSString *urlF8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@" = = = = %@",url);
    
    [manager GET:urlF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"    dic == === %@",responseObject);
        NSLog(@"error = %@",[[responseObject valueForKey:@"datas"] valueForKey:@"error"]);
        
        if ([[responseObject valueForKey:@"datas"] valueForKey:@"error"]) {
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:[[responseObject valueForKey:@"datas"] valueForKey:@"error"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            aller.tag = 100;
            
            
            [aller show];
            
            
        }
        
        if ([[responseObject valueForKey:@"datas"] valueForKey:@"key"]) {
            //存入用户的信息
            [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"key"] forKey:@"key"];
            
            //                [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"member_truename"] forKey:@"member_truename"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"avatar"] forKey:@"avatar"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"email"] forKey:@"email"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"sex"] forKey:@"sex"];
            
            
            
            
            NSString *address = [[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"address"];
            
            if ([[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"address"]) {
                [[NSUserDefaults standardUserDefaults] setObject:[[[responseObject valueForKey:@"datas"] valueForKey:@"address"]valueForKey:@"address"] forKey:@"address"];
            }else {
                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"address"];
            }
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"address"]);
            
            
            [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"address"];
            NSLog(@"%@",[[responseObject valueForKey:@"datas"] valueForKey:@"address"]);
            
            [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"username"] forKey:@"username"];
            
            [[NSUserDefaults standardUserDefaults]setValue:[[responseObject valueForKey:@"datas"] valueForKey:@"member_truename"] forKey:@"member_truename"];
            
            [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"code"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"member_id"] forKey:@"member_id"];
            [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"mobile"]  forKey : @"mobile"];

            if ([[responseObject valueForKey:@"datas"] valueForKey:@"member_truename"] != [NSNull null])
                
                
            {
                
                [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"datas"] valueForKey:@"member_truename"]  forKey : @"member_truename"];
            }
            
            
            //存入 用户的密码 以备不时之需
            [[NSUserDefaults standardUserDefaults] setObject:self.userPassWordMy.mytextField.text forKey:@"userPassWord"];
            
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您已成功登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            aller.tag = 101;
            
            [aller show];
            
            
            
            
        }
        
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [self.HUD removeFromSuperview];

    
}

//返回走的方法
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
