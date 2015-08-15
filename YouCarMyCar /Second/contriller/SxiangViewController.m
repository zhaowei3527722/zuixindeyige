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
#import "TryReportModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "GoodDetalWQViewController.h"

@interface SxiangViewController ()<UITableViewDataSource,UITableViewDelegate,WpDetalTableviewCellDelegate>
@property (nonatomic)NSInteger indextnumber;//记录获取试用报告列表的 第几页
@property (nonatomic,strong)NSMutableArray *myArray;

@end

@implementation SxiangViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.indextnumber = 1;

    // Do any additional setup after loading the view.
    self.title = @"往期详情";
    
    [self coustom];//获取数据;
    
    
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
    
    
}//获取数据

-(void)coustom
{
    
    self.myArray = [[NSMutableArray alloc]init];
    
    
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=report&tryId=%@&curpage=%ld&eachNum=10",kMainHttp,self.wangqiModel.myID,(long)self.indextnumber];
    
    NSLog(@"Try- id = %@",self.wangqiModel.myID);
    
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *array = [[responseObject valueForKey:@"datas"] valueForKey:@"list"];

        
        if (!([[responseObject valueForKey:@"datas"] valueForKey:@"list"] == [NSNull null])) {
            
            for (NSDictionary *dic in array) {
                TryReportModel *model = [[ TryReportModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                
                [self .myArray addObject:model];
                
                
                
            }

        }
        
        
        [self.myTableView  reloadData];//刷新;
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.myArray.count + 1;
    
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
        wqCell.myGoodsNameLable.text = self.wangqiModel.title;
//        wqCell.myGoodDescritionLable.text = self.wangqiModel.
        wqCell.myreportNumberLable .text = @"一共是100万份";
        wqCell.delegate = self;
        
        return wqCell;
        
        
    }else {
        static NSString *wpindext1 = @"wp1";
        SpeckWqTableViewCell *wqCell = [self.myTableView dequeueReusableCellWithIdentifier:wpindext1];
        if (!wqCell) {
            wqCell = [[SpeckWqTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:wpindext1];
            
        }
        TryReportModel *model = self.myArray[indexPath.row -1];
        
        
        [wqCell.myToImageView sd_setImageWithURL:[NSURL URLWithString:model.member_avatar]];
        
        wqCell.myNameLable.text  = model.member_name;
        wqCell.myPriceLableJ.text = model.price_info;
        wqCell.myWeithtLableZ.text = model.quality_info;
        wqCell.myAspectLableW.text = model.appearance_info;
        [wqCell.myImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
        wqCell.selectionStyle = UITableViewCellSelectionStyleNone;
        wqCell.mySpeckXingNumberInteger = 2;
        
        
        
        return wqCell;
        
        
    }
    
    
}


//进入详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        
        GoodDetalWQViewController *goodVC = [[GoodDetalWQViewController alloc]init];
        goodVC.myModel = self.wangqiModel;
        
        [self.navigationController pushViewController:goodVC animated:YES];

        
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
    lift.wangqiModel = self.wangqiModel;
    [self.navigationController pushViewController:lift animated:YES];
    
}
-(void)rigthButton:(UIButton *)button
{
    RightButtonViewController *right = [[RightButtonViewController alloc]init];
    right.myModel = self.wangqiModel;
    
    
    [self.navigationController pushViewController:right animated:YES];
    
}
-(void)goodDescription
{
    
    
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
