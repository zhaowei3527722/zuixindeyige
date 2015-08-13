//
//  ForgetViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/16.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "ForgetViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "PrefixHeader.pch"
#import <WeChatConnection/WeChatConnection.h>
#import "PhoneForgetViewController.h"
#import "EmailForgetViewController.h"
#import "LoginViewController.h"
#import <QZoneConnection/QZoneConnection.h>
#define kseGmentHeight 40
#define kscrollViewH 104

@interface ForgetViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong)PhoneForgetViewController *phoneVC;
@property (nonatomic ,strong)EmailForgetViewController *emailVC;



@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"找回密码";
    [self coustom];//布局
    
    
    // Do any additional setup after loading the view.
}
-(void)coustom
{
    //返回的箭头
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
    
    //
    self.liftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.liftButton.frame =CGRectMake(0, 64, self.view.frame.size.width / 2 ,40);
    [self.liftButton setBackgroundImage:[UIImage imageNamed:@"手机找回选中@2x.png"] forState:(UIControlStateNormal)];
    
    [self.liftButton addTarget:self action:@selector(liftButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:self.liftButton];
    
    
    self.rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightButton.frame =CGRectMake(self.view.frame.size.width / 2, 64, self.view.frame.size.width / 2 ,40);
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"邮箱找回@2x.png"] forState:(UIControlStateNormal)];
    
    [self.rightButton addTarget:self action:@selector(rightButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:self.rightButton];
    
    
    
    
    
    
    //布局 UIScrollView
    self.myscrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kscrollViewH, kMainWidth, kMainHeight - kscrollViewH)];
    self.myscrollView.contentSize = CGSizeMake(kMainWidth * 2, kMainHeight - kscrollViewH);
    self.myscrollView.backgroundColor =COLOR(243, 233, 221, 1);
    
    self.myscrollView.showsVerticalScrollIndicator = NO;
    self.myscrollView.showsVerticalScrollIndicator = NO;
    self.myscrollView.pagingEnabled = YES;
    self.myscrollView.delegate = self;
    [self.view addSubview:self.myscrollView];
    
    self.phoneVC = [[PhoneForgetViewController alloc]init];
    self.emailVC = [[EmailForgetViewController alloc]init];
    self.phoneVC.view.frame = CGRectMake(0, kMainY, kMainWidth, kMainHeight);
    self.emailVC.view.frame = CGRectMake(kMainWidth, kMainY, kMainWidth, kMainHeight);
    
    [self addChildViewController:self.phoneVC];
    [self.myscrollView addSubview:self.phoneVC.view];
    [self addChildViewController:self.emailVC];
    [self.myscrollView addSubview:self.emailVC.view];
    

    
    

}
-(void)rightButton:(UIButton *)button
{
    [self.liftButton setBackgroundImage:[UIImage imageNamed:@"手机找回未选中@2x.png"] forState:(UIControlStateNormal)];
    
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"邮箱找回选中@2x.png"] forState:(UIControlStateNormal)];
    self.myscrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    
    
}
-(void)liftButton:(UIButton *)button
{    [self.liftButton setBackgroundImage:[UIImage imageNamed:@"手机找回选中@2x.png"] forState:(UIControlStateNormal)];
    
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"邮箱找回@2x.png"] forState:(UIControlStateNormal)];
    
    self.myscrollView.contentOffset = CGPointMake(0, 0);
    
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    if (self.myscrollView.contentOffset.x/kMainWidth == 0) {
        [self.liftButton setBackgroundImage:[UIImage imageNamed:@"手机找回选中@2x.png"] forState:(UIControlStateNormal)];
        
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"手机找回未选中@2x.png"] forState:(UIControlStateNormal)];
        
        
        
    }else if (self.myscrollView.contentOffset.x/kMainWidth == 1){
        [self.liftButton setBackgroundImage:[UIImage imageNamed:@"手机注册@2x.png"] forState:(UIControlStateNormal)];
        
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"邮箱找回选中@2x.png"] forState:(UIControlStateNormal)];
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
