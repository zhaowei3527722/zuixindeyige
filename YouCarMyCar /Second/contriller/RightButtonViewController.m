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

@interface RightButtonViewController ()<UITableViewDataSource,UITableViewDelegate>

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
    
    
    [self coustom];//布局

    // Do any additional setup after loading the view.
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
    return 20;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indext = @"indext";
    RightListTableViewCell *cell = [self.myTableview dequeueReusableCellWithIdentifier:indext];   
    if (!cell) {
        cell = [[RightListTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:indext];
        
    }
    cell.myliftImageView .image = [UIImage imageNamed:@"2.png"];
    cell.myliftNameLable.text = @"name1";
    cell.myRightLable.text = @"name2";
    cell.myRightImageView.image = [UIImage imageNamed:@"2.png"];
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
