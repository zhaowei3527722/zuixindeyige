

//
//  GoodDetalWQViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/8/15.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "GoodDetalWQViewController.h"

#import "DetaGoodLiftViewController.h"
#import "SpectGoodRigthViewController.h"

#define kseGmentHeight 40
#define kscrollViewH 104
#import "PrefixHeader.pch"
@interface GoodDetalWQViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)DetaGoodLiftViewController *liftGoodVC;
@property (nonatomic ,strong)SpectGoodRigthViewController *rigntSpeckVC;

@end

@implementation GoodDetalWQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品信息";
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    self.view.backgroundColor = COLOR(253, 246, 240, 1);

    [self coustom];
    
    // Do any additional setup after loading the view.
}

-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = NO;
    
    
}

-(void)coustom
{
    self.liftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.liftButton.frame =CGRectMake(0, 64, self.view.frame.size.width / 2 ,40);
    [self.liftButton setBackgroundImage:[UIImage imageNamed:@"正在进行@2x.png"] forState:(UIControlStateNormal)];
    [self.liftButton addTarget:self action:@selector(lift) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.liftButton];
    
    self.rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightButton.frame =CGRectMake(self.view.frame.size.width / 2, 64, self.view.frame.size.width / 2 ,40);
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"即将开启未选中@2x.png"] forState:(UIControlStateNormal)];
    [self.rightButton addTarget:self action:@selector(right) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.rightButton];
    
    
    
    
    
    //布局 UIScrollView
    self.myscrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kscrollViewH, kMainWidth , kMainHeight - kscrollViewH)];
    self.myscrollView.contentSize = CGSizeMake(kMainWidth * 2, 0);
    self.myscrollView.backgroundColor = [UIColor whiteColor];
    self.myscrollView.showsVerticalScrollIndicator = NO;
    self.myscrollView.showsVerticalScrollIndicator = NO;
    self.myscrollView.showsHorizontalScrollIndicator = NO;

    
    self.myscrollView.pagingEnabled = YES;
    self.myscrollView.delegate = self;
    [self.view addSubview:self.myscrollView];
    
    self.liftGoodVC = [[DetaGoodLiftViewController alloc]initWithModel:self.myModel];
    self.rigntSpeckVC = [[SpectGoodRigthViewController alloc]initWithModel:self.myModel];
    self.rigntSpeckVC.view.frame = CGRectMake(0, kMainY, kMainWidth, kMainHeight);
    self.rigntSpeckVC.view.frame = CGRectMake(kMainWidth, kMainY, kMainWidth, kMainHeight);
    
    [self addChildViewController:self.liftGoodVC];
    [self.myscrollView addSubview:self.liftGoodVC.view];
    [self addChildViewController:self.rigntSpeckVC];
    [self.myscrollView addSubview:self.rigntSpeckVC.view];

}
//点击事件

-(void)lift
{
    [self.liftButton setBackgroundImage:[UIImage imageNamed:@"正在进行@2x.png"] forState:(UIControlStateNormal)];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"即将开启未选中@2x.png"] forState:(UIControlStateNormal)];
    self.myscrollView.contentOffset = CGPointMake(0, 0);
    

    
}
-(void)right
{
    [self.liftButton setBackgroundImage:[UIImage imageNamed:@"正在进行未选中@2x.png"] forState:(UIControlStateNormal)];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"即将开启选中@2x.png"] forState:(UIControlStateNormal)];
    self.myscrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
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
