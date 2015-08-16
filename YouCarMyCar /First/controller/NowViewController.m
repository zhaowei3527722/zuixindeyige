//
//  NowViewController.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/1.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "NowViewController.h"
#import "PrefixHeader.pch"
#import "MyListFirstTableViewCell.h"
#import "NowTextDetalViewController.h"
#import "NowViewModel.h"
#import "TsGoodViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"

#import "MJRefresh.h"
@interface NowViewController ()<UITableViewDataSource,UITableViewDelegate,MylistFirstbleDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UITableView *mytable;
@property (nonatomic )NSInteger indextnumber;


@end

@implementation NowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.mytable = [[UITableView alloc]initWithFrame:CGRectMake(kMainX, kMainY, kMainWidth, kMainHeight-150)];
    self.mytable.delegate = self;
    self.mytable.dataSource = self;
    [self.view addSubview:self.mytable
     ];
    self.mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.myArray = [NSMutableArray array];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.mytable.header = header;
    
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
    self.mytable.footer = footer;
    


}



//刷新
-(void)loadNewData
{    self.indextnumber = 1;

    
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=list&curpage=1&eachNum=5type=1",kMainHttp];
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
        
        [self.mytable reloadData];//刷新;
//        [self.mytable headerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
//        [self.mytable headerEndRefreshing];

        
    }];
    
    [self.mytable.header endRefreshing];
    
    
    
}
//加载
-(void)footerRefreshing
{
    
    self.indextnumber ++;
    
    
    
    NSLog(@" = = = = == = ==%ld",(long)self.indextnumber);
    
    
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=list&curpage=%ld&eachNum=5type=1",kMainHttp,(long)self.indextnumber];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if (!([[responseObject valueForKey:@"datas"] valueForKey:@"error"])) {
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            self.miao = [dat timeIntervalSince1970];
            NSMutableArray *array = [[responseObject valueForKey:@"datas"] valueForKey:@"list"];
            for (NSDictionary *dic in array) {
                NowViewModel *model = [[NowViewModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.myArray addObject:model];
                
            }
            
            [self.mytable reloadData];//刷新;

        }
        
//        [self.mytable footerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
//        [self.mytable footerEndRefreshing];

        
    }];
    
    [self.mytable.footer endRefreshing];
    
    
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
    
    
    static NSString *cell = @"index";
    MyListFirstTableViewCell *mycell = [self.mytable dequeueReusableCellWithIdentifier:cell];
    
    
    if (!mycell) {
        
        mycell = [[MyListFirstTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cell];
        mycell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    mycell.mybutton.tag = 100 + indexPath.row;
    mycell.delegagate = self;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    mycell.mytimeInteger = 1000 - (a - self.miao) ;
    NowViewModel *model = self.myArray[indexPath.row];
    mycell.mydescritionLable.text = model.small_info;
    mycell.myallGoodsCount.text = model.number;
    mycell.mynowPerson.text = model.try_people;
    mycell.myGoodName.text = model.title;
    [mycell.myGoodImageVeiw sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    return mycell;
    
}

-(void)actionButton:(UIButton *)button
{
    NSInteger aa = button.tag - 100;
    
    NowViewModel *model = self.myArray[aa];
    NSString *member = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];

    if (!([[[NSUserDefaults standardUserDefaults] valueForKey:@"key"] isEqualToString:@""])) {
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        
        
        [manager GET:[NSString stringWithFormat:@"%@?act=try&op=applyTry&member_id=%@&try_id=%@",kMainHttp,member,model.myid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NowTextDetalViewController *detal = [[NowTextDetalViewController alloc]init];
            detal.iSbutton  = YES;
            
            [[super navigationController] pushViewController:detal animated:NO];
            detal.myModelnoW = self.myArray[aa];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
        }];
        
        

    }else  {
        
        
        UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [ale show];
        
        
        
    }
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NowTextDetalViewController *detal = [[NowTextDetalViewController alloc]init];
    detal.iSbutton = NO;
    
    [self.navigationController pushViewController:detal animated:YES];
    detal.myModelnoW = self.myArray[indexPath.row];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
