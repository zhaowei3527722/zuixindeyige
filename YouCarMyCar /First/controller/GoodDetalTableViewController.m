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


@interface GoodDetalTableViewController ()<MylistFirstbleDelegate>
@property (nonatomic ,strong)NowViewModel *myModelnoW;

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
    
    [self coustom]; // 获取数据
    
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
   
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

//获取数据
-(void)coustom
{
    
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (kMainHeight == 480) {
        if (section == 1) {
            self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 30)];
            self.myView.backgroundColor = COLOR(253, 246, 240, 1);
            
            self.myliftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myliftButton.frame = CGRectMake(0, 0, 80, 30);
            
            [self.myliftButton setBackgroundImage:[UIImage imageNamed:@"产品详情@2x(1).png"] forState:(UIControlStateNormal)];
            
            [self.myView addSubview:self.myliftButton];
            
            self.myRignth = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myRignth.frame = CGRectMake(80, 0, 80, 30);
            [self.myRignth addTarget:self action:@selector(myRignth:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [self.myRignth setBackgroundImage:[UIImage imageNamed:@"参与评论未选中@2x(1).png"] forState:(UIControlStateNormal)];
            [self.myView addSubview:self.myRignth];
            
            
            
            
            return self.myView;
            
            
        }
        
        return nil;

    }else {
        
        
        
        if (section == 1) {
            self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 40)];
            self.myView.backgroundColor = COLOR(253, 246, 240, 1);
            
            self.myliftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myliftButton.frame = CGRectMake(0, 0, 100, 40);
            
            [self.myliftButton setBackgroundImage:[UIImage imageNamed:@"产品详情@2x(1).png"] forState:(UIControlStateNormal)];
            
            [self.myView addSubview:self.myliftButton];
            
            self.myRignth = [UIButton buttonWithType:(UIButtonTypeCustom)];
            self.myRignth.frame = CGRectMake(100, 0, 100, 40);
            [self.myRignth addTarget:self action:@selector(myRignth:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [self.myRignth setBackgroundImage:[UIImage imageNamed:@"参与评论未选中@2x(1).png"] forState:(UIControlStateNormal)];
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
    
    return 20;
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
        mycell.mytimeInteger = 1000; //- (a - self.miao) ;
        mycell.mydescritionLable.text = self.myModelnoW.small_info;
        mycell.myallGoodsCount.text = self.myModelnoW.number;
        mycell.mynowPerson.text = self.myModelnoW.try_people;
        mycell.myGoodName.text = self.myModelnoW.title;
        [mycell.myGoodImageVeiw sd_setImageWithURL:[NSURL URLWithString:self.myModelnoW.img]];
        mycell.selectionStyle = UITableViewCellSelectionStyleNone;
     
        
        
        return mycell;

    
    }else {
        
        static NSString *goodindext = @"goods";
        GoodTableTableViewCell *goodcell = [self.tableView dequeueReusableCellWithIdentifier:goodindext];
        if (!goodcell) {
            goodcell = [[GoodTableTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:goodindext];
            goodcell.myImageView.image = [UIImage imageNamed:@"33.jpg"];
            
            
            
            
            
        }
        
        goodcell.selectionStyle = UITableViewCellSelectionStyleNone;

        return goodcell;


        
 
    }
    
    
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
    TsGoodViewController *ts = [[TsGoodViewController  alloc]init];
    [self.navigationController pushViewController:ts animated:NO];
    
    
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
