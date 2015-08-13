//
//  NowTextDetalViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/27.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "NowTextDetalViewController.h"

#import "PrefixHeader.pch"
#import "GoodDetalTableViewController.h"
#import "SpeckTableViewController.h"
#import "UIImageView+WebCache.h"
#import "TsGoodViewController.h"


@interface NowTextDetalViewController ()<UIScrollViewDelegate,GoodDetalTableviewDelegate,SpeckTableviewDelegate>
@property (nonatomic ,strong)GoodDetalTableViewController *nowVC;
@property (nonatomic ,strong)SpeckTableViewController *willVC;

@end

@implementation NowTextDetalViewController



- (void)viewDidLoad {
    
    
    if (self.iSbutton) {
        TsGoodViewController *ts = [[TsGoodViewController  alloc]init];
        [self.navigationController pushViewController:ts animated:NO];
        
        
    }

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品详情";
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    self.view.backgroundColor = COLOR(253, 246, 240, 1);
//
//
    [self coustom];
    // Do any additional setup after loading the view.
}




-(void)coustom
{
    self.myscrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kMainWidth * 2, kMainHeight - 44)];
    self.myscrollView.contentSize = CGSizeMake(kMainWidth * 2, 0);
    self.myscrollView.showsVerticalScrollIndicator = NO;
    self.myscrollView.showsVerticalScrollIndicator = NO;
    self.myscrollView.pagingEnabled = YES;
    self.myscrollView.delegate = self;
    [self.view addSubview:self.myscrollView];
    self.myscrollView.showsVerticalScrollIndicator = FALSE;
    self.myscrollView.showsHorizontalScrollIndicator = FALSE;
    self.myscrollView.backgroundColor =[UIColor redColor];
    self.myscrollView.bounces = NO;
    
    
//    
    self.nowVC = [[GoodDetalTableViewController alloc]initWithModel:self.myModelnoW];
    self.willVC = [[SpeckTableViewController alloc]initWithModel:self.myModelnoW];
    self.nowVC.tableView.frame = CGRectMake(0, -64, kMainWidth, kMainHeight - 64 -44);
    self.willVC.tableView.frame = CGRectMake(kMainWidth, -64, kMainWidth, kMainHeight - 64 - 44);
    self.nowVC.delegate = self;
    self.willVC.delegate = self;
    
    
    [self addChildViewController:self.nowVC];
    [self.myscrollView addSubview:self.nowVC.tableView];
    
    
    [self addChildViewController:self.willVC];
    [self.myscrollView addSubview:self.willVC.tableView];
    
}
-(void)lightButtonAction:(UIButton *)button
{
    [UIView beginAnimations:@"animat" context:nil];
    //设置时间
    [UIView setAnimationDuration:0.5f];
    self.myscrollView.transform = CGAffineTransformMakeTranslation(0, 0);
    self.myscrollView.transform = CGAffineTransformScale(self.myscrollView.transform, 1.01, 1.01);
    [UIView commitAnimations];
    
    
    
}
-(void)ringhtButtonAction:(UIButton *)button
{
    [UIView beginAnimations:@"animat" context:nil];
    //设置时间
    [UIView setAnimationDuration:0.5f];
    self.myscrollView.transform = CGAffineTransformMakeTranslation(-kMainWidth, 0);
    self.myscrollView.transform = CGAffineTransformScale(self.myscrollView.transform, 1.01, 1.01);
    [UIView commitAnimations];
    
    
    
}
-(void)speckButtonAction:(UIButton *)button
{
    NSLog(@"评论");
    
    
}
-(void)pop
{
    [UIView beginAnimations:@"animat" context:nil];
    //设置时间
    [UIView setAnimationDuration:0];
    self.myscrollView.transform = CGAffineTransformMakeTranslation(0, 0);
    self.myscrollView.transform = CGAffineTransformScale(self.myscrollView.transform, 1.01, 1.01);
    [UIView commitAnimations];
    

    
    
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
