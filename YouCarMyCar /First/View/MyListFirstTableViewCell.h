//
//  MyListFirstTableViewCell.h
//  YouCarMyCar
//
//  Created by LLY on 15/7/2.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MZTimerLabel.h"


@protocol MylistFirstbleDelegate <NSObject>

-(void)actionButton:(UIButton*)button;


@end

@interface MyListFirstTableViewCell : UITableViewCell

@property (nonatomic ,strong)UIImageView *myGoodImageVeiw;//展示的商品
@property (nonatomic ,strong)UILabel *mydescritionLable;//商品的描述
@property (nonatomic)CGFloat cellheight;
@property (nonatomic )CGFloat cellweight;
@property (nonatomic,strong)UIButton *mybutton;//马上参与的按钮
@property (nonatomic ,assign)id<MylistFirstbleDelegate>delegagate;
@property (nonatomic )NSInteger mytimeInteger;//倒计时的时间
@property (nonatomic ,strong)UILabel *myTimeLable;//时间的控件需要的lable;
@property (nonatomic ,strong)UILabel *myallGoodsCount;//商品的  总数量
@property (nonatomic ,strong)UILabel *mynowPerson;//参与的人数
@property (nonatomic ,strong)UILabel *myGoodName;//商品名称


@property (nonatomic  ,strong)MZTimerLabel *timLable;


@end
