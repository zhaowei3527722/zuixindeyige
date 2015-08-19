//
//  GoodDetalTableViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/27.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "GoodDetalTableViewController.h"

#import "PrefixHeader.pch"
#import "GoodTableTableViewCell.h"
#import "UIImageView+WebCache.h"

#import "TsGoodViewController.h"

#import "AFNetworking.h"
#import "AllDeteModel.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "MJRefresh.h"
@interface GoodDetalTableViewController ()<MylistFirstbleDelegate,UIAlertViewDelegate>
@property (nonatomic ,strong)NowViewModel *myModelnoW;
@property (nonatomic,strong)NSMutableArray *myArray;
@property (nonatomic,strong)AllDeteModel *myAllDetallModel;

@end

@implementation GoodDetalTableViewController

-(id)initWithModel:(NowViewModel *)model

{
    
    if ([super init]) {
        
        self.myModelnoW = model;
        
        
    }
    return self;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.myArray = [NSMutableArray array];
    self.tableView.bounces = NO;
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.header = header;
    

    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
   
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
//    [self.tableView headerBeginRefreshing];
//    
    
    
    

}
-(void)headerRefreshing
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=info&id=%@",kMainHttp,self.myModelnoW.myid];
    NSString *urlF8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager GET:urlF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"%@",responseObject);
        [self.myArray removeAllObjects];

        if (!([responseObject valueForKey:@"datas"] == [NSNull null])) {
            NSDictionary *dic = [responseObject valueForKey:@"datas"];
            self.myAllDetallModel  = [[AllDeteModel alloc]init];
            [self.myAllDetallModel setValuesForKeysWithDictionary:dic];
            [self.myArray addObject:self.myAllDetallModel];
            
            [self.tableView reloadData];
            
            NSLog(@"%@",self.myAllDetallModel.big_img);
            NSString *string = self.myAllDetallModel.info;
            
            string = [string substringWithRange:NSMakeRange(0, string.length - 2)];
            
            string = [NSString stringWithFormat:@"%@style=\" width:%.fpx\";/>",string,kMainWidth - 10];
            

            
            UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 210, kMainWidth, kMainHeight - 104 - 170)];
            [web setUserInteractionEnabled:YES];//是否支持交互
            //            NSString *str2 = [NSString stringWithFormat:@"<p><img src=\"%@\" style=\" width:%.fpx; \"/></p>", self.myAllDetallModel.info,[UIScreen mainScreen].bounds.size.width-20];
            //    web.backgroundColor = [UIColor whiteColor];
            [web setOpaque:NO];//opaque是不透明的意思
            NSLog(@"html == %@",self.myAllDetallModel.info);
            web.backgroundColor  = [UIColor whiteColor];
            
            [web loadHTMLString:string baseURL:nil];
            
            [self.view addSubview:web];
            

            
        }
       
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求出问题了");
        
    }];
    
    
    [self.tableView.header endRefreshing];
    

    
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (kMainHeight == 480) {
        
        if (section == 1) {
            return 30;
            
        }else {
            
            
            return 0;
            
        }
        

    }else {
        
        if (section == 1) {
            return 40;
            
        }else {
            
            
            return 0;
            
        }

        
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (kMainHeight == 480) {
        if (section == 1) {
            self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 30)];
            self.myView.backgroundColor = COLOR(253, 246, 240, 1);
            
            self.myliftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myliftButton.frame = CGRectMake(0, 0, kMainWidth / 2, 30);
            
            [self.myliftButton setBackgroundImage:[UIImage imageNamed:@"产品详情@2x.png"] forState:(UIControlStateNormal)];
            
            [self.myView addSubview:self.myliftButton];
            
            self.myRignth = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myRignth.frame = CGRectMake(kMainWidth / 2, 0, kMainWidth / 2, 30);
            [self.myRignth addTarget:self action:@selector(myRignth:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [self.myRignth setBackgroundImage:[UIImage imageNamed:@"形状-6@2x.png"] forState:(UIControlStateNormal)];
            [self.myView addSubview:self.myRignth];
            
            
            
            
            return self.myView;
            
            
        }
        
        return nil;

    }else {
        
        
        
        if (section == 1) {
            self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 40)];
            self.myView.backgroundColor = COLOR(253, 246, 240, 1);
            
            self.myliftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myliftButton.frame = CGRectMake(0, 0, kMainWidth / 2, 40);
            
            [self.myliftButton setBackgroundImage:[UIImage imageNamed:@"产品详情@2x.png"] forState:(UIControlStateNormal)];
            
            [self.myView addSubview:self.myliftButton];
            
            self.myRignth = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myRignth.frame = CGRectMake(kMainWidth / 2, 0, kMainWidth / 2, 40);
            [self.myRignth addTarget:self action:@selector(myRignth:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [self.myRignth setBackgroundImage:[UIImage imageNamed:@"形状-6@2x.png"] forState:(UIControlStateNormal)];
            [self.myView addSubview:self.myRignth];
            
            
            
            
            return self.myView;
            
            
        }
        
        return nil;

    }
    
    
}
-(void)myRignth:(UIButton *)button
{
    
    if ([self.delegate respondsToSelector:@selector(ringhtButtonAction:)]) {
        [self.delegate ringhtButtonAction:button];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    if (indexPath.section == 0) {
        static NSString *cell = @"index";
        MyListFirstTableViewCell *mycell = [[MyListFirstTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cell];
            mycell.selectionStyle = UITableViewCellSelectionStyleNone;
            

        mycell.delegagate = self;
       // NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        //NSTimeInterval a = [dat timeIntervalSince1970];
        NSInteger tim =  [self.myAllDetallModel.date integerValue]*24*3600 + [self.myAllDetallModel.hours integerValue]*3600+[self.myAllDetallModel.minutes integerValue]*60 + [self.myAllDetallModel.seconds integerValue];
        
        mycell.mytimeInteger = tim;
        mycell.mydescritionLable.text = self.myModelnoW.small_info;
        mycell.myallGoodsCount.text = self.myModelnoW.number;
        mycell.mynowPerson.text = self.myModelnoW.try_people;
        mycell.myGoodName.text = self.myModelnoW.title;
        [mycell.myGoodImageVeiw sd_setImageWithURL:[NSURL URLWithString:self.myModelnoW.img]];
        mycell.selectionStyle = UITableViewCellSelectionStyleNone;
     
        if ([self.myModelnoW.presence integerValue]==1) {
            [mycell.mybutton setBackgroundImage:[UIImage imageNamed:@"免费试用dianji.png"] forState:(UIControlStateNormal)];
            
        }
        
        
        
        return mycell;

    
    }
    
//    else {
//        
//        static NSString *goodindext = @"goods";
//        GoodTableTableViewCell *goodcell = [self.tableView dequeueReusableCellWithIdentifier:goodindext];
//        if (!goodcell) {
//            goodcell = [[GoodTableTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:goodindext];
//            
//            
//            
//            
//            
//        }
//        [goodcell.myImageView sd_setImageWithURL:[NSURL URLWithString:self.myAllDetallModel.big_img]];
//
//        goodcell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        return goodcell;
//
//
//        
// 
//    }
//
    
    
    return nil;
    
    
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {
        return 170;
        
    }else {
        return 170 * kMainWidth / 320;
        
    
    }
    
    
}
//点击的方法

//点击参与走的方法

-(void)actionButton:(UIButton *)button
{
    
    NSString *member = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
    
    NSLog(@"%@",member);
    NSString *key = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
    
    
    if (key) {
        AFHTTPRequestOperationManager  *manager = [[AFHTTPRequestOperationManager alloc]init];
        
        [manager GET:[NSString stringWithFormat:@"%@?act=try&op=applyTry&member_id=%@&key=%@&try_id=%@",kMainHttp,member,key,self.myModelnoW.myid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([[responseObject valueForKey:@"datas"] valueForKey:@"error"]) {
                
                UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:[[responseObject valueForKey:@"datas"] valueForKey:@"error"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [ale show];
                
                
            }else {
                
                
                TsGoodViewController *ts = [[TsGoodViewController  alloc]init];
                [self.navigationController pushViewController:ts animated:NO];
                [self headerRefreshing];
                
                
            }

            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"  == 失败 原因%@",error);
            
        }];
        
        
    }else {
        
        
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未登陆" delegate:self cancelButtonTitle:@"马上登陆" otherButtonTitles:@"取消", nil];
        [al show];
        
        
    }
    
    
    
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 0) {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        
    }
}
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
