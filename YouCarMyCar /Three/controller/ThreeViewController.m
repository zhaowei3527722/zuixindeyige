//
//  ThreeViewController.m
//  YoucarMycar
//
//  Created by LLY on 15-6-26.
//  Copyright (c) 2015年 LLY. All rights reserved.
//



#import "ThreeViewController.h"
#import "TouxiangTableViewCell.h"
#import "ClickViewController.h"
#import "TongyongTableViewCell.h"
#import "PrefixHeader.pch"
#import "XiangViewController.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#define kModaD self.view.frame.origin.x

@interface ThreeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableDictionary *dic;
@property (nonatomic,strong)NSMutableDictionary *imagedic;
@property (nonatomic,strong)UILabel *versionbLabel;
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//布局view
    [self layoutView];
    
}

//布局view
-(void)layoutView
{
    
    self.navigationItem.title = @"个人信息";
  
    self.dic = [[NSMutableDictionary alloc]init];
    self.imagedic = [[NSMutableDictionary alloc]init];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    
    NSArray *array1 = [[NSArray alloc]initWithObjects:@"活动记录",@"活动介绍", nil];
    NSArray *array2 = [[NSArray alloc]initWithObjects:@"关于我们",@"用户反馈",@"版本更新", nil];
    NSArray *imageArr1 = [[NSArray alloc]initWithObjects:@"活动记录.png",@"活动介绍.png", nil];
    NSArray *imageArr2 = [[NSArray alloc]initWithObjects:@"关于我们.png",@"意见反馈.png",@"版本更新.png", nil];
    
    [self.dic      setValue:array1    forKey:@"1"];
    [self.dic      setValue:array2    forKey:@"2"];
    [self.imagedic setValue:imageArr1 forKey:@"1"];
    [self.imagedic setValue:imageArr2 forKey:@"2"];
    

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TouxiangTableViewCell" bundle:nil]                                        forCellReuseIdentifier:@"imageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TongyongTableViewCell" bundle:nil] forCellReuseIdentifier:@"tongCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    
    
//右item
    UIButton *shezhiBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [shezhiBT setImage:[UIImage imageNamed:@"设置.png"] forState:(UIControlStateNormal)];
    [shezhiBT addTarget:self action:@selector(bianji) forControlEvents:(UIControlEventTouchUpInside)];
    [shezhiBT setFrame:CGRectMake(0, 0, 35, 35)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:shezhiBT];
    self.navigationItem.rightBarButtonItem = item;
    
    
}

//设置的点击事件
-(void)bianji
{
    XiangViewController *xiangVC = [[XiangViewController alloc]init];
    [self.navigationController pushViewController:xiangVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }else {
        return 3;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 155;
        
        
    }else{
        return 50;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section  ==0) {
        return 0;
    }else{
        return 10;
    }
}


//cell 的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClickViewController *clichVC = [[ClickViewController alloc]init];
    clichVC.i = 0;

    if (indexPath.section ==1 && indexPath.row <2) {
        
        for (int a = 0; a <2; a ++) {
        if (indexPath.section == 1 && indexPath.row == a) {
            clichVC.i = a;
        }
    }
        if (![[NSUserDefaults standardUserDefaults]valueForKey:@"key"]) {
            
            [self.navigationController pushViewController:clichVC animated:YES];
            
        }else{
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未登录" delegate:self cancelButtonTitle:@"马上登陆" otherButtonTitles:@"取消", nil];
            aller.tag = 102;
            
            
            [aller show];
        }
        
        
    } else if (indexPath.section ==2 && indexPath.row == 0 ) {
        
        clichVC.i = 5;
        
        [self.navigationController pushViewController:clichVC animated:YES];
        
    } else if(indexPath.section ==2 && indexPath.row  == 1 ){
        
        clichVC.i = 6;
        [self.navigationController pushViewController:clichVC animated:YES];
        
    } else if (indexPath.section == 2 && indexPath.row == 2 ){
        
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"已经是最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alterView.backgroundColor = [UIColor redColor];
        [alterView show];
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = [self.dic valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    NSString *str = array[indexPath.row];
    NSArray *imageArr = [self.imagedic  valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    NSString *imageStr = imageArr[indexPath.row];
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        TouxiangTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"imageCell"forIndexPath:indexPath];
        
        cell.photoImage.layer.cornerRadius = cell.photoImage.frame.size.height/2;
        cell.photoImage.layer.masksToBounds = YES;
//        NSURL *url = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults]valueForKey:@"avatar"]];
//        [cell.photoImage sd_setImageWithURL:url];
//        [cell.backimage sd_setImageWithURL:url];
        if (![[NSUserDefaults standardUserDefaults]valueForKey:@"key"]) {
            
        }else{
            cell.photoImage.image = [UIImage imageNamed:@"默认头像.png"];
            cell.backimage.image = [UIImage imageNamed:@"默认头像.png"];
            cell.nameLable.text = @"登陆/注册";
            
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [button addTarget: self action:@selector(denglu) forControlEvents:(UIControlEventTouchUpInside)];
            button.frame = CGRectMake(0, 0, cell.nameLable.frame.size.width, cell.nameLable.frame.size.height);
            cell.nameLable.userInteractionEnabled = YES;
            [cell.nameLable addSubview:button];
        }
        
        

        cell.photoImage.userInteractionEnabled = YES;
        cell.backimage.userInteractionEnabled = YES;
        cell.superview.superview.backgroundColor = MainBackGround;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
        
    }else{
        
        TongyongTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tongCell" forIndexPath:indexPath];
        cell.lableText.text = str;
        cell.iconImage.image = [UIImage imageNamed:imageStr];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 1  && indexPath.row < 1) {
            
            cell.myView.alpha = 1;
            
        }
        if (indexPath.section == 2  && indexPath.row < 2) {
            
            cell.myView.alpha = 1;
        }
        
        if (indexPath.section == 2  && indexPath.row == 2) {
            
            self.versionbLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMainWidth - 150, 0, 120, 50)];
            self.versionbLabel.text = @"已是最新版本";
            self.versionbLabel.textColor = [UIColor grayColor];
            self.versionbLabel.font = [UIFont systemFontOfSize:14];
            self.versionbLabel.textAlignment = NSTextAlignmentRight;
            [cell addSubview: self.versionbLabel];
            
        }
        return cell;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else {
        
    }
}

-(void)denglu
{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
