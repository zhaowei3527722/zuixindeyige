
//
//  TsGoodViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/8/10.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "TsGoodViewController.h"
#import "PrefixHeader.pch"

@interface TsGoodViewController ()

@end

@implementation TsGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    self.view.backgroundColor = MainBackGround;
    
    [self coustom];
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)coustom

{
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(kMainWidth / 2 - 45, 100, 90, 90)];
    imageview.image = [UIImage imageNamed:@"check@2x(1).png"];
    [self.view addSubview:imageview];
    
    
    UIImageView *smallImaage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 210, 35, 35)];
    smallImaage.image = [UIImage imageNamed:@"bulbs@2x(1).png"];
    [self.view addSubview:smallImaage];
    
    
    
    UILabel *lible = [[UILabel alloc]initWithFrame:CGRectMake(55, 210, 220, 50)];
    lible.text = @"成功参与“你车我车”免费试用活动";
    lible.numberOfLines = 2;
    
    
    [self.view addSubview:lible];
    
    
    UILabel *lible1 = [[UILabel alloc]initWithFrame:CGRectMake(55, 270, 220, 50)];
    lible1.text = @"关注微信公众账号“你车我车”并积极参与活动不仅可以提高中奖率，还能第一时间查看中奖名单 ！";
    lible1.numberOfLines = 0;
    
    
    [self.view addSubview:lible1];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    button.frame = CGRectMake(kMainWidth/2 - 120, 335, 240, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景@2x.png"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    
    [button setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    
    
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
