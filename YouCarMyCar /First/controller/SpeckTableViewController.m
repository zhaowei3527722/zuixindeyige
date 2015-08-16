//
//  SpeckTableViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/27.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "SpeckTableViewController.h"
#import "PrefixHeader.pch"
#import "SpeckTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "TsGoodViewController.h"
#import "SpeckModel.h"
#import "LoginViewController.h"
#import "MJRefresh.h"

@interface SpeckTableViewController ()<MylistFirstbleDelegate,UIAlertViewDelegate>
@property (nonatomic ,strong)NowViewModel *myModelnow;
@property (nonatomic ,strong)NSMutableArray *myArray;
@property (nonatomic )CGFloat miao;


@property (nonatomic)NSInteger indextnumber;


@end

@implementation SpeckTableViewController
-(id)initWithModel:(NowViewModel *)model

{
    
    if ([super init]) {
        
        self.myModelnow = model;
        
        
    }
    return self;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.header = header;
    
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
    self.tableView.footer = footer;
    

    
}
-(void)headerRefreshing
{
    
    self.indextnumber = 1;

    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=getComment&tryId=%@curpage=1eachNum=5",kMainHttp,self.myModelnow];
    NSString *urlF8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    [manager GET:urlF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        
        if (![[responseObject valueForKey:@"datas"] valueForKey:@"error"] ) {
            
            
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            self.miao = [dat timeIntervalSince1970];
            NSMutableArray *array = [[responseObject valueForKey:@"datas"] valueForKey:@"list"];
            [self.myArray removeAllObjects];

            for (NSDictionary *dic in array) {
                SpeckModel *model = [[SpeckModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.myArray addObject:model];
                
            }
            
            [self.tableView reloadData];//刷新;
            
            
            
        }else {
            
            NSLog(@"%@",[[responseObject valueForKey:@"datas"] valueForKey:@"error"]);
            
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
        
    }];
    
    [self.tableView.header endRefreshing];
    
    
}
-(void)footerRefreshing
{
    self.indextnumber ++;
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=getComment&tryId=%@curpage=%ldeachNum=5",kMainHttp,self.myModelnow.myid,(long)self.indextnumber];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        
        if (![[responseObject valueForKey:@"datas"] valueForKey:@"error"] ) {
            
            
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            self.miao = [dat timeIntervalSince1970];
            NSMutableArray *array = [[responseObject valueForKey:@"datas"] valueForKey:@"list"];
            for (NSDictionary *dic in array) {
                SpeckModel *model = [[SpeckModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.myArray addObject:model];
                
            }
            
            [self.tableView reloadData];//刷新;
            
            
            
        }else {
            
            NSLog(@"%@",[[responseObject valueForKey:@"datas"] valueForKey:@"error"]);
            
        
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
        
    }];
    
    [self.tableView.footer endRefreshing];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    
    if (buttonIndex == 0) {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        
    }
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    
    if (section == 1) {
        return 100;
        
    }else {
        
        
        return 0;
        
    }
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (kMainHeight == 480) {
        if (section == 1) {
            self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 200)];
            self.myView.backgroundColor = COLOR(253, 246, 240, 1);
            
            self.myliftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myliftButton.frame = CGRectMake(0, 0, 80, 30);
            
            [self.myliftButton setBackgroundImage:[UIImage imageNamed:@"产品详情未选中@2x.png"] forState:(UIControlStateNormal)];
            [self.myliftButton addTarget:self action:@selector(myliftButton:) forControlEvents:(UIControlEventTouchUpInside)];
            
            
            
            [self.myView addSubview:self.myliftButton];
            
            self.myRignth = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myRignth.frame = CGRectMake(80, 0, 80, 30);
            
            [self.myRignth setBackgroundImage:[UIImage imageNamed:@"参与评论@2x(1).png"] forState:(UIControlStateNormal)];
            [self.myView addSubview:self.myRignth];
            
            
            
            
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, kMainWidth - 30, 15)];
            lable.text = @"小提示:积极参与用户活动与反馈用户使用报告,及可提高免费试用的成功率!";
            
            lable.textColor = [UIColor redColor];
            lable.font = [UIFont systemFontOfSize:8];
            [self.myView addSubview:lable];
            
            
            
            self.myTextView = [[ZWTextView alloc]initWithFrame:CGRectMake(10, 50, kMainWidth - 80, 50)];
            
            
            [self.myView addSubview:self.myTextView];
            self.myTextView.backgroundColor = COLOR(233, 233, 233, 1);
            self.myTextView.placeholder = @"请在这里输入您想说的话...";
            
            
            self.myspeckButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myspeckButton.frame = CGRectMake(kMainWidth - 60, 50, 50, 50);
            [self.myspeckButton setBackgroundImage:[UIImage imageNamed:@"发表@2x.png"] forState:(UIControlStateNormal)];
            [self.myspeckButton addTarget:self action:@selector(myspeckButton:) forControlEvents:(UIControlEventTouchUpInside)];
            
            
            [self.myView addSubview:self.myspeckButton];
            
            
            return self.myView;
            
            
        }
        
        return nil;

    }else {
        if (section == 1) {
            self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 200)];
            self.myView.backgroundColor = COLOR(253, 246, 240, 1);
            
            self.myliftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myliftButton.frame = CGRectMake(0, 0, 100, 40);
            
            [self.myliftButton setBackgroundImage:[UIImage imageNamed:@"产品详情未选中@2x.png"] forState:(UIControlStateNormal)];
            [self.myliftButton addTarget:self action:@selector(myliftButton:) forControlEvents:(UIControlEventTouchUpInside)];
            
            
            
            [self.myView addSubview:self.myliftButton];
            
            self.myRignth = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myRignth.frame = CGRectMake(100, 0, 100, 40);
            
            [self.myRignth setBackgroundImage:[UIImage imageNamed:@"参与评论@2x(1).png"] forState:(UIControlStateNormal)];
            [self.myView addSubview:self.myRignth];
            
            
            
            
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, kMainWidth - 30, 15)];
            lable.text = @"小提示:积极参与用户活动与反馈用户使用报告,及可提高免费试用的成功率!";
            
            lable.textColor = [UIColor redColor];
            lable.font = [UIFont systemFontOfSize:8];
            [self.myView addSubview:lable];
            
            
            
            self.myTextView = [[ZWTextView alloc]initWithFrame:CGRectMake(10, 60, kMainWidth - 80, 50)];
            
            
            [self.myView addSubview:self.myTextView];
            self.myTextView.backgroundColor = COLOR(233, 233, 233, 1);
            self.myTextView.placeholder = @"请在这里输入您想说的话...";
            
            
            self.myspeckButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myspeckButton.frame = CGRectMake(kMainWidth - 60, 60, 50, 50);
            [self.myspeckButton setBackgroundImage:[UIImage imageNamed:@"发表@2x.png"] forState:(UIControlStateNormal)];
            [self.myspeckButton addTarget:self action:@selector(myspeckButton:) forControlEvents:(UIControlEventTouchUpInside)];
            
            
            [self.myView addSubview:self.myspeckButton];
            
            
            return self.myView;
            
            
        }
        
        return nil;

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)myspeckButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(speckButtonAction:content:)]) {
        [self.delegate speckButtonAction:button content:self.myTextView.text];
        
    }

    
    
}
-(void)myliftButton:(UIButton *)button
{
    
    if ([self.delegate respondsToSelector:@selector(lightButtonAction:)]) {
        [self.delegate lightButtonAction:button];
        
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    
    if (section == 0) {
        return 1;
        
    }else {
        
        return self.myArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cell = @"index";
        MyListFirstTableViewCell *mycell = [self.tableView dequeueReusableCellWithIdentifier:cell];
        
        
        if (!mycell) {
            
            mycell = [[MyListFirstTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cell];
            mycell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
        }
        mycell.delegagate = self;
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a = [dat timeIntervalSince1970];
        mycell.mytimeInteger = 1000- (a - self.miao) ;
        mycell.mydescritionLable.text = self.myModelnow.small_info;
        mycell.myallGoodsCount.text = self.myModelnow.number;
        mycell.mynowPerson.text = self.myModelnow.try_people;
        mycell.myGoodName.text = self.myModelnow.title;
        [mycell.myGoodImageVeiw sd_setImageWithURL:[NSURL URLWithString:self.myModelnow.img]];
        mycell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return mycell;
        
    }else {
        
        SpeckModel *model = self.myArray[indexPath.row];
       static NSString *speckindext = @"indext";
        SpeckTableViewCell *speckCell = [self.tableView dequeueReusableCellWithIdentifier:speckindext];
        if (!speckCell) {
            speckCell = [[SpeckTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:speckindext];
            
        }
        speckCell.myPersonTimageView.layer.cornerRadius = 15;
        speckCell.myPersonTimageView.layer.masksToBounds = YES;
        [speckCell.myPersonTimageView sd_setImageWithURL:[NSURL URLWithString:model.member_avatar]];
        speckCell.myNameLable.text = model.member_name;//昵称
        speckCell.myNameLable.textColor = [UIColor brownColor];
        speckCell.mySpeckLable .text  = model.content;//评论的内容赋值
        speckCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return speckCell;
        
        
    }
    
    
    
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 170;
        
    }else {
    
    return 110;
    }
}

// 点击参与活动按钮

-(void)actionButton:(UIButton *)button
{
    NSString *member = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
    
    NSLog(@"%@",member);
    
    
    if (!([[[NSUserDefaults standardUserDefaults] valueForKey:@"key"] isEqualToString:@""])) {
        AFHTTPRequestOperationManager  *manager = [[AFHTTPRequestOperationManager alloc]init];
        
        [manager GET:[NSString stringWithFormat:@"%@?act=try&op=applyTry&member_id=%@&try_id=%@",kMainHttp,member,self.myModelnow.myid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            TsGoodViewController *ts = [[TsGoodViewController  alloc]init];
            [self.navigationController pushViewController:ts animated:NO];
            
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"  == 失败 原因%@",error);
            
        }];
        

    }else {
        
        
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未登陆" delegate:self cancelButtonTitle:@"登陆" otherButtonTitles:@"取消", nil];
        [al show];
        
        
    }
    
    
    
    
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
