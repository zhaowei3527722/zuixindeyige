//
//  ClickTViewController.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/16.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "ClickTViewController.h"
#import "PrefixHeader.pch"
#import "SureViewController.h"
@interface ClickTViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *newpasswordField;
@property (nonatomic,strong)UITextField *surepasswordField;
@property (nonatomic,strong)UIButton *sureButton;
@end

@implementation ClickTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MainBackGround;
    
    //布局View
    [self layoutView];
    
}

//布局View
-(void)layoutView
{
    self.title = @"修改密码";
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, kMainWidth - 20, 50)];
    imageView.image = [UIImage imageNamed: @"背景框.png"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    self.newpasswordField = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, kMainWidth - 20, 50)];
    self.newpasswordField.delegate = self;
    self.newpasswordField.attributedPlaceholder = KMainPlaceholder(@"请输入新密码");
    [imageView addSubview:self.newpasswordField];
    
    
    UIImageView *sureimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, imageView.frame.origin.y +70, kMainWidth - 20, 50)];
    sureimageView.image = [UIImage imageNamed: @"背景框.png"];
    sureimageView.userInteractionEnabled = YES;
    [self.view addSubview:sureimageView];
    
    self.surepasswordField = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, kMainWidth - 20, 50)];

    self.surepasswordField.attributedPlaceholder = KMainPlaceholder(@"请再次输入新密码");
    self.surepasswordField.delegate = self;
    
    [sureimageView addSubview:self.surepasswordField];
    
    self.sureButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.sureButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.sureButton addTarget:self action:@selector(sure) forControlEvents:(UIControlEventTouchUpInside)];
    self.sureButton.frame = CGRectMake(10, sureimageView.frame.origin.y + 100, kMainWidth - 20, 50);
    self.sureButton.titleLabel.font = MyButtonFont;
    self.sureButton.backgroundColor = COLOR(49, 219, 224, 1);
    [self.sureButton setTintColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.sureButton];
    
    
    //返回的箭头
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
    

}

//pop
-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)sure
{
    SureViewController *sureVC = [[SureViewController alloc]init];
    sureVC.j = 10;
    [self.navigationController pushViewController:sureVC animated:YES];
}

//键盘回收
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.newpasswordField resignFirstResponder];
    [self.surepasswordField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
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
