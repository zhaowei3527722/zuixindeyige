//
//  WqDetalTableViewCell.h
//  YouCarMyCar
//
//  Created by LLY on 15/7/29.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WpDetalTableviewCellDelegate <NSObject>

-(void)sureAddress:(UIButton *)button;
-(void)liftButton:(UIButton *)button;
-(void)rigthButton:(UIButton *)button;

@end

@interface WqDetalTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *myGoodsNameLable;
@property (nonatomic ,strong)UILabel *mypeoOldLable;
@property (nonatomic ,strong)UIButton *mySureAddressButton;//确认 地址
@property (nonatomic ,strong)UIButton *myReportButton;//提交使用报告
@property (nonatomic ,strong)UIButton *myLooklistButton;//查看中奖名单
@property (nonatomic ,strong)UILabel * myreportNumberLable;//报告的份数;
@property (nonatomic ,assign)id<WpDetalTableviewCellDelegate>delegate;
@property  (nonatomic ,strong)UILabel *myGoodDescritionLable;//商品的描述
@property (nonatomic,strong)UILabel *myGoodNumberLable;//商品的数量;
@property (nonatomic ,strong)UILabel *myPeopleNumberLable;//参与人数


@end
