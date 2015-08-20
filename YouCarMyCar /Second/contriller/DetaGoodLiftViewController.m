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

#import "MJRefresh.h"
@interface DetaGoodLiftViewController ()
@property (nonatomic ,strong)WangQiModel *mymodel;
@property (nonatomic,strong)NSMutableArray *myArray;
@property (nonatomic,strong)AllDeteModel *myAllDetallModel;




@end

@implementation DetaGoodLiftViewController

-(id)initWithModel:(WangQiModel *)model

{
    
    if ([super init]) {
        
        self.mymodel = model;
    }
    return self;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myArray = [NSMutableArray array];

    
    [self headerRefreshing];//获取数据

   }
//获取数据

-(void)headerRefreshing
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=info&id=%@",kMainHttp,self.mymodel.myID];
    NSString *urlF8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager GET:urlF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        
        
        [self.myArray removeAllObjects];
        
        if (!([responseObject valueForKey:@"datas"] == [NSNull null])) {
            NSDictionary *dic = [responseObject valueForKey:@"datas"];
            self.myAllDetallModel  = [[AllDeteModel alloc]init];
            [self.myAllDetallModel setValuesForKeysWithDictionary:dic];
            [self.myArray addObject:self.myAllDetallModel];
            
            NSString *string = self.myAllDetallModel.info;
            NSString *str = [NSString stringWithFormat:@"alt=\"\" style=\" width:%.fpx\";",kMainWidth - 10];
            string =[string stringByReplacingOccurrencesOfString:@"alt=\"\"" withString:str];
            
            NSLog(@"%@",string);
            UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight - 104)];

            web.backgroundColor = [UIColor whiteColor];
            [web setOpaque:NO];//opaque是不透明的意思
            NSLog(@"html ==  %@",self.myAllDetallModel.info);
            [self.view addSubview:web];
            [web loadHTMLString:string baseURL:nil];

            
            
            
        
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求出问题了");
        
    }];
    
    
    
    
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
