//
//  ClickViewController.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/7.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "ClickViewController.h"
#import "PrefixHeader.pch"
#import "ClickTViewController.h"
#import "addressTableViewCell.h"
#import "ZWTextView.h"
#import "ActivityTableViewCell.h"
#import "SureViewController.h"
#import "AddressModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"
#import "CommUtils.h"
#import "Huodongjilu.h"
#import "UIImageView+WebCache.h"
#import "LiftButtonViewController.h"
#import "SxiangViewController.h"

#import "SxiangViewController.h"
@interface ClickViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate,addressTableViewCellDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)ZWTextView *textView;
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,strong)UITextField *phoneField;
@property (nonatomic,strong)UIButton *passButton;
@property (nonatomic,strong)UITextField *codeField;
@property (nonatomic,strong)UIButton *nextButton;
@property (nonatomic,strong)UIImageView *choiceImage;
@property (nonatomic,strong)NSMutableArray *myArray;
@property (nonatomic,strong)NSMutableArray *addressArray;
@property (nonatomic,strong)AddressModel *addressModel;
@property (nonatomic,strong)NSMutableArray *huodongArray;
//@property (nonatomic,strong)Huodongjilu *huodongModel;
@end

@implementation ClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainBackGround;
    
    
    
    
          if (self.i == 0) {     //布局活动记录
        
        [self layoutJoinView];
        
    }else if (self.i == 1) {     //布局活动介绍
        
        [self layoutIntroduce];
        
    }else if (self.i == 5) {     //布局关于我们
        
        [self layoutOurs];
        
    }else if (self.i == 6) {     //布局用户反馈
        
        [self layoutBack];
        
    }else if (self.i == 11) {    //布局地址编辑
        
        [self layoutAddress];
        
    }else if (self.i == 12) {    //布局修改密码
        
        [self layoutPassword];
        
    }else if (self.i == 13) {    //布局改变性别
        
        [self layoutSexVC];
        
    }else if (self.i == 14) {    //布局更改手机号
        
        [self layoutPhotoNamber];
        
    }else if (self.i == 15) {    //布局更改邮箱
        
        [self layoutEmail];
    }
    
    
    //返回的箭头
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    [button setFrame:CGRectMake(0, 0, 15, 25)];
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
}

-(void)pop
{

    
    [self.navigationController popViewControllerAnimated:YES];
}

//********************************活动记录*********************************
-(void)layoutJoinView
{
    self.title = @"活动记录";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerNib:[UINib
                                 nibWithNibName:@"ActivityTableViewCell"
                                 bundle:nil]
                                 forCellReuseIdentifier:@"huodongCell"];
    [self.tableView registerNib:[UINib
                                 nibWithNibName:@"DiJiQiTableViewCell"
                                 bundle:nil]
                                 forCellReuseIdentifier:@"dijiqiCell"];
    
    self.huodongArray = [NSMutableArray array];
    
    //加载
    
    NSString *memberID = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
    NSString *key = [[NSUserDefaults standardUserDefaults]valueForKey:@"key"];
    NSString *url = [NSString stringWithFormat:@"%@?act=try&op=userrecord&member_id=%@&key=%@&curpage=1&eachNum=100",kMainHttp,memberID,key];
    NSLog(@"%@",url);
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if (!([[responseObject valueForKey:@"datas"] valueForKey:@"error"])) {
            NSMutableArray *array = [[responseObject valueForKey:@"datas"] valueForKey:@"list"];
            for (NSDictionary *dic in array) {
                Huodongjilu *a = [[Huodongjilu alloc]init];
                [a setValuesForKeysWithDictionary:dic];

                [_huodongArray addObject:a];
                NSLog(@"%@",_huodongArray);
                
                
            }
            
            [self.tableView reloadData];//刷新;
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
    
    
    
    
}

