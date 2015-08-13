
//
//  RightListTableViewCell.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/31.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "RightListTableViewCell.h"

#import "PrefixHeader.pch"

@implementation RightListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self coustom];//布局
        
    }
    return self;
    
}
-(void)coustom//布局

{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth,40)];
    view.backgroundColor = COLOR(255, 241, 235, 1);
    [self addSubview:view];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 39, (kMainWidth - 30) / 2, 1)];
    lable.alpha = 0.3;
    lable.backgroundColor = [UIColor grayColor];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake((kMainWidth - 30) / 2 + 20, 39, (kMainWidth - 30) / 2, 1)];
    lable1.alpha = 0.3;
    lable1.backgroundColor = [UIColor grayColor];
    
    [self addSubview:lable];
    [self addSubview:lable1];
    
    
    self.myliftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 30, 30)];
    self.myliftNameLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 100, 20)];
    self.myliftNameLable.textAlignment = NSTextAlignmentCenter;
    self.myRightImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kMainWidth - 30) / 2 + 30, 5, 30, 30)];
    self.myRightLable = [[UILabel alloc]initWithFrame:CGRectMake((kMainWidth - 30) / 2 + 60, 10, 100, 20)];
    self.myRightLable.textAlignment = NSTextAlignmentCenter;
    
    self.myRightImageView.layer.cornerRadius = 15;
    self.myRightImageView.layer.masksToBounds = YES;
    self.myliftImageView.layer.cornerRadius = 15;
    self.myliftImageView.layer.masksToBounds = YES;
    
    
    [self addSubview:self.myliftImageView];
    [self addSubview:self.myliftNameLable];
    [self addSubview:self.myRightImageView];
    [self addSubview:self.myRightLable];
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
