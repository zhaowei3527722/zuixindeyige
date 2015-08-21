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
#import "MJRefresh.h"
#import "AllDeteModel.h"
#import <ShareSDK/ShareSDK.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "ForgetViewController.h"

#import "LoginViewController.h"

@interface SxiangViewController ()<UITableViewDataSource,UITableViewDelegate,WpDetalTableviewCellDelegate,SpeckDelegate>
@property (nonatomic)NSInteger indextnumber;//记录获取试用报告列表的 第几页
@property (nonatomic,strong)NSMutableArray *myArray;
@property (nonatomic,strong)AllDeteModel *myAllmodel;

@property (nonatomic)NSInteger miao;


@end

@implementation SxiangViewController


-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = YES;
    
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    if (([self.stringID isEqualToString:@""]||!(self.stringID))) {
        self.stringID = self.wangqiModel.myID;
        
    }
    
    
    self.myAllmodel  = [[AllDeteModel alloc]init];

    
    
    
    [self coustom];
    
    self.indextnumber = 1;
    self.myArray = [[NSMutableArray alloc]init];

    // Do any additional setup after loading the view.
    self.title = @"往期详情";
    
    
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
    
    UIButton *shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [shareButton setImage:[UIImage imageNamed:@"share@2x.png"] forState:(UIControlStateNormal)];
    shareButton.frame =CGRectMake(0, 0, 25, 30);
    [shareButton addTarget:self action:@selector(share) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rigth = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = rigth;
    
    
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight  - 64)];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:self.myTableView];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.myTableView.header = header;
    
    /////
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    
    // 设置文字
    //    [footer setTitle:@"加载更多.." forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载.." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多.." forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];
    
    // 设置footer
    self.myTableView.footer = footer;
    

    
    
}


-(void)share
{
    
    //1.定制分享的内容
    
    
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];
    

    NSString* path = [[NSBundle mainBundle]pathForResource:@"11" ofType:@"jpg"];
    id<ISSContent> publishContent = [ShareSDK content:@"寻找中国可信赖的汽车用品”你车我车“，所有产品免费试用!" defaultContent:nil image:[ShareSDK imageWithPath:path] title:@" " url:@"http://www.nichewoche.com/downapk/" description:@"寻找中国可信赖的汽车用品”你车我车“，所有产品免费试用!" mediaType:SSPublishContentMediaTypeNews];
    

    
    //2.调用分享菜单分享
    [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        //如果分享成功
        
        if (state == SSResponseStateSuccess) {
            NSLog(@"分享成功");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];

    
}

