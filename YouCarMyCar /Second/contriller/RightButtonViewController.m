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

#import "UIImageView+WebCache.h"

@interface RightButtonViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)NSMutableArray *myArray;

@end

@implementation RightButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"中奖名单";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
    
    [self coustom1];//获取数据
    
    [self coustom];//布局

    // Do any additional setup after loading the view.
}
//获取 数据

-(void)coustom1
{/*	请求参数：
  •	act=try
  •	op=getWinning
  •	try_id 试用产品ID
  •	curpage:第几页，
  •	eachNum:几条一页
  •	返回数据：
  •	Page totalPage  总页数
  •	list 用户列表（数组）
  •	member_name 昵称
  •	member _avatar 头像*/
    
    self.myArray = [[NSMutableArray alloc]init];
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager  alloc]init];
    
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=getWinning&try_id=%@&curpage=1&eachNum=100",kMainHttp,self.myModel.myID];
    NSString *urlF8 = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *array = [responseObject valueForKey:@"list"];
        
        for (NSDictionary *dic in array) {
            RightModel *model = [[RightModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.myArray addObject:model];
        }
        [self.myTableview reloadData];//刷新数据
        
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}

-(void)coustom
{
    self.myTableview  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight)];
    
    self.myTableview.delegate = self;
    self.myTableview.dataSource  = self;
    [self.view addSubview:self.myTableview];
    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myArray.count / 2;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",indexPath.row * 2 );
    NSLog(@"%ld",indexPath.row *2 + 1);
    
    
    
    RightModel *model1 = self.myArray[indexPath.row * 2];
    RightModel *model2 = self.myArray[indexPath.row * 2 +1];
    
    static NSString *indext = @"indext";
    RightListTableViewCell *cell = [self.myTableview dequeueReusableCellWithIdentifier:indext];   
    if (!cell) {
        cell = [[RightListTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:indext];
        
    }
    
    
    [cell.myliftImageView  sd_setImageWithURL:[NSURL URLWithString:model1.member_avatar]];
    cell.myliftNameLable.text = model1.member_name;
    cell.myRightLable.text = model2.member_name;
    [cell.myRightImageView sd_setImageWithURL:[NSURL URLWithString:model2.member_avatar]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
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