//********************************性别改变*********************************
-(void)layoutSexVC
{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];;
    [self.tableView setBackgroundColor:MainBackGround];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.choiceImage = [[UIImageView alloc]
                        initWithFrame:CGRectMake(kMainWidth - 40, -125, 20, 20)];
    [self.choiceImage setImage:[UIImage imageNamed:@"性别选择.png"]];
    [self.tableView addSubview:self.choiceImage];

    
    NSString *sexStr = [[NSUserDefaults standardUserDefaults]valueForKey:@"sex"];
    if ([sexStr isEqualToString:@"男"]) {
        self.choiceImage.frame = CGRectMake(kMainWidth - 40, 25, 20, 20);
    }else if ([sexStr isEqualToString:@"女"]) {
        self.choiceImage.frame = CGRectMake(kMainWidth - 40, 75, 20, 20);
    }else if ([sexStr isEqualToString:@"保密"]){
        self.choiceImage.frame = CGRectMake(kMainWidth - 40, 125, 20, 20);
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.i == 11 || self.i == 13 || self.i == 0) {
        return 1;
    }else {
        return 3;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.i == 11) {
        return _addressArray.count;
    }else if (self.i == 13){
        return 4;
    }else if (self.i == 0){
        return 10;
    }else {
        return 3;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.i == 11) {
        
        return 150;
        
    }else if (self.i == 13) {

        if (indexPath.row == 0) {
            return 10;
        }else{
        return 50;
        }
        
    }else{
        return 100;
        
    }
}


//cell 的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.i == 0) {
    ///从活动记录跳转到详情页面
        Huodongjilu *huodongMd = _huodongArray[indexPath.row];
        SxiangViewController *sXiangVC = [[SxiangViewController alloc]init];
        sXiangVC.stringID = huodongMd.try_id;
        
        [self.navigationController pushViewController:sXiangVC animated:YES];
    
    
    
    }else if (self.i == 13){
        
        if (indexPath.row == 1) {
            [self.choiceImage setFrame:CGRectMake(kMainWidth - 40, 25, 20, 20)];
            [self.tableView addSubview:self.choiceImage];
        }else if (indexPath.row == 2) {
            [self.choiceImage setFrame:CGRectMake(kMainWidth - 40, 75, 20, 20)];
            [self.tableView addSubview:self.choiceImage];
        }else if (indexPath.row == 3) {
            [self.choiceImage setFrame:CGRectMake(kMainWidth - 40, 125, 20, 20)];
            [self.tableView addSubview:self.choiceImage];
        }
        
        if (self.choiceImage.frame.origin.y==25) {
            _sexString = @"男";
        }else if (self.choiceImage.frame.origin.y==75) {
            _sexString = @"女";
        }else if (self.choiceImage.frame.origin.y==125) {
            _sexString = @"保密";
        }
        
        if ([_delegate respondsToSelector:@selector(sender:)]) {
            [_delegate sender:_sexString];
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.i == 11) {

        AddressModel *addressMd = _addressArray[_addressArray.count - 1 - indexPath.row];
        addressTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"addressCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLable.text = addressMd.true_name;
        cell.phoneLable.text = addressMd.mob_phone;
        cell.addressLable.text = addressMd.address;
        
        if ([addressMd.is_default isEqualToString:@"1"]) {
            [cell.morenBT setImage:[UIImage imageNamed:@"默认.png"] forState:(UIControlStateNormal)];
        }
        
        self.bianjiBT = cell.bianjiBT;
        self.shanchuBT = cell.shanchuBT;
        self.morenBT = cell.morenBT;
        cell.delegate = self;
        cell.backgroundColor = MainBackGround;
        return cell;
        
    }else if (self.i == 13) {
        
        NSString *tag=@"tag";
        NSArray *arr = [[NSArray alloc]initWithObjects:@"",@"男",@"女",@"保密", nil];
        NSString *cellString  =arr[indexPath.row];
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tag];
        
        if (cell==nil ) {
            cell=[[ UITableViewCell alloc]init];
            if (indexPath.row == 1 || indexPath.row == 2) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 49, kMainWidth - 20 , 1)];
                view.backgroundColor = COLOR(201, 201, 201, 1);
                [cell addSubview:view];
            }
                   }
        if (indexPath.row == 0) {
            cell.backgroundColor = MainBackGround;
        }
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 50)];
        lable.text = cellString;
        lable.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lable];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
        
    }else{
        
        ActivityTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"huodongCell" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        Huodongjilu *huodongModel = self.huodongArray[ indexPath.row];
//        cell.backgroundColor = MainBackGround;
//        
//        cell.thingImage.image = [UIImage imageNamed:@"2.png"];
//        cell.selectionStyle = UITableViewCellAccessoryNone;
//        cell.superview.superview.backgroundColor = MainBackGround;
//        
//        cell.numberLable.text = huodongModel.number;
//        cell.nameLable.text = huodongModel.title;
        
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yy年MM月dd日"];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:1000000000];
        NSString* dateString = [formatter stringFromDate:date];

        cell.timeLable.text = dateString;
        
        
//        
//        if ([huodongModel.status isEqualToString:@"3"]) {
//            [cell.baoGao setImage:[UIImage imageNamed:@"审核中.png"] forState:(UIControlStateNormal)];
//        }else if ([huodongModel.status isEqualToString:@"1"]) {
//            [cell.baoGao setImage:[UIImage imageNamed:@"审核中.png"] forState:(UIControlStateNormal)];
//            
//        }else if ([huodongModel.status isEqualToString:@"2"]) {
//            [cell.baoGao setImage:[UIImage imageNamed:@"再接再厉.png"] forState:(UIControlStateNormal)];
//        }else if ([huodongModel.status isEqualToString:@"0"]) {
//            [cell.baoGao setImage:[UIImage imageNamed:@"恭喜中奖.png"] forState:(UIControlStateNormal)];
//            [cell.baoGao addTarget:self action:@selector(baogao:) forControlEvents:(UIControlEventTouchUpInside)];
//        }
//        
//        NSURL *url = [NSURL URLWithString:huodongModel.img];
//        
//        [cell.thingImage sd_setImageWithURL:url];
        
        
        

        return cell;
       }
    }


