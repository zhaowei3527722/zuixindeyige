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
@interface ClickViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate,SureViewControllerDelegate,addressTableViewCellDelegate,UIAlertViewDelegate>
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
    if ([_delegate respondsToSelector:@selector(sender:)]) {
        [_delegate sender:_sexString];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

//********************************活动记录*********************************
-(void)layoutJoinView
{
    self.title = @"活动记录";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
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
                        initWithFrame:CGRectMake(kMainWidth - 40, 25, 20, 20)];
    [self.choiceImage setImage:[UIImage imageNamed:@"性别选择.png"]];
    [self.tableView addSubview:self.choiceImage];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.i == 11 || self.i == 13) {
        return 1;
    }else {
        return 3;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.i == 11) {
        return self.myArray.count;
    }else if (self.i == 13){
        return 4;
    }else{
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
        NSLog(@"这个是活动记录的点击事件");
    }else if (self.i == 13){
        
        if (indexPath.row == 1) {
            [self.choiceImage setFrame:CGRectMake(kMainWidth - 40, 25, 20, 20)];
            self.sexString = @"男";
            [self.tableView addSubview:self.choiceImage];
        }else if (indexPath.row == 2) {
            [self.choiceImage setFrame:CGRectMake(kMainWidth - 40, 75, 20, 20)];
            self.sexString = @"女";
            [self.tableView addSubview:self.choiceImage];
        }else if (indexPath.row == 3) {
            [self.choiceImage setFrame:CGRectMake(kMainWidth - 40, 125, 20, 20)];
            self.sexString = @"保密";
            [self.tableView addSubview:self.choiceImage];
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.i == 11) {

        AddressModel *addressMd = [[AddressModel alloc]init];
        addressMd = _myArray[_myArray.count - 1 - indexPath.row];
        addressTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"addressCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLable.text = addressMd.name;
        cell.phoneLable.text = addressMd.telephone;
        self.bianjiBT = cell.bianjiBT;
        self.shanchuBT = cell.shanchuBT;
        self.bianjiBT.tag = indexPath.row;
        cell.delegate = self;
        cell.backgroundColor = MainBackGround;
        return cell;
        
    }else if (self.i == 13) {
        
        NSString *tag=@"tag";
        NSArray *arr = [[NSArray alloc]initWithObjects:@" ",@"男",@"女",@"保密", nil];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.baoGao setImage:[UIImage imageNamed:@"审核中.png"] forState:(UIControlStateNormal)];
        [cell.baoGao addTarget:self action:@selector(baogao:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.baoGao.tag = indexPath.row ;
        cell.thingImage.image = [UIImage imageNamed:@"2.png"];
        cell.selectionStyle = UITableViewCellAccessoryNone;
            NSLog(@"%ld",(long)indexPath);
        cell.superview.superview.backgroundColor = COLOR(251, 246, 240, 1);
        

        return cell;
       }
    }



-(void)buttonAction1:(UIButton *)button
{

    SureViewController *sure = [[SureViewController alloc]init];
    sure.j = 111;
    sure.addressMd = self.myArray[self.myIndexPath.row];
    [self.navigationController pushViewController:sure animated:YES];
    
    
}

-(void)buttonAction2:(UIButton *)button
{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定删除该地址?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
    
    UITableViewCell *cell = (UITableViewCell *)[[button  superview] superview];
    self.myIndexPath = [self.tableView indexPathForCell:cell];
    
    }

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
        
  
        
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1) {
            
            [self.myArray removeObjectAtIndex:self.myIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[self.myIndexPath] withRowAnimation:(UITableViewRowAnimationFade)];
        }

    
    
    

}

-(void)baogao:(UIButton *)sender
{
    NSLog(@"这个是提交报告 %ld",(long)sender.tag);
}


//********************************地址编辑***************************************
-(void)layoutAddress
{
    self.title = @"地址管理";
    self.myArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"addressTableViewCell" bundle:nil] forCellReuseIdentifier:@"addressCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:MainBackGround];;
    
    //添加
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"添加按钮.png"] forState:(UIControlStateNormal)];
    [button setFrame:CGRectMake(0, 0, 25, 25)];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(add) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
    
    //数据请求
    
//    self.addressArray = [[NSMutableArray alloc]init];
//    NSString *key = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
//    NSString *url = [NSString stringWithFormat:@"%@?act=member_address&op=address_info&key=%@",]
//    
}



-(void)add
{
    SureViewController *sure = [[SureViewController alloc]init];
    sure.j = 11;
    sure.delegate = self;
    
    
    
    [self.navigationController pushViewController:sure animated:YES];
}

-(void)addObjectnameFd:(UITextField *)nameFd addressFd:(UITextField *)addressFd phoneFd:(UITextField *)phoneFd youzhengFd:(UITextField *)youzhengFd
{
    AddressModel *address = [[AddressModel alloc]init];
    address.name = nameFd.text;
    address.telephone = phoneFd.text;
    [self.myArray addObject:address];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.myArray.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationMiddle)];

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

        
        
        
        
    }
    
}



