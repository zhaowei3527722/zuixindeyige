//
//  GradeTableViewCell.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/30.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol GradeTableViewCellDelegate <NSObject>

-(void)buttonAction1:(UIButton *)button;
-(void)buttonAction2:(UIButton *)button;
-(void)buttonAction3:(UIButton *)button;
-(void)buttonAction4:(UIButton *)button;
-(void)buttonAction5:(UIButton *)button;


@end


@interface GradeTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *xingxingView;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *xieyiButton;
@property (weak, nonatomic) IBOutlet UIButton *xingxing1;
@property (weak, nonatomic) IBOutlet UIButton *xingxing2;
@property (weak, nonatomic) IBOutlet UIButton *xingxing3;
@property (weak, nonatomic) IBOutlet UIButton *xingxing4;
@property (weak, nonatomic) IBOutlet UIButton *xingxing5;


@property (nonatomic ,assign)id<GradeTableViewCellDelegate>delegate;


@end