-(void)baogao:(UIButton *)button
{
    
    UITableViewCell *cell = (UITableViewCell *)[[button  superview] superview];
    self.myIndexPath = [self.tableView indexPathForCell:cell];
    Huodongjilu *huodongMd = _huodongArray[_myIndexPath.row];
    
    LiftButtonViewController *lift = [[LiftButtonViewController alloc]init];
    lift.wangqiModel.myID = huodongMd.myID;
    [self.navigationController pushViewController:lift animated:YES];
    
}


-(void)buttonAction1:(UIButton *)button
{

    SureViewController *sure = [[SureViewController alloc]init];
    sure.j = 111;
    sure.addressMd = _addressArray[_addressArray.count - 1 - self.myIndexPath.row];
    [self.navigationController pushViewController:sure animated:YES];
    
    
}

-(void)buttonAction2:(UIButton *)button
{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定删除该地址?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 110;
    [alert show];
    
   
    UITableViewCell *cell = (UITableViewCell *)[[button  superview] superview];
    self.myIndexPath = [self.tableView indexPathForCell:cell];
    
}
-(void)changeButton:(UIButton *)button
{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定将改地址设置成默认地址?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 111;
    [alert show];

    UITableViewCell *cell = (UITableViewCell *)[[button  superview] superview];
    self.myIndexPath = [self.tableView indexPathForCell:cell];

}


-(void)viewWillAppear:(BOOL)animated
{
    if (self.i == 11) {
        [self custom];

    }
    
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
        
    if (alertView.tag == 110) {
        
    
        
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1) {
            
            
            
            //删除地址
            NSString *member_id = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
            NSString *key = [[NSUserDefaults standardUserDefaults]valueForKey:@"key"];
            self.addressModel = _addressArray[_addressArray.count  - 1 - _myIndexPath.row];
            NSString *addressID = _addressModel.address_id;
            NSDictionary *params = @{@"act":@"member_address",@"op":@"address_del",@"member_id":member_id,@"key":key,@"address_id":addressID};
            
            AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
            
           [manager POST:kMainHttp parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
               
           } success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               [self.addressArray removeObjectAtIndex:_addressArray.count  - 1 - _myIndexPath.row];
               [self.tableView deleteRowsAtIndexPaths:@[_myIndexPath] withRowAnimation:UITableViewRowAnimationFade];
               
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
           }];
            
            
            
        }

    
    }else if (alertView.tag == 111) {
        
        
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1) {
            
            
            
            //设置默认地址
            NSString *member_id = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
            NSString *key = [[NSUserDefaults standardUserDefaults]valueForKey:@"key"];
            
            self.addressModel = _addressArray[_addressArray.count  - 1 - _myIndexPath.row];
            
            NSLog(@"%lu  %ld",(unsigned long)self.addressArray.count,(long)self.myIndexPath.row);
            
            NSLog(@"%lu",self.addressArray.count - 1 - self.myIndexPath.row);
            
            
            
            NSString *addressID = _addressModel.address_id;
            
            NSDictionary *params = @{@"act":@"member_address",@"op":@"default_address",@"member_id":member_id,@"key":key,@"address_id":addressID};
            
            AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
            
            [manager POST:kMainHttp parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                              [self layoutAddress];
                
                [[NSUserDefaults standardUserDefaults]setValue:_addressModel.address forKey:@"address"
                 ];
                
                
                
                    if ([self.delegate respondsToSelector:@selector(senderAddress:)]) {
                        [self.delegate senderAddress:_addressModel.address];
                        
                    }
                
                [[NSUserDefaults standardUserDefaults] setValue:_addressModel.address forKey:@"address"];
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            
            
            
        }

        
        
        
        
        
        
        
    }else if (alertView.tag == 133) {
        
        if (buttonIndex == 0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }
    

}


