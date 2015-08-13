//
//  XieYiViewController.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/31.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "XieYiViewController.h"
#import "PrefixHeader.pch"
#import <CoreText/CoreText.h>
@interface XieYiViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic)int i;
@property (nonatomic,strong)UILabel *timeLable;
@property (nonatomic,copy)NSString *str;
@end

@implementation XieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MainBackGround;
    
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
    
    if (self.k == 1) {  //布局谢谢提交
        [self layoutXieXie];
    }else if (self.k ==2) {  //布局协议页面
        [self layoutXieYi];
    }

}



//布局谢谢提交
-(void)layoutXieXie
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kMainWidth/2 - kMainWidth/5, 100, kMainWidth*2/5, kMainWidth*2/5)];
    imageView.image = [UIImage imageNamed:@"谢谢.png"];
    [self.view addSubview:imageView];
    
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(kMainWidth/2 - 100, imageView.frame.size.height + 150, 200, 60)];
    lable.text = @"感谢您提交的试用反馈";
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    
    
    self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(kMainWidth/2 - 100, imageView.frame.size.height + 180, 200, 60)];
    self.i = 4;
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    NSString *str = [NSString stringWithFormat:@"3秒后自动返回 >>"];
    self.timeLable.text = str;
    self.timeLable.font = [UIFont fontWithName:@"DBLCDTempBlack" size:12];
    [self.view addSubview:self.timeLable];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    [self.timer fire];
    
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
}

-(void)pop
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


//布局协议页面
-(void)layoutXieYi
{
    
    
   

}

-(void)pop2
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 定时器执行的方法
- (void)timerFireMethod:(NSTimer *)paramTimer{
    
    self.i--;
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    self.str = [NSString stringWithFormat:@"%d秒后自动返回 >>",self.i];
    self.timeLable.text = self.str;


    if (self.i == 0) {
        
        [self.timer invalidate];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
       [self.timer invalidate];
        
    }

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
