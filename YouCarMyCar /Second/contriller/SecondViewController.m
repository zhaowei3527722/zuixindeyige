//
//  SecondViewController.m
//  YoucarMycar
//
//  Created by LLY on 15-6-26.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "SecondViewController.h"
#import "CollectionCell.h"
#import "PrefixHeader.pch"
#import "SxiangViewController.h"
@interface SecondViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation SecondViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = NO;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"往期试用";
    //自定义View
    [self layoutView];
}

//自定义View
-(void)layoutView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
//设置section的header 的尺寸
    flowLayout.headerReferenceSize = CGSizeMake(0, 20);
//设置footer的尺寸
    flowLayout.footerReferenceSize = CGSizeMake(10, 10);
//没行的最小间距 默认 10;
    flowLayout.minimumInteritemSpacing = 1;
//设置item 的大小 默认值为 50 50
    flowLayout.itemSize = CGSizeMake(kMainWidth*9/20, kMainWidth*9/20);
//设置section的内衍
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, kMainWidth*1/29, 0, kMainWidth*1/29)];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = COLOR(255, 249, 247, 1);
    
//注册cell
    [_collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:KcellIndetifier];
//注册header
    [_collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentier];
//注册footer
    [_collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFordIdentier];
//设置代理
    _collectionView.delegate =self;
    _collectionView.dataSource =self;
    
    [self.view addSubview:_collectionView];
    
}

//返回CollectionView有几个Seciton 默认值是返回1
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIndentifier" forIndexPath:indexPath];
   
    cell.backgroundColor = [UIColor clearColor];
    cell.mylabel.text = @"06期";
    cell.myimageView.image = [UIImage imageNamed:@"2.jpg"];
 

    
    return cell;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SxiangViewController *sXiangVC = [[SxiangViewController alloc]init];
    [self.navigationController pushViewController:sXiangVC animated:YES];
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
