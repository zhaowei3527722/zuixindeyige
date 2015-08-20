//
//  SpectGoodRigthViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/8/15.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "SpectGoodRigthViewController.h"

#import "PrefixHeader.pch"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "SpeckModel.h"
#import "ZWTextView.h"
#import "SpeckTableViewCell.h"

#import "MJRefresh.h"

#import "LoginViewController.h"
@interface SpectGoodRigthViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *myArray;
@property (nonatomic,strong)UITableView *mytableView;
@property (nonatomic ,strong)ZWTextView *mytextvie;
@property (nonatomic ,strong)UIView *myView;
@property (nonatomic,strong)UIButton *myspeckButton;
@property (nonatomic )NSInteger indextnumber;


@end

@implementation SpectGoodRigthViewController
-(id)initWithModel:(WangQiModel *)model

{
    
    if ([super init]) {
        
        self.mymodel= model;
        
        
    }
    return self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myArray = [[NSMutableArray alloc]init];

    self.mytableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.mytableView];
    self.mytableView.delegate = self;
    self.mytableView.dataSource = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.mytableView.header = header;
    
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
    self.mytableView.footer = footer;
    
    
}
-(void)headerRefreshing
{
    
    self.indextnumber = 1;
    
    NSLog(@" = == myid = %@",self.mymodel.myID);
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=getComment&tryId=%@curpage=1eachNum=100",kMainHttp,self.mymodel.myID];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if (![[responseObject valueForKey:@"datas"] valueForKey:@"error"] ) {
            
            
//            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//            self.miao = [dat timeIntervalSince1970];
                    NSMutableArray *array = [[responseObject valueForKey:@"datas"] valueForKey:@"list"];
            [self.myArray removeAllObjects];
            
            for (NSDictionary *dic in array) {
                SpeckModel *model = [[SpeckModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.myArray addObject:model];
                
            }
            
            [self.mytableView reloadData];//刷新;
            
            
        }else {
            
            NSLog(@"%@",[[responseObject valueForKey:@"datas"] valueForKey:@"error"]);
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
        
    }];
    
    [self.mytableView.header endRefreshing];
    
    

}
-(void)footerRefreshing
{
    NSLog(@" = == myid = %@",self.mymodel.myID);
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=getComment&tryId=%@curpage=%ldeachNum=100",kMainHttp,self.mymodel.myID,(long)self.indextnumber];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if (![[responseObject valueForKey:@"datas"] valueForKey:@"error"] ) {
            
            
            //            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            //            self.miao = [dat timeIntervalSince1970];
            NSMutableArray *array = [[responseObject valueForKey:@"datas"] valueForKey:@"list"];
            for (NSDictionary *dic in array) {
                SpeckModel *model = [[SpeckModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.myArray addObject:model];
                
            }
            
            [self.mytableView reloadData];//刷新;
            
            
        }else {
            
            NSLog(@"%@",[[responseObject valueForKey:@"datas"] valueForKey:@"error"]);
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
        
    }];
    
    [self.mytableView.footer endRefreshing];
    
    
    

}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.myArray.count;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpeckModel *model = self.myArray[indexPath.row];
    
    
    static NSString *indext = @"indext";
    SpeckTableViewCell *cell = [self.mytableView dequeueReusableCellWithIdentifier:indext];
    if (!cell ) {
        cell = [[SpeckTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:indext];
        
    }
    
    cell.myNameLable.text = model.member_truename;
    cell.mySpeckLable.text = model.content;
    [cell.myPersonTimageView sd_setImageWithURL:[NSURL URLWithString:model.member_avatar]];
    cell.myNameLable.textColor = [UIColor brownColor];
    cell.myPersonTimageView .layer.cornerRadius = 15;
    cell.myPersonTimageView.layer.masksToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yy年MM月dd日 HH:mm"];
    
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[model.add_time integerValue]];
    
    
    NSString* dateString = [formatter stringFromDate:date];
    
    
    NSLog(@"format dateString:%@",dateString);
    
    cell.mytimeLable.text = dateString;

    
    return cell;
    
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 90)];
    
    
    self.mytextvie = [[ZWTextView alloc]initWithFrame:CGRectMake(10, 15, kMainWidth - 90, 60)];
    
    
    [self.myView addSubview:self.mytextvie];
    self.myView.backgroundColor = [UIColor whiteColor];
    self.mytextvie.backgroundColor = COLOR(233, 233, 233, 1);
    self.mytextvie.placeholder = @"请在这里输入您想说的话...";
    
    
    self.myspeckButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.myspeckButton.frame = CGRectMake(kMainWidth - 70, 15, 60, 60);
    [self.myspeckButton setBackgroundImage:[UIImage imageNamed:@"发表@2x.png"] forState:(UIControlStateNormal)];
    [self.myspeckButton addTarget:self action:@selector(myspeckButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [self.myView addSubview:self.myspeckButton];
    return self.myView;
    

}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90;
    
}
-(void)myspeckButton:(UIButton *)button;
{
   
    
    
    
    NSString *member_id = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
    NSString *key = [[NSUserDefaults standardUserDefaults]valueForKey:@"key"];
    //    NSLog(@" =%@ ,=  %@ =%@ =key = %@",member_id,self.mymodel.myID,self.myTextView.text,key);
    
    
    if (![key isEqualToString:@""]) {
        
        
        if (!([self.mytextvie.text isEqualToString:@""])) {
            NSString *url = [NSString stringWithFormat:@"%@?act=try&op=subComment&content=%@&member_id=%@&key=%@&try_id=%@",kMainHttp,self.mytextvie.text,member_id,key,self.mymodel.myID];
            AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
            
            NSString *utf8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [manager GET:utf8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"----%@",[[responseObject valueForKey:@"datas"] valueForKey:@"status"]);
                
                if ([[responseObject valueForKey:@"datas"] valueForKey:@"status"]) {
                    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"评论成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [al show];
                    
                }
                
                [self.mytableView.header beginRefreshing];
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"%@",error);
                
                
            }];
            
            
            
        }
        
        
        
        UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"评论内容不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [ale show];
        
        
        
        
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

-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = YES;
    
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
