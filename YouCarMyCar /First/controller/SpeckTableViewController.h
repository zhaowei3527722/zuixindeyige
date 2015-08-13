//
//  SpeckTableViewController.h
//  YouCarMyCar
//
//  Created by LLY on 15/7/27.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyListFirstTableViewCell.h"
#import "ZWTextView.h"
#import "NowViewModel.h"

@protocol SpeckTableviewDelegate <NSObject>

-(void)lightButtonAction:(UIButton *)button;
-(void)speckButtonAction:(UIButton *)button;


@end


@interface SpeckTableViewController : UITableViewController
@property (nonatomic,strong)ZWTextView *myTextView;
@property (nonatomic,strong)UIButton *myliftButton;
@property (nonatomic ,strong)UIButton *myRignth;
@property (nonatomic ,strong)UIView *myView;
@property (nonatomic ,assign)id<SpeckTableviewDelegate>delegate;
@property (nonatomic ,strong)UIButton *myspeckButton;
-(id)initWithModel:(NowViewModel *)model;//重写初始化方法;


@end
