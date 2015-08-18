//
//  XiangViewController.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/1.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "XiangViewController.h"
#import "TouxiangTableViewCell.h"
#import "PrefixHeader.pch"
#import "ClickViewController.h"
#import "DataNameTableViewCell.h"
#import "DataSexTableViewCell.h"
#import "TuiChuTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "JSONKit.h"
#import "Urljson.h"
#import "CommUtils.h"


@interface XiangViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,ClickViewControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableDictionary *dic;
@property (nonatomic,strong)UIView *myView;
@property (nonatomic,strong)UIImage *myimage;
@property (nonatomic,strong)NSArray *sexArray;
@property (nonatomic,copy)NSString *base64string;
@property (nonatomic,copy)NSString *str;
@property (nonatomic,strong)UITextField *myTextF;
@property (nonatomic,strong)UITextField *nameTextField;
@property (nonatomic,strong)UILabel *photoLable;
@property (nonatomic,strong)UILabel *emailLabel;
@property (nonatomic,strong)UILabel *sexLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,copy)NSString *codeString;
@property (nonatomic)BOOL isYes;
@property (nonatomic)BOOL isSex;

@property (nonatomic,strong)UIImageView *myBackImage;
@property (nonatomic,strong)UIImageView *myXiangImage;
@end

@implementation XiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //布局view
    [self layoutView];

    //数据请求
    [self requset];
    
    self.tabBarController.tabBar.hidden = YES;
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"] forState:(UIControlStateNormal)];
    
    button.frame =CGRectMake(0, 0, 15, 25);
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardBounds = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, keyboardBounds.size.height, 0);
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, 0, 0);
}

-(void)pop
{
    [self.navigationController  popToRootViewControllerAnimated:YES];
}


//布局view
-(void)layoutView
{
    
    self.navigationItem.title = @"个人信息";
    
    self.dic = [[NSMutableDictionary alloc]init];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    NSArray *array1 = [[NSArray alloc]initWithObjects:@"用户名",@"手机号",@"邮箱",@"性别",@"地址管理",@"密码服务", nil];
    
    [self.dic setValue:array1 forKey:@"1"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TouxiangTableViewCell" bundle:nil]
                               forCellReuseIdentifier:@"imageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DataNameTableViewCell" bundle:nil]
                               forCellReuseIdentifier:@"nameCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DataSexTableViewCell" bundle:nil]
                               forCellReuseIdentifier:@"sexCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TuiChuTableViewCell" bundle:nil]
                               forCellReuseIdentifier:@"tuichuCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.myimage = [UIImage imageNamed:@"2.png"];
    [self.view addSubview:self.tableView];

    
    self.isYes = YES;
    //右item
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setFrame:CGRectMake(0, 0, 45, 25)];
    [button setTitle:@"完成" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(wancheng)
                       forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
    
    self.myBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 155)];
     NSURL *url = [[NSUserDefaults standardUserDefaults]valueForKey:@"avatar"];
    [self.myBackImage sd_setImageWithURL:url];
    [self.tableView addSubview:self.myBackImage];
    
    UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualEfView.frame = CGRectMake(0, 0, kMainWidth, 155);
    visualEfView.alpha = 1.0;
    [self.myBackImage addSubview:visualEfView];
    
    self.myXiangImage = [[UIImageView alloc]initWithFrame:CGRectMake(kMainWidth/2 - 40, 20, 80, 80)];
    [self.myXiangImage sd_setImageWithURL:url];
   self.myXiangImage.layer.cornerRadius = self.myXiangImage.frame.size.height/2;
    self.myXiangImage.layer.masksToBounds = YES;
    self.myXiangImage.userInteractionEnabled = YES;
    [self.tableView addSubview:self.myXiangImage];
    
    //轻怕手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(push:)];
    self.view.userInteractionEnabled = YES; 
    [self.myXiangImage addGestureRecognizer:tap1];
    
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(kMainWidth - 210, 165, 200, 21)];
    if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"member_truename"] isEqualToString:@""]) {
        self.nameTextField.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_truename"];
    }else{
        self.nameTextField.placeholder = @"添加昵称";
    }
    self.nameTextField.font = [UIFont systemFontOfSize:14];
    self.nameTextField.textAlignment = NSTextAlignmentRight;
    [self.tableView addSubview:self.nameTextField];
    
    
    self.photoLable = [[UILabel alloc]initWithFrame:CGRectMake(kMainWidth - 240, 205, 200, 21)];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"mobile"] isEqualToString:@""]) {
        self.photoLable.text = @"请绑定手机号";
        self.photoLable.textColor = COLOR(200, 200, 200, 1);
    }else{
        self.photoLable.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"mobile"];
    }
    self.photoLable.font = [UIFont systemFontOfSize:14];
    self.photoLable.textAlignment = NSTextAlignmentRight;
    [self.tableView addSubview:self.photoLable];
    
    self.emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMainWidth - 240, 245, 200, 21)];
    
    if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"email"] isEqualToString:@""]) {
        self.emailLabel.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    }else{
        self.emailLabel.text = @"请绑定邮箱";
        self.emailLabel.textColor = COLOR(200, 200, 200, 1);
    }
    self.emailLabel.font = [UIFont systemFontOfSize:14];
    self.emailLabel.textAlignment = NSTextAlignmentRight;
    [self.tableView addSubview:self.emailLabel];
    
    self.sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMainWidth - 240, 285, 200, 21)];
    
    if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"sex"] isEqualToString:@""]) {
        self.sexLabel.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"sex"];
    }else{
        self.sexLabel.text = @"请选择性别";
        self.sexLabel.textColor = COLOR(200, 200, 200, 1);
    }
    self.sexLabel.font = [UIFont systemFontOfSize:14];
    self.sexLabel.textAlignment = NSTextAlignmentRight;
    [self.tableView addSubview:self.sexLabel];
    
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMainWidth - 240, 325, 200, 21)];
    if ( ![[[NSUserDefaults standardUserDefaults]valueForKey:@"address"] isEqual: @"1"]) {
        self.addressLabel.text =[[NSUserDefaults standardUserDefaults]valueForKey:@"address"];
    }else{
        self.addressLabel.text = @"添加地址";
        self.addressLabel.textColor = COLOR(200, 200, 200, 1);
    }
    self.addressLabel.font = [UIFont systemFontOfSize:14];
    self.addressLabel.textAlignment = NSTextAlignmentRight;
    [self.tableView addSubview:self.addressLabel];

    
    
    
}

