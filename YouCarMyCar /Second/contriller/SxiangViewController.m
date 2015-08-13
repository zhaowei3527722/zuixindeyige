//
//  SxiangViewController.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/1.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "SxiangViewController.h"
#import "PrefixHeader.pch"
#import "WqDetalTableViewCell.h"
#import "SureAddressViewController.h"
#import "LiftButtonViewController.h"
#import "RightButtonViewController.h"

#import "SpeckWqTableViewCell.h"


@interface SxiangViewController ()<UITableViewDataSource,UITableViewDelegate,WpDetalTableviewCellDelegate>

@end

@implementation SxiangViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"往期详细";
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight  - 64)];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:self.myTableView];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
    
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        static NSString *wpindext = @"wp";
        WqDetalTableViewCell *wqCell = [self.myTableView dequeueReusableCellWithIdentifier:wpindext];
        if (!wqCell) {
            wqCell = [[WqDetalTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:wpindext];
            
        }
        wqCell.selectionStyle = UITableViewCellSelectionStyleNone;
        wqCell.myGoodsNameLable.text = @"商品的名字 座椅";
        wqCell.myreportNumberLable .text = @"一共是100万份";
        wqCell.delegate = self;
        
        return wqCell;
        
        
    }else {
        static NSString *wpindext1 = @"wp1";
        SpeckWqTableViewCell *wqCell = [self.myTableView dequeueReusableCellWithIdentifier:wpindext1];
        if (!wqCell) {
            wqCell = [[SpeckWqTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:wpindext1];
            
        }
        
        
        wqCell.myToImageView.image = [UIImage imageNamed:@"2.png"];
        wqCell.myNameLable.text  = @"王老五";
        wqCell.myPriceLableJ.text = @"价格 哪里来的价格 不要钱好不";
        wqCell.myWeithtLableZ.text = @"质量 质量   很重";
        wqCell.myAspectLableW.text = @"一个字   就一个字";
        wqCell.myImageView.image = [UIImage imageNamed:@"2.png"];
        wqCell.selectionStyle = UITableViewCellSelectionStyleNone;
        wqCell.mySpeckXingNumberInteger = 2;
        
        
        
        return wqCell;
        
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        return 316 * kMainWidth / 320;
        
    }else{
        
        return 190;
    }
}
-(void)pop
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/// ============================== button ==== 点击事件 ==============
-(void)sureAddress:(UIButton *)button
{
    SureAddressViewController *suraddress = [[SureAddressViewController alloc]init];
    [self.navigationController pushViewController:suraddress animated:YES];
    
}
-(void)liftButton:(UIButton *)button
{
    LiftButtonViewController *lift = [[LiftButtonViewController alloc]init];
    [self.navigationController pushViewController:lift animated:YES];
    
}
-(void)rigthButton:(UIButton *)button
{
    RightButtonViewController *right = [[RightButtonViewController alloc]init];
    [self.navigationController pushViewController:right animated:YES];
    
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
