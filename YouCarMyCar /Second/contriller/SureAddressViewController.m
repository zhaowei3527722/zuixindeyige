//
//  SureAddressViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/29.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "SureAddressViewController.h"
#import "PrefixHeader.pch"
#import "AddressModel.h"
#import "AFNetworking.h"

@interface SureAddressViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)UITextField *nameFd;
@property (nonatomic,strong)UITextField *addressFd;
@property (nonatomic,strong)UITextField *phoneFd;
@property (nonatomic,strong)UITextField *youzhengFd;
@property (nonatomic,strong)AddressModel *addressMd;
@property (nonatomic,strong)UITextField *addressField;
@property (nonatomic,strong)UITableView *addressTableView;
@property (nonatomic,strong)UITableView *myTableView;
@end

@implementation SureAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认地址";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
    [self coustom];//布局

    
}

-(void)coustom


{
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height )];
    self.myTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    self.myTableView.backgroundColor = MainBackGround;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.myTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
    
    
    
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardBounds = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.myTableView.contentInset = UIEdgeInsetsMake(self.myTableView.contentInset.top, 0, keyboardBounds.size.height, 0);
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.myTableView.contentInset = UIEdgeInsetsMake(self.myTableView.contentInset.top, 0, 0, 0);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 65;
    }else if (indexPath.row > 0 && indexPath.row <5) {
        return 45;
    }else if (indexPath.row == 5 ){
        return 170;
    }else{
        return 50;
    }
}

//cell 的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *tag=@"tag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tag];
    if (cell==nil ) {
        cell=[[ UITableViewCell alloc]init];
        if (indexPath.row >0 && indexPath.row < 5) {
            UIView  *lable = [[UIView alloc]initWithFrame:CGRectMake(30, 0, kMainWidth - 60, 40)];
            lable.backgroundColor = [UIColor whiteColor];
            lable.layer.cornerRadius = 4;
            self.addressField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, lable.frame.size.width - 30, 40)];
            _addressField.delegate = self;
            if (indexPath.row == 1) {
                    _addressField.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"true_name"];
                
                self.nameFd = _addressField;
            }else if (indexPath.row == 2) {

                _addressField.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"address"];
                self.addressFd = _addressField;
                
            }else if (indexPath.row == 3) {
               
                  _addressField.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"mob_phone"];
                 self.phoneFd = _addressField;
            }else if (indexPath.row == 4) {
                    //这里放的是邮政编码
                _addressField.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"zip_code"];
                
                
                self.youzhengFd = _addressField;
            }
            
        [lable addSubview:_addressField];
        [cell addSubview:lable];
        
         }
    
        }
    
    
    cell.backgroundColor = MainBackGround;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        UILabel *myLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kMainWidth, 40)];
        myLable.text = @"请您认真填写,以便我们准确发货";
        myLable.textAlignment = NSTextAlignmentCenter;
        myLable.backgroundColor = COLOR(36, 141, 216, 1);
        myLable.textColor = [UIColor whiteColor];
        [cell addSubview:myLable];
        
    }else if(indexPath.row == 5) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, kMainWidth - 40, 130)];
        imageView.image = [UIImage imageNamed:@"小提示1.png"];
        [cell addSubview:imageView];
        
        
    }else if (indexPath.row == 6) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景.png"] forState:(UIControlStateNormal)];
        [button setFrame:CGRectMake(10, 10, kMainWidth - 20 , 40)];
        [button setTitle:@"确定" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(sureAddress:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        [cell addSubview:button];
        
    }
    
    return cell;
    
    
    
    
}


//点击确定的方法

-(void)sureAddress:(UIButton *)button
{
    NSString *userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"member_id"];
    NSString *key = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
    
    
    
    
    
    
    NSDictionary *dic = @{@"act":@"try",@"op":@"subTryMemberInfo",@"member_id":userID,@"key":key,@"name":_nameFd.text,@"phone":_phoneFd.text,@"address":_addressFd.text,@"zip_code":_youzhengFd.text,@"id":self.myID};
                NSLog(@"%@",dic);
    
    AFHTTPRequestOperationManager *manger = [[AFHTTPRequestOperationManager alloc]init];
    [manger POST:kMainHttp parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject valueForKey:@"datas"] valueForKey:@"error"]) {
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:[[responseObject valueForKey:@"datas"] valueForKey:@"error"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            aller.tag = 100;
            [aller show];
            

            
        }else if ([_nameFd.text isEqualToString:@""]) {
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"姓名不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            aller.tag = 121;
            [aller show];
        }else if ([_addressFd.text isEqualToString:@""]) {
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"地址不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            aller.tag = 122;
            [aller show];
        }else if ([_youzhengFd.text isEqualToString:@""]) {
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邮政编码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            aller.tag = 123;
            [aller show];
        }else{
            
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            aller.tag = 101;
            [aller show];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    

    
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
