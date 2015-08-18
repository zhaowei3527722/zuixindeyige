//
//  addressTableViewCell.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/16.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol addressTableViewCellDelegate <NSObject>

-(void)buttonAction1:(UIButton *)button;
-(void)buttonAction2:(UIButton *)buttonzz;
-(void)changeButton:(UIButton *)button;

@end


@interface addressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;

@property (weak, nonatomic) IBOutlet UIButton *bianjiBT;
@property (weak, nonatomic) IBOutlet UIButton *shanchuBT;
@property (weak, nonatomic) IBOutlet UIButton *morenBT;

@property (nonatomic,assign)id<addressTableViewCellDelegate>delegate;
@end