//********************************地址编辑***************************************
-(void)layoutAddress
{
    self.title = @"地址管理";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.myArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kMainWidth, kMainHeight - 124)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"addressTableViewCell" bundle:nil] forCellReuseIdentifier:@"addressCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:MainBackGround];;
    
    //添加
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"img_add.png"] forState:(UIControlStateNormal)];
    [button setTintColor:[UIColor whiteColor]];
    [button setFrame:CGRectMake(0, 0, 25, 25)];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(add) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
    

    [self custom];

}

-(void)custom
{
    //数据请求
    
    self.addressArray = [[NSMutableArray alloc]init];
    NSString *key = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
    NSString *member = [[NSUserDefaults standardUserDefaults] valueForKey:@"member_id"];
    NSString *url = [NSString stringWithFormat:@"%@?act=member_address&op=address_list&member_id=%@&key=%@",kMainHttp,member,key];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (!([[responseObject valueForKey:@"datas"] valueForKey:@"error"])) {
            
            NSMutableArray *array = [[responseObject valueForKey:@"datas"] valueForKey:@"list"];
            for (NSDictionary *dic in array) {
                AddressModel *addressModel = [[AddressModel alloc]init];
                [addressModel setValuesForKeysWithDictionary:dic];
                [self.addressArray addObject:addressModel];
                
            }
            NSLog(@"%ld",_addressArray.count);
            
            [self.tableView reloadData];//刷新;
            
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}



-(void)add
{
    SureViewController *sure = [[SureViewController alloc]init];
    sure.j = 11;

    
    
    
    [self.navigationController pushViewController:sure animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    if (self.i == 11) {
        [super viewDidAppear:animated];
        [_tableView reloadData];
    }
    
}
//***********************************修改密码********************************
-(void)layoutPassword
{
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, kMainWidth - 20, 50)];
    [imageView setImage:[UIImage imageNamed: @"+86框.png"]];
    [imageView setUserInteractionEnabled:YES];;
    [self.view addSubview:imageView];
    
    self.phoneField = [[UITextField alloc]initWithFrame:CGRectMake(imageView.frame.size.width/7 , 0, imageView.frame.size.width - imageView.frame.size.width/7 , 50)];
    [self.phoneField setAttributedPlaceholder:KMainPlaceholder(@"请输入您的手机号")];;
    [self.phoneField setKeyboardType:UIKeyboardTypeNumberPad];;
    [self.phoneField setDelegate:self];;
    [imageView addSubview:self.phoneField];
    
    
     UIButton *verifyButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [verifyButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [verifyButton.titleLabel setFont:[UIFont systemFontOfSize:13]];;
    [verifyButton addTarget:self action:@selector(verify:) forControlEvents:(UIControlEventTouchUpInside)];
    [verifyButton setFrame:CGRectMake(kMainWidth - 20 -90, 80, 90, 50)];;
    [self.view addSubview:verifyButton];
    
    
     UIImageView *codeimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, imageView.frame.origin.y +70, kMainWidth - 20, 50)];
    [codeimageView setImage:[UIImage imageNamed: @"背景框.png"]];
    [codeimageView setUserInteractionEnabled:YES];;
    [self.view addSubview:codeimageView];
    
     self.codeField = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, kMainWidth - 40, 50)];
    [self.codeField setAttributedPlaceholder:KMainPlaceholder(@"请输入验证码")];
    [self.codeField setDelegate:self];;
    [self.codeField setKeyboardType:UIKeyboardTypeNumberPad];
    [codeimageView addSubview:self.codeField];
    
     self.nextButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.nextButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.nextButton addTarget:self action:@selector(sure) forControlEvents:(UIControlEventTouchUpInside)];
    [self.nextButton.titleLabel setFont:MyButtonFont];
    [self.nextButton setFrame:CGRectMake(10, codeimageView.frame.origin.y + 100, kMainWidth - 20, 50)];
    [self.nextButton setBackgroundColor:COLOR(49, 219, 224, 1)];;
    [self.nextButton setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.nextButton];
    

}



