//
//  SureViewController.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/16.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "SureViewController.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"
@interface SureViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic,strong)UITextField *addressField;
@property (nonatomic,strong)UITableView *addressTableView;
@property (nonatomic,strong)UITableView *myTableView;


@end

@implementation SureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =  MainBackGround;
    
  
    if (self.j == 10) {
        //布局修改密码
        [self layoutSureKey];
    }else if (self.j == 11 || self.j == 111) {
        //布局添加地址
        [self laoutAddAddress];
    }

    

    
    //返回的箭头
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

//**********************************************布局修改密码*************************************
-(void)layoutSureKey
{
    self.title = @"修改密码";
    

    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kMainWidth/2 - 45, kMainHeight/5 , 90, 90)];
    imageView.image = [UIImage imageNamed:@"密码设置成功.png"];
    [self.view addSubview:imageView];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(kMainWidth/2 -100,kMainHeight/5 +140 , 200, 30)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"密码设置成功!";
    [self.view addSubview:lable];
    
    
    
    
    UIButton *surebutton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    surebutton.frame = CGRectMake(20, kMainHeight/5 +200, kMainWidth - 40, 50);
    [surebutton setTitle:@"确定" forState:(UIControlStateNormal)];
    [surebutton setTintColor:[UIColor whiteColor]];
    surebutton.titleLabel.font = MyButtonFont;
    surebutton.backgroundColor = COLOR(53, 224, 229, 1);
    [surebutton addTarget:self action:@selector(sure) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:surebutton];
}


-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)sure
{
    NSLog(@"应该是模态出登陆页面");
}


//**********************************************布局添加地址*************************************
-(void)laoutAddAddress
{
    if (self.j == 11) {
        self.title = @"新增地址";
    }else if (self.j == 111) {
        self.title = @"编辑地址";
    }
    
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
                if (self.j == 11) {
                    _addressField.placeholder = @"请输入收货人姓名";
                }else if (self.j == 111) {
                    _addressField.text = self.addressMd.true_name;
                }
                self.nameFd = _addressField;
            }else if (indexPath.row == 2) {
                if (self.j == 11) {
                    _addressField.placeholder = @"请输入您的详细地址";
                }else if (self.j == 111) {
                    //这里是传过来的地址
                }
                self.addressFd = _addressField;
            }else if (indexPath.row == 3) {
                if (self.j == 11) {
                    _addressField.placeholder = @"请输入您的联系电话";
                }else if (self.j == 111) {
                    _addressField.text = self.addressMd.mob_phone;
                }
                self.phoneFd = _addressField;
            }else if (indexPath.row == 4) {
                if (self.j == 11) {
                    _addressField.placeholder = @"请输入您的邮编";
                }else if (self.j == 111) {
                    //这里放的是邮政编码
                }
                
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

-(void)sureAddress:(UITextField *)tag
{
    NSLog(@"确定添加新地址");
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"member_id"];
    NSString *key = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
    
    
    NSDictionary *dic = @{@"act":@"member_address",@"op":@"address_add",@"member_id":userID,@"key":key,@"true_name":_nameFd.text,@"address":_addressFd.text,@"mob_phone":_phoneFd.text,@"zip_code":_youzhengFd.text};
    
    AFHTTPRequestOperationManager *manger = [[AFHTTPRequestOperationManager alloc]init];
    [manger POST:kMainHttp parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
           NSLog(@"%@",[[responseObject valueForKey:@"datas"] valueForKey:@"error"]);
        
        if ([[responseObject valueForKey:@"datas"] valueForKey:@"error"]) {
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:[[responseObject valueForKey:@"datas"] valueForKey:@"error"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            aller.tag = 100;
            
            
            [aller show];
            
            
        }else {
            
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"添加成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            aller.tag = 101;
            
        
            [aller show];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    

    if ([_delegate respondsToSelector:@selector(addObjectnameFd:addressFd:phoneFd:youzhengFd:)]) {
        [_delegate addObjectnameFd:_nameFd addressFd:_addressFd phoneFd:_phoneFd youzhengFd:_youzhengFd];
    }
    
    

    

    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 101) {

    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
  }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
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
