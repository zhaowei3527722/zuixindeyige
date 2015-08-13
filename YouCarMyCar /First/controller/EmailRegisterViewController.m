//
//  EmailRegisterViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/21.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "EmailRegisterViewController.h"
#import "MyTextFied.h"
#import "PrefixHeader.pch"

#import "AFNetworking.h"


#import "CommUtils.h"

@interface EmailRegisterViewController ()<UIScrollViewDelegate,MyTextFiedNoimageDelegete,MyTextFiedDelegete>

@end

@implementation EmailRegisterViewController

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
    self.phoneScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 720);
    self.phoneScrollView.backgroundColor = COLOR(243, 233, 221, 1);
    self.phoneScrollView.delegate = self;
    [self.phoneScrollView addGestureRecognizer:tap];
    [self.view addSubview:self.phoneScrollView];
    
    //头像
    //1photo
    // 布局登录
    
    //1photo
    self.photoImabeView  = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 40, 20, 80, 80)];
    
    self.photoImabeView.image = [UIImage imageNamed:@"头像@2x.png"];
    self.photoImabeView.layer.cornerRadius = 40;
    self.photoImabeView.layer.masksToBounds = YES;
    [self.phoneScrollView addSubview:self.photoImabeView];
    
    
    //2
    self.nickNameMY  = [[MyTextFiedNoimage alloc]initWithFrame:CGRectMake(10, 110, self.view.frame.size.width - 20, 40)];
    self.nickNameMY.mytextField.placeholder = @"请输入您的昵称";
    
    self.userNameMY  = [[MyTextFiedNoimage alloc]initWithFrame:CGRectMake(10, 160, self.view.frame.size.width - 20, 40)];
    self.userNameMY.mytextField.placeholder = @"请输入您常用的邮箱";
    
    self.numberMY  = [[MyTextFied alloc]initWithFrame:CGRectMake(10, 210, self.view.frame.size.width - 20, 40)];
    self.numberMY.mytextField.placeholder = @"输入您的邮箱验证码";
    self.numberMY.mytextField.frame = CGRectMake(100, 0, 200, 40);
    self.numberMY.mySmallimageView.frame = CGRectMake(0, 0, 100, 40);
    self.numberMY.mySmallimageView.image = [UIImage imageNamed:@"获取验证码@2x.png"];
    self.numberButton  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.numberButton.frame = CGRectMake(0, 0, 100, 40);
    [self.numberButton addTarget:self action:@selector(numberButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.numberMY addSubview:self.numberButton];
    
    
    
    
    self.pasWordMY1  = [[MyTextFiedNoimage alloc]initWithFrame:CGRectMake(10, 260, self.view.frame.size.width - 20, 40)];
    self.pasWordMY1.mytextField.placeholder = @"请您设置6位以上密码";
    
    self.psaWordMY2  = [[MyTextFiedNoimage alloc]initWithFrame:CGRectMake(10, 310, self.view.frame.size.width - 20, 40)];
    
    self.psaWordMY2.mytextField.placeholder = @"请确认您的密码";
    
    self.nickNameMY.delegate = self;
    self.userNameMY.delegate  = self;
    self.numberMY.delegate = self;
    self.pasWordMY1.delegate = self;
    self.psaWordMY2.delegate = self;
    
    
    [self.phoneScrollView addSubview:self.nickNameMY];
    [self.phoneScrollView addSubview:self.userNameMY];
    [self.phoneScrollView addSubview:self.numberMY];
    [self.phoneScrollView addSubview:self.pasWordMY1];
    [self.phoneScrollView addSubview:self.psaWordMY2];
    
    //点击注册
    self.registerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.registerButton.frame = CGRectMake(10,390, self.view.frame.size.width - 20, 40);
    [self.registerButton setTitle:@"注册" forState:(UIControlStateNormal)];
    [self.registerButton  setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景@2x.png"] forState:(UIControlStateNormal)];
    [self.registerButton addTarget:self action:@selector(registerButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.phoneScrollView addSubview:self.registerButton];
    
    
    
    
}
//========点击事件==============
-(void)numberButton:(UIButton *)button
{
    
    [self.nickNameMY.mytextField resignFirstResponder];
    [self.userNameMY.mytextField resignFirstResponder];
    [self.numberMY.mytextField resignFirstResponder];
    [self.pasWordMY1.mytextField resignFirstResponder];
    [self.psaWordMY2.mytextField resignFirstResponder];
    
    
    
    if ([CommUtils validateEmail:self.userNameMY.mytextField.text] ) {
        NSString *url = [NSString stringWithFormat:@"%@?act=member_security&op=op=send_bind_email&email=%@",kMainHttp,self.userNameMY.mytextField.text];
        NSLog(@"  wode url = = %@",url);
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            NSLog(@"%@",[responseObject valueForKey:@"code"]);
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
            
            
        }];
        
        
        
    }else {
        
        UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邮箱不正确 " delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [aller show];
        
        
        
    }
    
    
}
//注册点击事件
-(void)registerButton:(UIButton *)button
{
    if ([CommUtils validatePwd:self.pasWordMY1.mytextField.text]&&[CommUtils validatePwd:self.psaWordMY2.mytextField.text]) {
        
        NSDictionary *dic = @{@"act":@"login",@"op":@"register",@"username":self.nickNameMY.mytextField.text,@"mobile":@"",@"code":self.numberMY.mytextField.text,@"type":@"1",@"password":self.pasWordMY1.mytextField.text,@"password_confirm":self.psaWordMY2.mytextField.text,@"email":self.userNameMY.mytextField.text,@"client":@"wechat"};
        
        
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        
        [manager POST:kMainHttp parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            NSLog(@"%@",[[responseObject valueForKey:@"datas"] valueForKey:@"error"]);
            
            
            if (![[responseObject valueForKey:@"datas"] valueForKey:@"error"]) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }else {
        
        UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您输入的密码格式有误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aller show];
        
        
        
    }
    
    
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
