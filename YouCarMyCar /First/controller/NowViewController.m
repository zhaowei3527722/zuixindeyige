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

@interface NowViewController ()<UITableViewDataSource,UITableViewDelegate,MylistFirstbleDelegate>
@property (nonatomic,strong)UITableView *mytable;

@end

@implementation NowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cuostom];//获取数据
    // Do any additional setup after loading the view.
    self.mytable = [[UITableView alloc]initWithFrame:CGRectMake(kMainX, kMainY, kMainWidth, kMainHeight-150)];
    self.mytable.delegate = self;
    self.mytable.dataSource = self;
    [self.view addSubview:self.mytable
     ];
    self.mytable.separatorStyle = UITableViewCellSeparatorStyleNone;

}
-(void)cuostom
{
    
    self.myArray = [[NSMutableArray alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=list&curpage=1&eachNum=5type=1",kMainHttp];
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
        
    }];

    
    
    
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
    NSLog(@"%ld",(long)aa);
    
    NowTextDetalViewController *detal = [[NowTextDetalViewController alloc]init];
    detal.iSbutton  = YES;

    [[super navigationController] pushViewController:detal animated:NO];
    detal.myModelnoW = self.myArray[aa];
    

    
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