//获取验证码
-(void)verify:(UIButton *)button
{
    
    if (self.i == 14) {
    
    if ([CommUtils validatePhoneNumber:self.phoneField.text]) {
        
        NSString *url = [NSString stringWithFormat:@"%@?act=member_security&op=send_modify_mobile&mobile=%@",kMainHttp,self.phoneField.text];
        NSLog(@"  wode url = = %@",url);
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"%@",[responseObject valueForKey:@"code"]);
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
            
            
        }];
        
        
        
    }else {
        
        UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号有误 " delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [aller show];
        
        
        
    }
    

    }else if(self.i == 15){
        
        
        if ([CommUtils validateEmail:self.phoneField.text]) {
            
            

            NSString *url = [NSString stringWithFormat:@"%@?act=member_security&op=send_bind_email&email=%@",kMainHttp,self.phoneField.text];
            NSLog(@"  wode url = = %@",url);
            
            AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
            
            [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"%@",[responseObject valueForKey:@"code"]);
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"%@",error);
                
                
            }];
            
            
            
        }else {
            
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号有误 " delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [aller show];
            
            
            
        }

        
        
        
        
    }else if (self.i ==12){
        if ([CommUtils validatePhoneNumber:self.phoneField.text]) {
            
            NSString *url = [NSString stringWithFormat:@"%@?act=member_security&op=send_modify_mobile&mobile=%@",kMainHttp,self.phoneField.text];
            NSLog(@"  wode url = = %@",url);
            
            AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
            
            [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"%@",[responseObject valueForKey:@"code"]);
                
                
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"%@",error);
                
                
            }];
            
            
            
        }else {
            
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号有误 " delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [aller show];
            
            
            
        }

    }
    
}



