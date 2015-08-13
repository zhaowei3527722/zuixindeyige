//
//  LiftButtonViewController.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/29.
//  Copyright (c) 2015年 LLY. All rights reserved.
//


#define kZwTextViewWidth (self.zwTextView.frame.size.width)
#define kZwTextViewHeight (self.zwTextView.frame.size.height)


#import "LiftButtonViewController.h"
#import "PrefixHeader.pch"
#import "ShiYongTitleTableViewCell.h"
#import "EvaluateTableViewCell.h"
#import "GradeTableViewCell.h"
#import "Evaluate2TableViewCell.h"
#import "TiJiaoTableViewCell.h"
#import "ZWTextView.h"
#import "XieYiViewController.h"
#import "AFNetworking.h"

#import "CommUtils.h"

@interface LiftButtonViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,GradeTableViewCellDelegate>
@property (nonatomic,strong)UITableView *shiYongTableView;
@property (nonatomic,strong)ZWTextView *zwTextView;
@property (nonatomic,strong)UIImageView *zhaoxiangImage;
@property (nonatomic)BOOL change;
@property (nonatomic ,strong)EvaluateTableViewCell *myCell;

@property (nonatomic,strong)ZWTextView *wai;
@property (nonatomic ,strong)ZWTextView *zhi;
@property (nonatomic ,strong)ZWTextView *jia;
@property (nonatomic )NSInteger numberXing;
@property (nonatomic ,strong)NSString *base64string;
@property (nonatomic , strong)NSString *md5String;



@end

@implementation LiftButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%@",self.wangqiModel.title);
    
    self.isOne = YES;
    self.isTow = YES;
    self.isThree = YES;
    self.isFour = YES;
    self.isFive = YES;
    
    self.title = @"试用报告";
    self.view .backgroundColor = MainBackGround;
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@"向左白色箭头.png"]
                         forState :(UIControlStateNormal)];
    [button setFrame:CGRectMake(0, 0, 15, 25)];
    [button addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *lift = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = lift;
    
    
    //布局试用报告
    [self layoutshiYongTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}



//布局试用报告
-(void)layoutshiYongTableView
{
    self.shiYongTableView = [[UITableView alloc]
                             initWithFrame:self.view.bounds];
    
    self.shiYongTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shiYongTableView];
    
    self.shiYongTableView.delegate = self;
    self.shiYongTableView.dataSource = self;
    self.shiYongTableView.backgroundColor = MainBackGround;
    
    
    [self.shiYongTableView registerNib:[UINib
                                        nibWithNibName:@"ShiYongTitleTableViewCell"
                                        bundle:nil]
                forCellReuseIdentifier:@"shiyongCell"];
    [self.shiYongTableView registerNib:[UINib
                                        nibWithNibName:@"EvaluateTableViewCell"
                                        bundle:nil]
                forCellReuseIdentifier:@"evaluateCell"];
    [self.shiYongTableView registerNib:[UINib
                                        nibWithNibName:@"GradeTableViewCell"
                                        bundle:nil]
                forCellReuseIdentifier:@"gradeCell"];
    [self.shiYongTableView registerNib:[UINib
                                        nibWithNibName:@"Evaluate2TableViewCell"
                                        bundle:nil]
                forCellReuseIdentifier:@"evaluate2Cell"];
    [self.shiYongTableView registerNib:[UINib
                                        nibWithNibName:@"TiJiaoTableViewCell"
                                        bundle:nil]
                forCellReuseIdentifier:@"tijiaoCell"];
    
    self.zhaoxiangImage = [[UIImageView alloc]
                           initWithFrame:
                           CGRectMake(kMainWidth - 64, 174, 48, 43)];
    
    
    self.zhaoxiangImage.image = [UIImage imageNamed: @""];
    self.shiYongTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.zhaoxiangImage.userInteractionEnabled = NO;
    [self.shiYongTableView addSubview:self.zhaoxiangImage];
    self.change = YES;
    
    
    
    
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardBounds = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.shiYongTableView.contentInset = UIEdgeInsetsMake(self.shiYongTableView.contentInset.top, 0, keyboardBounds.size.height, 0);
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.shiYongTableView.contentInset = UIEdgeInsetsMake(self.shiYongTableView.contentInset.top, 0, 0, 0);
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 130;
    }else if (indexPath.row >0 && indexPath.row <5) {
        return 90;
    }else {
        return 50;
    }
}

