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
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIView *whiteView;
@property (nonatomic,strong)UIButton *button1;
@property (nonatomic)BOOL isYes;



@end

@implementation NowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults ]valueForKey:@"tishi"]);

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
-(void)layoutTiShi
{
    self.isYes = YES;
    
    self.backView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.2;
    
    
    self.whiteView = [[UIView alloc]initWithFrame:CGRectMake(15, kMainHeight/2 - 90, kMainWidth - 30, 270)];
    self.whiteView.backgroundColor = MainBackGround;
    self.whiteView.layer.cornerRadius = 20;
    [self.view addSubview:self.whiteView];
    
    
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 30, 30)];
    imageView.image = [UIImage imageNamed:@"cup.png"];
    [self.whiteView addSubview:imageView];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(60, 25, self.whiteView.frame.size.width-90, 40)];
    lable1.text = @"我们在审核免费试用用户的时候会考虑这些:";
    lable1.font = [UIFont systemFontOfSize:13];
    lable1.numberOfLines = 0;
    [self.whiteView addSubview:lable1];
    
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 60, self.whiteView.frame.size.width - 100, 90)];
    lable2.text = @"1· 活跃在微博微信以及连续参加活动的用户\n2· 有详细精美的试用报告者\n3· 提出有价值建议反馈合创意的用户";
    lable2.font = [UIFont systemFontOfSize:12];
    lable2.numberOfLines = 0;
    lable2.textColor = [UIColor redColor];
    [self.whiteView addSubview:lable2];
    
    self.button1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.button1.frame = CGRectMake(50, 150, 20, 20);
    [self.button1 setImage:[UIImage imageNamed:@"未阅读.png"] forState:(UIControlStateNormal)];
    [self.button1 addTarget:self action:@selector(dianji) forControlEvents:(UIControlEventTouchUpInside)];
    [self.whiteView addSubview:self.button1];
    
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(80, 150, self.whiteView.frame.size.width - 120, 20)];
    lable3.text = @"以后不再提示";
    lable3.textColor = COLOR(100, 100, 100, 1);
    lable3.font = [UIFont systemFontOfSize:13];
    [self.whiteView addSubview:lable3];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    button.frame = CGRectMake(20, 190 , self.whiteView.frame.size.width - 40 , 40);
    [button setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景@2x.png"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(remove) forControlEvents:(UIControlEventTouchUpInside)];
    
    [button setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.whiteView addSubview:button];
    
}


-(void)dianji
{
    
    if (self.isYes == YES) {
        [self.button1 setImage:[UIImage imageNamed:@"已阅读.png"] forState:(UIControlStateNormal)];
        self.isYes = NO;
        
    }else if (self.isYes == NO) {
        [self.button1 setImage:[UIImage imageNamed:@"未阅读.png"] forState:(UIControlStateNormal)];
        self.isYes = YES;
    }
    
}

-(void)remove
{
    if (self.isYes == NO) {
        
        [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"tishi"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"tishi"]);
        [self.backView removeFromSuperview];
        [self.whiteView removeFromSuperview];
        
        NowTextDetalViewController *detal = [[NowTextDetalViewController alloc]init];
        detal.iSbutton  = YES;
        
        [[super navigationController] pushViewController:detal animated:NO];
        detal.myModelnoW = self.myArray[self.myarrayindext];
        [self loadNewData];

    }else{
        [self.backView removeFromSuperview];
        [self.whiteView removeFromSuperview];
    }
    
    
}



//刷新
-(void)loadNewData
{    self.indextnumber = 1;

//    act=try
//    •	op=list
//    •	curpage:第几页，默认1
//    •	eachNum:几条一页，默认10
//    •	type:类型（1最新、2往期,3 即将开始）
//    •	member_id 用户ID （选传）
//    •	key 登录令牌 （选传）
//
    
    NSString *key = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
    NSString *member_id =  [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=list&curpage=1&eachNum=5&type=1&member_id=%@&key=%@",kMainHttp,member_id,key];
    
    NSLog(@"- - --- --- --- -- - -%@",url);
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
    
    
    NSString *key = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
    NSString *member_id =  [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
    
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=list&curpage=%ld&eachNum=5&type=1&member_id=%@&key=%@",kMainHttp,(long)self.indextnumber,member_id,key];    NSLog(@"- - --- --- --- -- - -%@",url);
    
    
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
        
        [self.mytable reloadData];//刷新;
        //        [self.mytable headerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        //        [self.mytable headerEndRefreshing];
        
        
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
    NowViewModel *model = self.myArray[indexPath.row];

    NSInteger tim =  [model.date integerValue]*24*3600 + [model.hours integerValue]*3600+[model.minutes integerValue]*60 + [model.seconds integerValue];
    
    mycell.mytimeInteger = tim - (a - self.miao) ;
    mycell.mydescritionLable.text = model.small_info;
    mycell.myallGoodsCount.text = model.number;
    mycell.mynowPerson.text = model.try_people;
    mycell.myGoodName.text = model.title;
    [mycell.myGoodImageVeiw sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    if ([model.presence integerValue]== 1) {
        [mycell.mybutton setBackgroundImage:[UIImage imageNamed:@"免费试用dianji.png"] forState:(UIControlStateNormal)];

    }else {
        
        [mycell.mybutton setBackgroundImage:[UIImage imageNamed:@"免费试用@2x.png"] forState:(UIControlStateNormal)];
        
        
    }
    
    mycell.myNumberImageView.image = [UIImage imageNamed:@"qibiao@2x.png"];
    mycell.myNumberLable.text = model.period_no;
    
    
    
    return mycell;
    
}

-(void)actionButton:(UIButton *)button
{
    

    
    self.myarrayindext = button.tag - 100;
    
    NowViewModel *model = self.myArray[self.myarrayindext];
    
    if ([model.presence integerValue] == 1) {
        
    }else {
    
    NSString *member = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
    NSString *key = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
    

    if (key) {
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@?act=try&op=applyTry&member_id=%@&key=%@&try_id=%@",kMainHttp,member,key,model.myid]);
        NSString *url = [NSString stringWithFormat:@"%@?act=try&op=applyTry&member_id=%@&key=%@&try_id=%@",kMainHttp,member,key,model.myid];
        NSString *urlF8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        [manager GET:urlF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            if ([[responseObject valueForKey:@"datas"] valueForKey:@"error"]) {
                
                UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:[[responseObject valueForKey:@"datas"] valueForKey:@"error"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [ale show];
                
                
            }else {
                
                
                
                
                if ([([[NSUserDefaults standardUserDefaults] valueForKey:@"tishi"] )isEqualToString:@"0"]) {
                    
                    
                    [self.view addSubview:self.backView];
                    [self.view addSubview:self.whiteView];
                    

                }else {

                NowTextDetalViewController *detal = [[NowTextDetalViewController alloc]init];
                detal.iSbutton  = YES;
                
                [[super navigationController] pushViewController:detal animated:NO];
                detal.myModelnoW = self.myArray[self.myarrayindext];
                [self loadNewData];
                }

            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
        }];
        
        

    }else  {
        
        
        UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未登陆" delegate:self cancelButtonTitle:@"马上登录" otherButtonTitles:@"取消", nil];
        [ale show];
        
        
        
    }
    }
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        

    }
    
    
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