//sureButton的点击事件
-(void)sure
{
    ClickTViewController *clicktView = [[ClickTViewController alloc]init];
    
    if (self.i == 12) {
        
        clicktView.coder = self.codeField.text;
        clicktView.phonge = self.phoneField.text;
        
        
        clicktView.k = 100;
        [self.navigationController pushViewController:clicktView animated:YES];
        
    }else if (self.i == 14 ) {

        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
    
}


//********************************活动介绍*********************************

-(void)layoutIntroduce
{
    self.title = @"活动介绍";
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kMainWidth, kMainHeight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(0, kMainHeight*2);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    UIImageView *freeimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    freeimage.image = [UIImage imageNamed:@"试用流程.png"];
    [scrollView addSubview:freeimage];
    
    UILabel *freelable = [[UILabel alloc]initWithFrame:CGRectMake(34, 10, 100, 20)];
    freelable.font = [UIFont systemFontOfSize:12];
    freelable.textColor = COLOR(245, 141, 39, 1);
    freelable.text = @"免费试用流程";
    [scrollView addSubview:freelable];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, kMainWidth - 20, 100)];
    textLabel.text = @"    北京你车我车电子商务股份有限公司所创建的你车我车是中国最大的汽车用品网购平台，也是中国最专业的汽车用品信息发布平台。这里汇聚了上千家世界一流的汽车用品厂商和5万余家汽车用品线下服务商，并通过便捷的平台操作使B2B、B2C、O2O等多种商业模式的融合成为可能。——你车我车顺势而生！";
    textLabel.textColor = COLOR(80, 80, 80, 1);
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont  systemFontOfSize:10];
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [textLabel sizeThatFits:CGSizeMake(textLabel.frame.size.width, MAXFLOAT)];
    textLabel.frame =  CGRectMake(10, 30, kMainWidth - 20, size.height);
    [scrollView addSubview: textLabel];
    
    
    UIImageView *shiyongImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 35 + size.height, kMainWidth - 20, kMainHeight/4)];
    shiyongImage.image = [UIImage imageNamed:@"测试结果.png"];
    [scrollView addSubview:shiyongImage];
    
    
    UIImageView *chakanimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, shiyongImage.frame.origin.y + kMainHeight/4 + 10, 20, 20)];
    chakanimage.image = [UIImage imageNamed:@"查看试用结果.png"];
    [scrollView addSubview:chakanimage];
    
    UILabel *chakanlable = [[UILabel alloc]initWithFrame:CGRectMake(34, chakanimage.frame.origin.y, 100, 20)];
    chakanlable.font = [UIFont systemFontOfSize:12];
    chakanlable.textColor = COLOR(245, 141, 39, 1);
    chakanlable.text = @"查看试用结果";
    [scrollView addSubview:chakanlable];
    
    UILabel *jieguoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, chakanimage.frame.origin.y + 15, kMainWidth - 20, 100)];
    jieguoLabel.text = @"    北京你车我车电子商务股份有限公司所创建的你车我车是中国最大的汽车用品网购平台，也是中国最专业的汽车用品信息发布平台。这里汇聚了上千家世界一流的汽车用品厂商和5万余家汽车用品线下服务商，并通过便捷的平台操作使B2B、B2C、O2O等多种商业模式的融合成为可能。——你车我车顺势而生！";
    jieguoLabel.textColor = COLOR(80, 80, 80, 1);
    jieguoLabel.numberOfLines = 0;
    jieguoLabel.font = [UIFont  systemFontOfSize:10];
    jieguoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize chakanSize = [jieguoLabel sizeThatFits:CGSizeMake(jieguoLabel.frame.size.width, MAXFLOAT)];
    jieguoLabel.frame =  CGRectMake(10, chakanimage.frame.origin.y + 20, kMainWidth - 20, chakanSize.height);
    [scrollView addSubview: jieguoLabel];
    
    UIImageView *liziImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 + jieguoLabel.frame.origin.y + chakanSize.height, kMainWidth - 20, kMainHeight/4)];
    liziImage.image = [UIImage imageNamed:@"例子.png"];
    [scrollView addSubview:liziImage];
    
    
    
    UIImageView *tijiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, liziImage.frame.origin.y + kMainHeight/4 + 10, 20, 20)];
    tijiaoImage.image = [UIImage imageNamed:@"试用报告小.png"];
    [scrollView addSubview:tijiaoImage];
    
    UILabel *tijiaoLable = [[UILabel alloc]initWithFrame:CGRectMake(34, tijiaoImage.frame.origin.y, 100, 20)];
    tijiaoLable.font = [UIFont systemFontOfSize:12];
    tijiaoLable.textColor = COLOR(245, 141, 39, 1);
    tijiaoLable.text = @"提交试用报告";
    [scrollView addSubview:tijiaoLable];

    UILabel *tijiaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, tijiaoImage.frame.origin.y + 25, kMainWidth - 20, 100)];
    tijiaoLabel.text = @"    北京你车我车电子商务股份有限公司所创建的你车我车是中国最大的汽车用品网购平台，也是中国最专业的汽车用品信息发布平台。这里汇聚了上千家世界一流的汽车用品厂商和5万余家汽车用品线下服务商，并通过便捷的平台操作使B2B、B2C、O2O等多种商业模式的融合成为可能。——你车我车顺势而生！";
    tijiaoLabel.textColor = COLOR(80, 80, 80, 1);
    tijiaoLabel.numberOfLines = 0;
    tijiaoLabel.font = [UIFont  systemFontOfSize:10];
    tijiaoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize tijiaoSize = [tijiaoLabel sizeThatFits:CGSizeMake(tijiaoLabel.frame.size.width, MAXFLOAT)];
    tijiaoLabel.frame =  CGRectMake(10, tijiaoImage.frame.origin.y + 20, kMainWidth - 20, tijiaoSize.height);
    [scrollView addSubview: tijiaoLabel];
    scrollView.contentSize = CGSizeMake(0, size.height + chakanSize.height + tijiaoSize.height + 190 + kMainHeight / 2 );
    
    
    
    
    
    
}
//********************************关于我们*********************************
-(void)layoutOurs
{
    self.title = @"关于我们";
    self.tabBarController.tabBar.hidden = YES;

    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.backgroundColor = MainBackGround;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.nichewoche.com/mobile/protocol/about.html"]];
    [self.view addSubview:webView];
    [webView loadRequest:request];
 
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
//********************************用户反馈*********************************
-(void)layoutBack
{
    self.title = @"用户反馈";
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, kMainWidth - 20, kMainHeight/4)];
    imageView.image = [UIImage imageNamed:@"用户反馈.png"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    self.textView = [[ZWTextView alloc]initWithFrame:CGRectMake(10, 10, imageView.frame.size.width - 20, imageView.frame.size.height - 20)];
    self.textView.placeholder = @"你车我车感谢您的支持";
    self.textView.font =  [UIFont fontWithName:@"Arial" size:16.0];
    self.textView.delegate = self;
    
    self.textView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.textView.layer.borderWidth =1.0;
    
    
    
    [imageView addSubview:self.textView];
    

    self.button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button.frame = CGRectMake(10, imageView.frame.origin.y + kMainHeight/4 +30 , kMainWidth - 20, kMainWidth/9);
    
    [self.button setBackgroundImage:[UIImage imageNamed:@"登录注册按钮背景.png"] forState:(UIControlStateNormal)];
    [self.button setTitle:@"提交" forState:(UIControlStateNormal)];
    [self.button addTarget:self action:@selector(tijiao:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.button setTintColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.button];

    
    
}

-(void)tijiao:(UIButton *)button
{
    
    NSString *key = [[NSUserDefaults  standardUserDefaults] valueForKey:@"key"];
    
    

    //上传数据
    
    NSDictionary *params = @{@"act":@"member_feedback",@"op":@"feedback_add",@"key":key,@"feedbook":self.textView.text};

    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:kMainHttp parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {


        NSLog(@"%@",[responseObject valueForKey:@"datas"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
           }];
        
         
    }

   


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [self.textView  resignFirstResponder];
}

//键盘回收
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.phoneField resignFirstResponder];
    [self.codeField resignFirstResponder];
}