-(void)requset
{
}


//完成的点击事件
-(void)wancheng
{
    
    NSString *memeber_id = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
    NSString *key = [[NSUserDefaults standardUserDefaults]valueForKey:@"key"];

    
    NSData  *imageData = UIImageJPEGRepresentation(self.myXiangImage.image, 1.0);
    self.base64string = [imageData base64Encoding];
    
    self.codeString = @"";

    if ([_emailLabel.text isEqualToString:@"请绑定邮箱"]) {
        _emailLabel.text = @"";
    }
    
    
    NSLog(@"%@",self.nameTextField.text);
    NSLog(@"%@",self.codeString);
    NSLog(@"%@",self.sexLabel.text);
    NSLog(@"%@",self.photoLable.text);
    NSLog(@"%@",self.emailLabel.text);
    NSDictionary *parameters = @{@"act":@"login",@"op":@"edituser",@"member_id":memeber_id,@"key":key,@"sex":self.sexLabel.text,@"truename":self.nameTextField.text,@"avatar":self.base64string,@"code":self.codeString,@"mobile":self.photoLable.text,@"email":self.emailLabel.text};
    NSLog(@"%@",parameters);
    NSLog(@"%@",self.emailLabel.text);
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kMainHttp parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@" responeObject = %@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    

//    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)sender:(NSString *)sexString
{
    self.sexLabel.textColor = [UIColor blackColor];
    self.sexLabel.text = sexString;
}
-(void)codernstring:(NSString *)coder email:(NSString *)email
{
    self.emailLabel.textColor = [UIColor blackColor];
    self.emailLabel.text =email;
    self.codeString = coder;
}
-(void)coderNstring:(NSString *)coder moblePhone:(NSString *)moblePhone
{
    self.photoLable.text = moblePhone;
    self.codeString = coder;
}
-(void)senderAddress:(NSString *)addressStr
{
    self.addressLabel.text = addressStr;
    NSLog(@"%@",addressStr);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 6;
    }else{
        return 1;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 155;
        
    }else{
        return 40;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 10;
    }else{
        return 0;
    }
}


//cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClickViewController *clichVC = [[ClickViewController alloc]init];
    clichVC.i = 10;
    if (indexPath.section == 1 && indexPath.row == 3 ){
        clichVC.i = 13;
        clichVC.delegate = self;
        [self.navigationController pushViewController:clichVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 4) {
        clichVC.i = 11;
        clichVC.delegate = self;
        [self.navigationController pushViewController:clichVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 5) {
        clichVC.i = 12;
        [self.navigationController pushViewController:clichVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1){
        clichVC.i = 14;
        clichVC.delegate = self;
        [self.navigationController pushViewController:clichVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 2) {
        clichVC.i = 15;
        clichVC.delegate = self;
        [self.navigationController pushViewController:clichVC animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        
        if (![[[NSUserDefaults standardUserDefaults]valueForKey:@"key"] isEqualToString:@""]) {
            AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            //申明请求的数据是json类型
            manager.requestSerializer=[AFJSONRequestSerializer serializer];
            //如果报接受类型不一致请替换一致text/html或别的
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            NSString *key = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
            NSString  *member_id = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
            NSLog(@" - - - - - - - -%@%@",key,member_id);
            
            NSString *url = [NSString stringWithFormat:@"%@?act=login&op=outlogin&member_id=%@&key=%@",kMainHttp,member_id,key];
            
            NSString *urlF8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [manager GET:urlF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                
                if ([[responseObject valueForKey:@"datas"] valueForKey:@"status"]) {
                    
                    NSLog(@"%@",[[responseObject valueForKey:@"datas"] valueForKey:@"status"]);
                    
                    UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注销成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [aller show];
                    
                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"key"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"member_id"];
                    
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (error) {
                    NSLog(@"错误 = = %@",error);
                    
                    
                }
            }];
            

        }else {
            
            UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aller show];

        }
        
             NSLog(@"退出登录");
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    NSArray *array = [self.dic valueForKey:[NSString stringWithFormat:@"%ld",
                                               (long)indexPath.section]];
    NSString *str = array[indexPath.row];
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        TouxiangTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
        
        [cell.photoImage removeFromSuperview];
        [cell.xiaoImage removeFromSuperview];
        [cell.nameLable removeFromSuperview];
        [cell.backimage removeFromSuperview];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        cell.superview.superview.backgroundColor = MainBackGround;
        
       
        
        return cell;
        
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        
        
        DataNameTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"nameCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.nameField removeFromSuperview];
        cell.nameLable.text = str;
        
        return cell;
        
    }else if (indexPath.section == 1 && indexPath.row > 0 && indexPath.row < 6){
        
        DataSexTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"sexCell" forIndexPath:indexPath];
        cell.sexLable.text = str;
        cell.sexLable.textColor = [UIColor colorWithRed:15 / 255.0 green:15/ 255.0  blue:15/ 255.0  alpha:1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.myLable.font = [UIFont systemFontOfSize:15];
        if ( indexPath.row == 5) {
            cell.myLable.text = @"修改密码";
            cell.myLable.textColor = COLOR(100, 100, 100, 1);
        }
        return cell;
        
    }else  {
        
        TuiChuTableViewCell *cell = [self.tableView
                                     dequeueReusableCellWithIdentifier:@"tuichuCell"
                                     forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;

    }
}

//头像的点击事件
-(void)push:(UITapGestureRecognizer *)tap
{
    
    self.isYes = NO;
    
    UIAlertController  *view=   [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;//设置UIImagePickerController的代理，同时要遵循UIImagePickerControllerDelegate，UINavigationControllerDelegate协议
            picker.allowsEditing = YES;//设置拍照之后图片是否可编辑，如果设置成可编辑的话会在代理方法返回的字典里面多一些键值。PS：如果在调用相机的时候允许照片可编辑，那么用户能编辑的照片的位置并不包括边角。
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;//UIImagePicker选择器的类型，UIImagePickerControllerSourceTypeCamera调用系统相机
            [self presentViewController:picker animated:YES completion:nil];
        }
        else{
            //如果当前设备没有摄像头
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"哎呀，当前设备没有摄像头。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }

    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing = YES;//是否可以对原图进行编辑
            
            //打开相册选择照片
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"图片库不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
        

    }];
    [view addAction:cancelAction];
    [view addAction:deleteAction];
    [view addAction:archiveAction];
    [self presentViewController:view animated:YES completion:nil];
}





//取消选择照片
-(void)cancel:(UIButton *)button
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;//是否可以对原图进行编辑
        
        //打开相册选择照片
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"图片库不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
}


// 点击图片触发
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"如果允许编辑%@",info);//picker.allowsEditing= YES允许编辑的时候 字典会多一些键值。
    //获取图片
    //    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];//原始图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];//编辑后的图片
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//把图片存到图片库
        self.myBackImage.image = image;
        self.myXiangImage.image = image;
        
    }else{
        self.myBackImage.image = image;
        self.myXiangImage.image = image;;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
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