//sureButton的点击事件
-(void)sure
{
    ClickTViewController *clicktView = [[ClickTViewController alloc]init];
    
    if (self.i == 12) {
        
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kMainWidth, kMainHeight)];
    scrollView.backgroundColor = MainBackGround;
    scrollView.contentSize = CGSizeMake(0, kMainHeight*2);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kMainWidth - 20, 60)];
    lable.text = @"关于你车我车";
    lable.font = [UIFont systemFontOfSize:19];
    lable.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:lable];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, kMainWidth-20, kMainHeight )];
    label1.font = [UIFont systemFontOfSize:12];
    label1.numberOfLines = 0;
    label1.lineBreakMode = NSLineBreakByWordWrapping;
    label1.backgroundColor = MainBackGround;
    label1.text = @"      北京你车我车电子商务股份有限公司所创建的你车我车是中国最大的汽车用品网购平台，也是中国最专业的汽车用品信息发布平台。这里汇聚了上千家世界一流的汽车用品厂商和5万余家汽车用品线下服务商，并通过便捷的平台操作使B2B、B2C、O2O等多种商业模式的融合成为可能。——你车我车顺势而生！\n      \n      数据显示：2013年，中国汽车保有量达到1.4亿量，由此产生的汽车用品消费高达5025亿人民币。专家预测，2015年中国的汽车用品带来的产值将达到6300亿。然而，这一庞大的数字的背后，却是中国汽车用品行业电商化发展的严重不足。其根本原因在于中国至今没有一家专业的汽车用品垂直电商平台。在社会消费品电商化的大趋势下,你车我车，专业车品领导者！\n     \n      电子商务的迅猛发展为人们的生活带来了极大的便利，很多时候足不出户便可购遍全球。然而，任何事物都有两面，电商同样也是一把双刃剑：在便利、实惠的背后，是商品质量的不确定性。在非专业领域，如服饰、书籍等商品，由于假货并不影响其适用性，为了方便消费者大可以睁一只眼闭一只眼。然而，在汽车用品这种专业商品领域，消费者几乎对假货“零容忍”——无论多小的纰漏，都会对行车安全造成巨大威胁。汽车用品的专业性决定了其不能和一般社会消费品混     为一谈，只能走垂直电商模式。而中国这么大的汽车用品市场，却没有诞生一家具有全国影响力的垂直电商。\n   \n      专业的车品，需要具有专业素质的电商平台来运作。你车我车来了！我们汇聚了1000多家世界一流的汽车用品厂商，同时建立了庞大的线下加盟服务体系，将中国汽车用品流通渠道彻底电商化升级，实现汽车用品销售、安装一体化。你车我车平台上所有汽车用品均来自厂家直销，在保障专业货源的同时，真正做到了正品低价。你车我车，专业车品领导者！你车我车，开启电商3.0时代！\n    \n      电商1.0时代，企业与企业之间通过B2B电商平台（如阿里巴巴）进行交易，开拓了中国的电商蓝海。\n    \n      电商2.0时代，消费者（C）作为独立的电商角色被加入进来，产生了B2C、C2C，甚至C2B的商业模式，让中国电商真正繁荣起来。而在你车我车，无论B2B、B2C，还是新兴的O2O，都只是商业模式的环节之一。\n        \n      你车我车，开启中国电商3.0时代。你车我车，将线下流通渠道彻底电商化升级，开启中国电商3.0时代！";
    label1.textColor = COLOR(80, 80, 80, 1);
     CGSize size = [label1 sizeThatFits:CGSizeMake(label1.frame.size.width, MAXFLOAT)];
     label1.frame =CGRectMake(10, 60, kMainWidth-20, size.height);
     scrollView.contentSize = CGSizeMake(0, size.height + 150);
     [scrollView addSubview:label1];
    
    
 
    
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
    
    NSLog(@"%@",key);
    
    
    if (key == nil) {
        NSLog(@"去登陆");
    }else if (key != nil) {
    //上传数据
    
    NSDictionary *params = @{@"act":@"member_feedback",@"op":@"feedback_add",@"key":key,@"feedbook":self.textView.text};

    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:kMainHttp parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"成功");
        
        NSLog(@"%@",[responseObject valueForKey:@"datas"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
        
         [self.navigationController popToRootViewControllerAnimated:YES];
    }

   
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
  
    if ( [CommUtils validatePhoneNumber:self.phoneField.text]&&[CommUtils validateNumber:self.codeField.text]) {
        
        if ([self.delegate respondsToSelector:@selector(coderNstring:moblePhone:)]) {
            [self.delegate coderNstring:self.codeField.text moblePhone:self.phoneField.text];
            
        }
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
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
    [self.nextButton setBackgroundColor:MainBackGround];
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