/*
 •	请求参数：
	•	act=try
	•	op=subReport
	•	member_id：会员id
	•	key 登录tokon
	•	try_id：试用id
	•	appearance_info:外观
	•	score:评分
	•	quality_info:质量
	•	price_info:价格
	•	img:图片

 */
//cell 的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        
          NSMutableArray *imageArray = [[NSMutableArray alloc]init];
//        NSDictionary *imageDic = [[];
        
        
        if (self.zhaoxiangImage.image) {
            NSData *imageData = UIImageJPEGRepresentation(self.zhaoxiangImage.image, 1.0);
            self.base64string = [imageData base64Encoding];
            self.md5String = [CommUtils md5:self.base64string];
          //：[{"img":"sdfdsfsfsdfsdfs","type":"jpg","size":"100","width":"12","height":"12","md5":"sssss"}] （数组方式，可
            
        }
        
        NSDictionary *imagedic = @{@"img":self.base64string,@"type":@"jpg",@"size":[NSString stringWithFormat:@"%lu",(unsigned long)self.base64string.length],@"width":[NSString stringWithFormat:@"%f",self.zhaoxiangImage.image.size.width],@"heigth":[NSString stringWithFormat:@"%f",self.zhaoxiangImage.image.size.width],@"md5":self.md5String};
        
        
        
        [imageArray addObject:imagedic];
        
        NSString *mymember_id = [[NSUserDefaults standardUserDefaults]valueForKey:@"member_id"];
        NSString *mykey = [[NSUserDefaults standardUserDefaults]valueForKey:@"key"];
        
        
        NSLog(@"key = %@ id =  %@" ,mykey,mymember_id);
        NSLog(@" == == = = == %@ ===== %@ ====  == =%@",self.wai.text,self.zhi.text ,self.jia.text);
 
        
        /*act=try
         •	op=subReport
         •	member_id：会员id
         •	key 登录tokon
         •	try_id：试用id
         •	appearance_info:外观
         •	score:评分
         •	quality_info:质量
         •	price_info:价格
         •	img:图片
*/
        
        
        
        NSDictionary *parameters = @{@"act":@"try",@"op":@"subReport",@"member_id":mymember_id,@"key":mykey,@"try_id":@"1",@"appearance_info":self.wai,@"score":[NSString stringWithFormat:@"%ld",(long)self.numberXing],@"quality_info":self.zhi,@"price_info":self.jia,@"img":imageArray};
        
        
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        [manager POST:kMainHttp parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
//            NSLog(@"%@",[[responseObject valueForKey:@"datas"] valueForKey:@"img"]);
            
            if ([[responseObject valueForKey:@"datas"] valueForKey:@"error"]) {
                NSLog(@"%@",[[responseObject valueForKey:@"datas"] valueForKey:@"error"]);
                
            }
            
            
            XieYiViewController *xiexieVC= [[XieYiViewController alloc]init];
            xiexieVC.k = 1;
            
            [self.navigationController   pushViewController:xiexieVC animated:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
            
            
        }];
        
        
        
        
       
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0 ) {
        
        
        ShiYongTitleTableViewCell *cell = [self.shiYongTableView dequeueReusableCellWithIdentifier:@"shiyongCell" forIndexPath:indexPath];
        cell.backgroundColor = MainBackGround;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
        
    }else if (indexPath.row == 1) {
        
        
        EvaluateTableViewCell *cell = [self.shiYongTableView dequeueReusableCellWithIdentifier:@"evaluateCell"
                                                                                  forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = MainBackGround;
        self.wai = cell.zwTextView;
        
        
        
        [cell.zhaoxiangButton addTarget:self action:@selector(zhaoxiang) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
        
        
    }else if (indexPath.row > 1 && indexPath.row <4) {
        
        
        Evaluate2TableViewCell *cell = [self.shiYongTableView dequeueReusableCellWithIdentifier:@"evaluate2Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shiyongImage.userInteractionEnabled = YES;
        
        
        if (indexPath.row == 2) {
            
            self.zwTextView.placeholder = @"请您写下您使用该产品的质量问题和建议...";
            self.zhi = cell.zwTextView;

        }else{
            cell.shiyongIcon.image = [UIImage imageNamed:@"产品价格.png"];
            cell.shiyongTitle.text = @"产品价格";
            self.jia = cell.zwTextView;
            NSLog( @"%@",cell.zwTextView.text);
            

            
        }
        
        cell.backgroundColor = MainBackGround;
        return cell;
        
        
    }else if (indexPath.row == 4){
        GradeTableViewCell *cell = [self.shiYongTableView dequeueReusableCellWithIdentifier:@"gradeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.xieyiButton addTarget:self action:@selector(xieyi) forControlEvents:(UIControlEventTouchUpInside)];
        
        cell.xingxingView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = MainBackGround;
        self.xingxing1 = cell.xingxing1;
        self.xingxing2 = cell.xingxing2;
        self.xingxing3 = cell.xingxing3;
        self.xingxing4 = cell.xingxing4;
        self.xingxing5 = cell.xingxing5;
        cell.delegate  = self;
        
        
        return cell;
        
    }else {
        
        TiJiaoTableViewCell *cell = [self.shiYongTableView dequeueReusableCellWithIdentifier:@"tijiaoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = MainBackGround;
        return cell;
        
    }
    
    
}


//星星的点击事件
-(void)buttonAction1:(UIButton *)button
{
    if (self.isOne == YES) {
        [self.xingxing1 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
        self.isOne = NO;
        self.numberXing = 1;
    }else if (self.isOne == NO) {
        [self.xingxing1 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
        self.isOne = YES;
        self.isTow = YES;
        self.isThree = YES;
        self.isFour = YES;
        self.isFive = YES;
        self.numberXing = 0;
        
    }
    
    [self.xingxing2 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing3 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing4 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing5 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
    
    
    
}
-(void)buttonAction2:(UIButton *)button
{
    
    if (self.isTow == YES) {
        self.numberXing = 2;
        
        [self.xingxing2 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
        self.isTow = NO;
        self.isOne = NO;
        
    }else if (self.isTow == NO) {
        
        [self.xingxing2 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
        // self.isOne = YES;
        self.isTow   = YES;
        self.isThree = YES;
        self.isFour  = YES;
        self.isFive  = YES;
        self.numberXing = 1;
        
        
    }
    
    [self.xingxing1 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing3 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing4 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing5 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
    
    
}
-(void)buttonAction3:(UIButton *)button
{
    
    if (self.isThree == YES) {
        self.numberXing = 3;
        
        [self.xingxing3 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
        self.isThree = NO;
        self.isOne   = NO;
        self.isTow   = NO;
        
    }else if (self.isThree == NO) {
        
        
        [self.xingxing3 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
        self.isThree = YES;
        self.isFour  = YES;
        self.isFive  = YES;
        self.numberXing = 2;
        
        
    }
    
    [self.xingxing1 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing2 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing4 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing5 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
    
}
-(void)buttonAction4:(UIButton *)button
{
    if (self.isFour== YES) {
        self.numberXing = 4;
        
        [self.xingxing4 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
        self.isFour  = NO;
        self.isTow   = NO;
        self.isThree = NO;
        self.isOne   = NO;
        
    }else if (self.isFour == NO) {
        [self.xingxing4 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
        self.isFour = YES;
        self.isFive = YES;
        self.numberXing = 3;
        
    }
    
    [self.xingxing1 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing2 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing3 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing5 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
    
}
-(void)buttonAction5:(UIButton *)button
{
    if (self.isFive== YES) {
        self.numberXing = 5;
        
        [self.xingxing5 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
        self.isFive  = NO;
        self.isOne   = NO;
        self.isTow   = NO;
        self.isThree = NO;
        self.isFour  = NO;
    }else if (self.isFive == NO) {
        [self.xingxing5 setImage:[UIImage imageNamed:@"星星未选中.png"] forState:(UIControlStateNormal)];
        self.isFive = YES;
        self.numberXing = 4;
        
    }
    
    [self.xingxing1 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing2 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing3 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
    [self.xingxing4 setImage:[UIImage imageNamed:@"星星选中.png"] forState:(UIControlStateNormal)];
}

//=  == = ==       == = = == =    ================================================


//协议的点击事件
-(void)xieyi
{
    
    XieYiViewController *xieyiVC = [[XieYiViewController alloc]init];
    xieyiVC.k = 2;
    [self.navigationController pushViewController:xieyiVC animated:YES];
    
}




//照相的点击事件
-(void)zhaoxiang
{
    UIAlertController  *view=     [UIAlertController
                                   alertControllerWithTitle:nil
                                   message:nil
                                   preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"取消"
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;//
            [self presentViewController:picker animated:YES completion:nil];
        }
        else{
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"哎呀，当前设备没有摄像头。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
        
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing = YES;
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
        picker.allowsEditing = YES;
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
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        self.zhaoxiangImage.image = image;
        
    }else{
        self.zhaoxiangImage.image = image;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
