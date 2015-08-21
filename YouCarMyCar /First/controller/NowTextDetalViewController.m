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
#import <ShareSDK/ShareSDK.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "ForgetViewController.h"

#import "AFNetworking.h"


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
    
    UIButton *shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [shareButton setImage:[UIImage imageNamed:@"share@2x.png"] forState:(UIControlStateNormal)];
    shareButton.frame =CGRectMake(0, 0, 25, 30);
    [shareButton addTarget:self action:@selector(share) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rigth = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = rigth;

    
    
//
//
    [self coustom];
    // Do any additional setup after loading the view.
}


-(void)share
{
    //1.定制分享的内容
    NSString* path = [[NSBundle mainBundle]pathForResource:@"11" ofType:@"jpg"];
    
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];

    id<ISSContent> publishContent = [ShareSDK content:@"寻找中国可信赖的汽车用品”你车我车“，所有产品免费试用!" defaultContent:nil image:[ShareSDK imageWithPath:path] title:@" " url:@"http://www.nichewoche.com/downapk/" description:@"寻找中国可信赖的汽车用品”你车我车“，所有产品免费试用!" mediaType:SSPublishContentMediaTypeNews];
    
    

    
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