-(void)coustom
{
    NSString *key = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
    NSString *member_id =  [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=info&id=%@&key=%@&member_id=%@",kMainHttp,self.stringID,key,member_id];
    
    NSString *urlF8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",url);
    
    [manager GET:urlF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [self.myArray removeAllObjects];
        
        if (!([responseObject valueForKey:@"datas"] == [NSNull null])) {
            NSDictionary *dic = [responseObject valueForKey:@"datas"];
            [self.myAllmodel setValuesForKeysWithDictionary:dic];
            [self.myTableView reloadData];
            NSLog(@"%@",self.myAllmodel.big_img);
            NSDate* dat1 = [NSDate dateWithTimeIntervalSinceNow:0];
            self.miao = [dat1 timeIntervalSince1970];
            NSLog(@"%@",      self.myAllmodel.prize);
            
            
            [self.myTableView reloadData];
            
            
            NSLog(@"deat a= a= = =%@",self.myAllmodel.date);
            
        }
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求出问题了");
        
    }];
    
    
    [self.myTableView.header endRefreshing];
    

    
}
//获取数据 ==== 刷新
-(void)headerRefreshing
{
    
    self.indextnumber = 1;
    

    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=report&tryId=%@&curpage=1&eachNum=10",kMainHttp,self.wangqiModel.myID];
    
    NSLog(@"Try- id = %@",self.wangqiModel.myID);
    
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *array = [[responseObject valueForKey:@"datas"] valueForKey:@"list"];

        
        if (!([[responseObject valueForKey:@"datas"] valueForKey:@"list"] == [NSNull null])) {
            
            [self.myArray removeAllObjects];
            
            for (NSDictionary *dic in array) {
                TryReportModel *model = [[ TryReportModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                
                [self .myArray addObject:model];
                
                
                
            }

        }
        
        
        [self.myTableView  reloadData];//刷新;
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    [self.myTableView.header endRefreshing];
    
    
}
-(void)footerRefreshing
{
    self.indextnumber ++;
    
    
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
    
    [self.myTableView.footer endRefreshing];
    
    
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
        wqCell.myGoodsNameLable.text = self.myAllmodel.title;
        wqCell.myreportNumberLable .text = @"一共是100万份";
        wqCell.myGoodDescritionLable.text = self.myAllmodel.small_info;
        wqCell.myGoodNumberLable.text = self.myAllmodel.number;
        wqCell.myPeopleNumberLable.text = self.myAllmodel.try_people;
        [wqCell.mybigImageView  sd_setImageWithURL:[NSURL URLWithString:self.myAllmodel.big_img]];
        
        
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
        
        wqCell.myNameLable.text  = model.member_truename;
        wqCell.myPriceLableJ.text = model.price_info;
        wqCell.myWeithtLableZ.text = model.quality_info;
        wqCell.myAspectLableW.text = model.appearance_info;
        [wqCell.myImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
        wqCell.selectionStyle = UITableViewCellSelectionStyleNone;
        wqCell.mySpeckXingNumberInteger = 2;
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yy年MM月dd日 HH:mm"];
        
        
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[model.add_time integerValue]];
        
        
        NSString* dateString = [formatter stringFromDate:date];
        
        wqCell.myTimeLable.text = dateString;
        
        wqCell.myImageView.tag = indexPath.row +100;
        
        wqCell.delegate = self;
        
        wqCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return wqCell;
        
        
    }
    
    
}
-(void)tapta:(UITapGestureRecognizer *)tap
{
    

    UIImageView *imageview = (UIImageView *)tap.view;
  NSInteger aa =imageview.tag - 100-1;
    TryReportModel *model = self.myArray[aa];

  
    NSLog(@"%ld",(long)aa);
    
    self.myBigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -64, kMainWidth, kMainHeight )];
    
    [self.view addSubview:self.myBigImageView];
    [self.myBigImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.myBigImageView addGestureRecognizer:tap1];
    self.myBigImageView.userInteractionEnabled = YES;
    
    self.navigationController.navigationBar.hidden = YES;
    
    
}
-(void)tap
{
    
    self.navigationController.navigationBar.hidden = NO;

    [self.myBigImageView removeFromSuperview];
    
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
    [self.navigationController popViewControllerAnimated:YES];
}
/// ============================== button ==== 点击事件 ==============
-(void)sureAddress:(UIButton *)button
{
    
    
  NSString *key =[[NSUserDefaults standardUserDefaults]valueForKey:@"key"];
    
    if (!([key isEqualToString:@""])) {
        
        if ((NSInteger)(self.myAllmodel.presence) == 1 ) {
            
            SureAddressViewController *suraddress = [[SureAddressViewController alloc]init];
            [self.navigationController pushViewController:suraddress animated:YES];

            
        }else {
            UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您未申请此产品" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [ale show];

            
            
        }
        

    }else {
        
        
        UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您未登录" delegate:self cancelButtonTitle:@"马上登录" otherButtonTitles:@"取消", nil];
        ale.tag = 1005;
        
        [ale show];

        
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    
    if (alertView.tag == 1005) {
        if (buttonIndex == 0) {
            LoginViewController *login = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
            
        }else {
            
            
        }
    }
}

-(void)liftButton:(UIButton *)button
{
    LiftButtonViewController *lift = [[LiftButtonViewController alloc]init];
    lift.wangqiModel = self.wangqiModel;
    [self.navigationController pushViewController:lift animated:YES];

    NSString *key =[[NSUserDefaults standardUserDefaults]valueForKey:@"key"];
    
    if (!([key isEqualToString:@""])) {
        
        
        NSLog(@" ------------%@",self.myAllmodel.prize);
        
        if ((NSInteger)self.myAllmodel.prize  == 1) {
            
            LiftButtonViewController *lift = [[LiftButtonViewController alloc]init];
            lift.wangqiModel = self.wangqiModel;
            [self.navigationController pushViewController:lift animated:YES];

        }else {
            UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您未获奖" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [ale show];

            
        }
        
        
    }else {
        
        
        UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您未登录" delegate:self cancelButtonTitle:@"马上登录" otherButtonTitles:@"取消", nil];
        ale.tag = 1005;
        
        [ale show];
        
        
    }

}
-(void)rigthButton:(UIButton *)button
{
    RightButtonViewController *right = [[RightButtonViewController alloc]init];
    right.myModel = self.wangqiModel;
    
    
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