//********************************布局更改手机号*********************************
-(void)layoutPhotoNamber
{
    self.title = @"修改手机号";
    
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, kMainWidth - 20, 50)];
    imageView.image = [UIImage imageNamed: @"+86框.png"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    self.phoneField = [[UITextField alloc]initWithFrame:CGRectMake(kMainWidth / 8 + 20, 0, kMainWidth *3/4, 50)];
    self.phoneField.placeholder = @"请输入您的手机号";
    self.phoneField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneField.delegate = self;
    [imageView addSubview:self.phoneField];

    
    UIImageView *codeimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, imageView.frame.origin.y +70, kMainWidth - 20, 50)];
    codeimageView.image = [UIImage imageNamed: @"获取验证码框.png"];
    codeimageView.userInteractionEnabled = YES;
    [self.view addSubview:codeimageView];
    
    
    
    UIButton *verifyButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    verifyButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [verifyButton addTarget:self action:@selector(verify:) forControlEvents:(UIControlEventTouchUpInside)];
    verifyButton.frame = CGRectMake(0, 0, kMainWidth/5, 50);
    [codeimageView addSubview:verifyButton];
    
    self.codeField = [[UITextField alloc]initWithFrame:CGRectMake(imageView.frame.size.width/5 + 20, 0, imageView.frame.size.width - imageView.frame.size.width/5 - 20 , 50)];
    
    self.codeField.placeholder = @"请输入验证码";
    self.codeField.delegate = self;
    self.codeField.keyboardType = UIKeyboardTypeNumberPad;
    [codeimageView addSubview:self.codeField];
    
    self.nextButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.nextButton setTitle:@"确定" forState:(UIControlStateNormal)];
    
    [self.nextButton addTarget:self action:@selector(surePhone) forControlEvents:(UIControlEventTouchUpInside)];
    self.nextButton.titleLabel.font = MyButtonFont;
    self.nextButton.frame = CGRectMake(10, codeimageView.frame.origin.y + 100, kMainWidth - 20, 50);
    self.nextButton.backgroundColor = COLOR(49, 219, 224, 1);
    [self.nextButton setTintColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.nextButton];


    
}

