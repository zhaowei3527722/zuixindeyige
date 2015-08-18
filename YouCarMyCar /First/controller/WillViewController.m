//
//  WillViewController.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/1.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "WillViewController.h"
#import "PrefixHeader.pch"
#import "MyListFirstTableViewCell.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "NowViewModel.h"
#import "MJRefresh.h"

@interface WillViewController ()<UITableViewDataSource,UITableViewDelegate,MylistFirstbleDelegate>
@property (nonatomic,strong)UITableView *mytableview;
@property (nonatomic)NSInteger indextNumber;

@end
@implementation WillViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myArray = [[NSMutableArray alloc]init];

    self.mytableview = [[UITableView alloc]initWithFrame:CGRectMake(kMainX, kMainY, kMainWidth, kMainHeight-150)];
    self.mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
    [self.view addSubview:self.mytableview];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.mytableview.header = header;
    
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
    self.mytableview.footer = footer;
    

    
    
}
-(void)headerRefreshing//刷新
{
    self.indextNumber = 1;
    
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=list&curpage=1&eachNum=5type=3",kMainHttp];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        self.miao = [dat timeIntervalSince1970];
        
        
        
        NSMutableArray *array = [[responseObject valueForKey:@"datas"] valueForKey:@"list"];
        [self.myArray removeAllObjects];

        for (NSDictionary *dic in array) {
            NowViewModel *model = [[NowViewModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.myArray addObject:model];
            
            
        }
        
        [self.mytableview reloadData];//刷新;
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
        
    }];
    [self.mytableview.header endRefreshing];
    
    

}
//加载

-(void)footerRefreshing
{
    self.indextNumber ++;
    
    
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=list&curpage=%ld&eachNum=5type=3",kMainHttp,(long)self.indextNumber];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        self.miao = [dat timeIntervalSince1970];
        
        
        
        NSMutableArray *array = [[responseObject valueForKey:@"datas"] valueForKey:@"list"];
        for (NSDictionary *dic in array) {
            NowViewModel *model = [[NowViewModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.myArray addObject:model];
            
            
        }
        
        [self.mytableview reloadData];//刷新;
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
        
    }];

    [self.mytableview.footer endRefreshing];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.myArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    MyListFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MyListFirstTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifier];
      
        

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mybutton.tag = 100 + indexPath.row;
    cell.delegagate = self;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    [cell.mybutton setBackgroundImage:[UIImage imageNamed:@"jingqgz.png"] forState:(UIControlStateNormal)];
    
    
    cell.mytimeInteger = 1000 - (a - self.miao) ;
    NowViewModel *model = self.myArray[indexPath.row];
    cell.mydescritionLable.text = model.small_info;
    cell.myallGoodsCount.text = model.number;
    cell.mynowPerson.text = model.try_people;
    cell.myGoodName.text = model.title;
    [cell.myGoodImageVeiw sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    NSLog(@"--------------%@",model.img);
    
    
    return cell;
}

-(void)actionButton:(UIButton *)button
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
