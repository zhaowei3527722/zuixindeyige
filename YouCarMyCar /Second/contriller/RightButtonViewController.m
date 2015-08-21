//
//  RightButtonViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/29.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "RightButtonViewController.h"

#import "PrefixHeader.pch"
#import "RightListTableViewCell.h"
#import "AFNetworking.h"
#import "RightModel.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface RightButtonViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)NSMutableArray *myArray;
@property (nonatomic)NSInteger indextnumber;


@end

@implementation RightButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myArray = [[NSMutableArray alloc]init];
    self.title = @"中奖名单";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    self.myTableview  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight)];
    
    self.myTableview.delegate = self;
    self.myTableview.dataSource  = self;
    [self.view addSubview:self.myTableview];
    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.myTableview.header = header;
    
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
    self.myTableview.footer = footer;

    // Do any additional setup after loading the view.
}
//获取 数据

-(void)headerRefreshing
{
    
    self.indextnumber = 1;
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager  alloc]init];
    
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=getWinning&try_id=%@&curpage=1&eachNum=100",kMainHttp,self.myModel.myID];
    NSString *urlF8 = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (![[responseObject valueForKey:@"datas"] valueForKey:@"error"]) {
            
            
            NSLog(@"%@",[responseObject valueForKey:@"list"]);
            
        
            
            
            if (!([responseObject valueForKey:@"list"]==[NSNull null]) ){

                
                NSArray *array = [responseObject valueForKey:@"list"];
                [self.myArray removeAllObjects];
                
                for (NSDictionary *dic in array) {
                    RightModel *model = [[RightModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.myArray addObject:model];
                }
                [self.myTableview reloadData];//刷新数据
                NSLog( @"count = %lu",(unsigned long)self.myArray.count);
                
            }
            
            
        }
        
        
        NSArray *array = [responseObject valueForKey:@"list"];
        
        [self.myArray removeAllObjects];
        
        for (NSDictionary *dic in array) {
            RightModel *model = [[RightModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.myArray addObject:model];
        }
        [self.myTableview reloadData];//刷新数据
        
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [self.myTableview.header endRefreshing];
    
    
}
-(void)footerRefreshing
{
    self.indextnumber ++;
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager  alloc]init];
    
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=getWinning&try_id=48&curpage=%ld&eachNum=100",kMainHttp,(long)self.indextnumber];
    NSString *urlF8 = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (![[responseObject valueForKey:@"datas"] valueForKey:@"error"]) {
            
            
            NSLog(@"%@",[responseObject valueForKey:@"list"]);
            
            
            
            
            if (!([responseObject valueForKey:@"list"]==[NSNull null]) ){
                
                
                NSArray *array = [responseObject valueForKey:@"list"];
                
                for (NSDictionary *dic in array) {
                    RightModel *model = [[RightModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.myArray addObject:model];
                }
                [self.myTableview reloadData];//刷新数据
                
                
            }
            
            
        }
        
        
        
        NSArray *array = [responseObject valueForKey:@"list"];
        
        for (NSDictionary *dic in array) {
            RightModel *model = [[RightModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.myArray addObject:model];
        }
        [self.myTableview reloadData];//刷新数据
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [self.myTableview.footer endRefreshing];

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.myArray.count == 1) {
        return 1;
        
    }else {
        
        
        return self.myArray.count / 2;
        
    }
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",indexPath.row * 2 );
    NSLog(@"%ld",indexPath.row *2 + 1);
    NSLog(@"%lu",(unsigned long)self.myArray.count);
    
    
    RightModel *model1 = self.myArray[indexPath.row * 2];
    static NSString *indext = @"indext";
    RightListTableViewCell *cell = [self.myTableview dequeueReusableCellWithIdentifier:indext];   
    if (!cell) {
        cell = [[RightListTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:indext];
        
    }
    
    
    [cell.myliftImageView  sd_setImageWithURL:[NSURL URLWithString:model1.member_avatar]];
    cell.myliftNameLable.text = model1.member_name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row *2 +1 > self.myArray.count - 1) {
        
    }else {
        
        RightModel *model2 = self.myArray[indexPath.row * 2 +1];
        
        cell.myRightLable.text = model2.member_name;
        [cell.myRightImageView sd_setImageWithURL:[NSURL URLWithString:model2.member_avatar]];
        
        
        
    }

    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
    
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