-(void)surePhone
{
  
    if ( [CommUtils validatePhoneNumber:self.phoneField.text]) {
        
        if ([self.delegate respondsToSelector:@selector(coderNstring:moblePhone:)]) {
            [self.delegate coderNstring:self.codeField.text moblePhone:self.phoneField.text];
            
        }
        
        
        NSString *memeber_id = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
        NSString *key = [[NSUserDefaults standardUserDefaults]valueForKey:@"key"];

        NSDictionary *parameters = @{@"act":@"login",@"op":@"edituser",@"member_id":memeber_id,@"key":key,@"code":self.codeField,@"mobile":self.phoneField.text,};
        
        
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        [manager POST:kMainHttp parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([[responseObject valueForKey:@"datas"] valueForKey:@"error"]) {
                UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:[[responseObject valueForKey:@"datas"] valueForKey:@"error"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [ale show];
            }else {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        
        
    }else {
        
        UIAlertView *ale= [[UIAlertView alloc]initWithTitle:@"提示" message:@"格式有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [ale show];
        
    }

    
    
  
    
    
}

//********************************布局更改邮箱*********************************
-(void)layoutEmail
{
    self.title = @"更改邮箱";

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, kMainWidth - 20, 50)];
    imageView.image = [UIImage imageNamed: @"背景框.png"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    self.phoneField = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, imageView.frame.size.width -20, 50)];
    self.phoneField.attributedPlaceholder = KMainPlaceholder(@"请输入您的邮箱");
    self.phoneField.delegate = self;
    [imageView addSubview:self.phoneField];
    
    
    
    UIImageView *codeimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, imageView.frame.origin.y +70, kMainWidth - 20, 50)];
    codeimageView.image = [UIImage imageNamed: @"获取验证码框.png"];
    codeimageView.userInteractionEnabled = YES;
    [self.view addSubview:codeimageView];
    
    
    
    UIButton *verifyButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    verifyButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [verifyButton addTarget:self action:@selector(verify:) forControlEvents:(UIControlEventTouchUpInside)];
    verifyButton.frame = CGRectMake(0, 0, kMainWidth/5, 50);
    [codeimageView addSubview:verifyButton];
    
    self.codeField = [[UITextField alloc]initWithFrame:CGRectMake(imageView.frame.size.width/5 + 20, 0, imageView.frame.size.width - imageView.frame.size.width/5 - 20 , 50)];
    
    self.codeField.attributedPlaceholder = KMainPlaceholder(@"请输入您的邮箱验证码");
    self.codeField.delegate = self;
    self.codeField.keyboardType = UIKeyboardTypeNumberPad;
    [codeimageView addSubview:self.codeField];
    
    self.nextButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    [self.nextButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.nextButton addTarget:self action:@selector(changeEmail) forControlEvents:(UIControlEventTouchUpInside)];
    [self.nextButton.titleLabel setFont:MyButtonFont];
    [self.nextButton setFrame:CGRectMake(10, codeimageView.frame.origin.y + 100, kMainWidth - 20, 50)];
    [self.nextButton setBackgroundColor:COLOR(49, 219, 224, 1)];
    [self.nextButton setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.nextButton];
    

}
-(void)changeEmail
{

    if ( [CommUtils validateEmail:self.phoneField.text]&&[CommUtils validateNumber:self.codeField.text]) {

        if ([self.delegate respondsToSelector:@selector(codernstring:email:)]) {
            [self.delegate codernstring:self.codeField.text email:self.phoneField.text];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        
    }else {
        
        UIAlertView *ale= [[UIAlertView alloc]initWithTitle:@"提示" message:@"格式有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [ale show];
        
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
