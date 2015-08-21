//
//  SxiangViewController.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/1.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WangQiModel.h"
@interface SxiangViewController : UIViewController
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)WangQiModel *wangqiModel;
@property (nonatomic,strong)UIImageView *myBigImageView;
@property (nonatomic ,strong)NSString *myallnum;

@property (nonatomic,strong)NSString *stringID;
@end
