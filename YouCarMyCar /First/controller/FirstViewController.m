//
//  FirstViewController.m
//  YoucarMycar
//
//  Created by LLY on 15-6-26.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "FirstViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "PrefixHeader.pch"
#import <WeChatConnection/WeChatConnection.h>
#import "NowViewController.h"
#import "WillViewController.h"
#import "LoginViewController.h"


#import <QZoneConnection/QZoneConnection.h>
#define kseGmentHeight 40
#define kscrollViewH 104


@interface FirstViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)NowViewController *nowVC;
@property (nonatomic,strong)WillViewController *willVC;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"免费试用";
    
     //布局
    [self costom];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = NO;
    
    
}

-(void)costom
{

    self.liftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.liftButton.frame =CGRectMake(0, 64, self.view.frame.size.width / 2 ,40);
    [self.liftButton setBackgroundImage:[UIImage imageNamed:@"正在进行@2x.png"] forState:(UIControlStateNormal)];
    [self.liftButton addTarget:self action:@selector(liftButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.liftButton];
    
    self.rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightButton.frame =CGRectMake(self.view.frame.size.width / 2, 64, self.view.frame.size.width / 2 ,40);
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"即将开启未选中@2x.png"] forState:(UIControlStateNormal)];
    [self.rightButton addTarget:self action:@selector(rightButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.rightButton];

    
    
    
    
    //布局 UIScrollView
    self.myscrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kscrollViewH, kMainWidth , kMainHeight - kscrollViewH - 44)];
    self.myscrollView.contentSize = CGSizeMake(kMainWidth * 2, 0);
    self.myscrollView.backgroundColor = [UIColor whiteColor];
    self.myscrollView.showsVerticalScrollIndicator = NO;
    self.myscrollView.showsVerticalScrollIndicator = NO;
    self.myscrollView.pagingEnabled = YES;
    self.myscrollView.delegate = self;
    [self.view addSubview:self.myscrollView];

    self.nowVC = [[NowViewController alloc]init];
    self.willVC = [[WillViewController alloc]init];
    self.nowVC.view.frame = CGRectMake(0, kMainY, kMainWidth, kMainHeight);
    self.willVC.view.frame = CGRectMake(kMainWidth, kMainY, kMainWidth, kMainHeight);
    
    [self addChildViewController:self.nowVC];
    [self.myscrollView addSubview:self.nowVC.view];
    [self addChildViewController:self.willVC];
    [self.myscrollView addSubview:self.willVC.view];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 45, 25);
    [button setTitle:@"登录" forState:(UIControlStateNormal)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
    [button addTarget:self action:@selector(login:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
}
-(void)rightButton:(UIButton *)button
{
    [self.liftButton setBackgroundImage:[UIImage imageNamed:@"正在进行未选中@2x.png"] forState:(UIControlStateNormal)];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"即将开启选中@2x.png"] forState:(UIControlStateNormal)];
    self.myscrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    
    
}
-(void)liftButton:(UIButton *)button
{
    [self.liftButton setBackgroundImage:[UIImage imageNamed:@"正在进行@2x.png"] forState:(UIControlStateNormal)];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"即将开启未选中@2x.png"] forState:(UIControlStateNormal)];
    self.myscrollView.contentOffset = CGPointMake(0, 0);
    
    
}

-(void)login:(UIButton *)button
{
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.myscrollView.contentOffset.x/kMainWidth == 0) {
        [self.liftButton setBackgroundImage:[UIImage imageNamed:@"正在进行@2x.png"] forState:(UIControlStateNormal)];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"即将开启未选中@2x.png"] forState:(UIControlStateNormal)];
        
        
        
    }else if (self.myscrollView.contentOffset.x/kMainWidth == 1){
        
        [self.liftButton setBackgroundImage:[UIImage imageNamed:@"正在进行未选中@2x.png"] forState:(UIControlStateNormal)];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"即将开启选中@2x.png"] forState:(UIControlStateNormal)];
        
        
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
