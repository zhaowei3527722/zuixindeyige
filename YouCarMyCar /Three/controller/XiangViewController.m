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
@interface XiangViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableDictionary *dic;
@property (nonatomic,strong)UIView *myView;
@property (nonatomic,strong)UIImage *myimage;
@property (nonatomic,strong)NSArray *sexArray;
@property (nonatomic,copy)NSString *str;
@end

@implementation XiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //布局view
    [self layoutView];

    
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

    
    //右item
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setFrame:CGRectMake(0, 0, 45, 25)];
    [button setTitle:@"完成" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(wancheng)
                       forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
    
    
}


//完成的点击事件
-(void)wancheng
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
        [self.navigationController pushViewController:clichVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 4) {
        clichVC.i = 11;
        [self.navigationController pushViewController:clichVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 5) {
        clichVC.i = 12;
        [self.navigationController pushViewController:clichVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1){
        clichVC.i = 14;
        [self.navigationController pushViewController:clichVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 2) {
        clichVC.i = 15;
        [self.navigationController pushViewController:clichVC animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        
        NSLog(@"退出登录");
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    NSArray *array = [self.dic valueForKey:[NSString stringWithFormat:@"%ld",
                                               (long)indexPath.section]];
    NSString *str = array[indexPath.row];
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        TouxiangTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.photoImage.layer.cornerRadius = cell.photoImage.frame.size.height/2;
        cell.photoImage.layer.masksToBounds = YES;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.photoImage.image = self.myimage;
        cell.backimage.image = self.myimage;
        cell.superview.superview.backgroundColor = MainBackGround;
        
        
        [cell.xiaoImage removeFromSuperview];
        [cell.nameLable removeFromSuperview];
        [cell.photoImage setUserInteractionEnabled:YES];
        //轻怕手势
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(push:)];
        self.view.userInteractionEnabled = YES;
        [cell.photoImage addGestureRecognizer:tap1];
        
        return cell;
        
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        
        
        DataNameTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"nameCell" forIndexPath:indexPath];
        cell.nameLable.text = str;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
        return cell;
        
        
    }else if (indexPath.section == 1 && indexPath.row > 0 && indexPath.row < 6){
        
        
        
        DataSexTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"sexCell" forIndexPath:indexPath];
        cell.sexLable.text = str;
        cell.sexLable.textColor = [UIColor colorWithRed:15 / 255.0 green:15/ 255.0  blue:15/ 255.0  alpha:1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.myLable.font = [UIFont systemFontOfSize:15];
        if ( indexPath.row == 1) {
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"] == nil) {
                cell.myLable.text = @"请绑定手机号";
                cell.myLable.textColor = COLOR(200, 200, 200, 1);
            }else{
            cell.myLable.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
            }
        }else if ( indexPath.row == 2 ) {
//            cell.myLable.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
        }else if ( indexPath.row == 3 ) {
//            cell.myLable.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"sex"];
        }else if ( indexPath.row == 4 ) {
//            cell.myLable.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"address"];
        }else if ( indexPath.row == 5 ) {
            cell.myLable.text = @"修改密码";
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
        self.myimage = image;
    }else{
        self.myimage = image;
    }
    [self.tableView  reloadData];
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
