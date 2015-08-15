//
//  DetaGoodLiftViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/8/15.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "DetaGoodLiftViewController.h"
#import "GoodTableTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"
#import "AllDeteModel.h"

@interface DetaGoodLiftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)WangQiModel *mymodel;
@property (nonatomic ,strong)UITableView *mytableView;
@property (nonatomic,strong)NSMutableArray *myArray;
@property (nonatomic,strong)AllDeteModel *myAllDetallModel;




@end

@implementation DetaGoodLiftViewController

-(id)initWithModel:(WangQiModel *)model

{
    
    if ([super init]) {
        
        self.mymodel = model;
        [self coustom];//获取数据

        
    }
    return self;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.mytableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.mytableView];
    self.mytableView.delegate = self;
    self.mytableView.dataSource = self;
    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // Do any additional setup after loading the view.
}
//获取数据

-(void)coustom
{
    /*请求参数：
     •	act=try
     •	op=info
     •	id：产品ID
     •	返回数据：
    
*/
    
    self.myArray = [NSMutableArray array];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=info&id=%@",kMainHttp,self.mymodel.myID];
    NSString *urlF8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager GET:urlF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        
        if (!([responseObject valueForKey:@"datas"] == [NSNull null])) {
            NSDictionary *dic = [responseObject valueForKey:@"datas"];
            self.myAllDetallModel  = [[AllDeteModel alloc]init];
            [self.myAllDetallModel setValuesForKeysWithDictionary:dic];
            [self.myArray addObject:self.myAllDetallModel];
            
            [self.mytableView reloadData];
            
            NSLog(@"%@",self.myAllDetallModel.big_img);
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求出问题了");
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indext = @"indext";
    
    GoodTableTableViewCell *cell = [self.mytableView dequeueReusableCellWithIdentifier:indext];
    if (!cell) {
        cell = [[GoodTableTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:indext];
        
        NSLog(@" image = %@"  ,  self.myAllDetallModel.big_img);
        
        
        [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:self.myAllDetallModel.big_img]];
        
        
        
    }
    
    return cell;
    
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
