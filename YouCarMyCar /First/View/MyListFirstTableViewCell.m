//
//  MyListFirstTableViewCell.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/2.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "MyListFirstTableViewCell.h"

#import "PrefixHeader.pch"

@implementation MyListFirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self.cellheight = 170;
    self.cellweight = [UIScreen mainScreen].bounds.size.width;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self costom];//布局;
        
    }
    return self;
    
}



-(void)setMytimeInteger:(NSInteger)mytimeInteger
{
    
    
    if (self.cellweight == 320) {
        if (_mytimeInteger != mytimeInteger) {
            
            
            if (self.myTimeLable) {
                
                [self.myTimeLable removeFromSuperview];
                self.myTimeLable = nil;
                [self.timLable removeFromSuperview];
                self.timLable = nil;

            }
            _mytimeInteger = mytimeInteger;

            
            self.myTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(72+(self.cellheight - 12 )/51 *44 + 5, self.cellheight / 4 * 2 + 30, self.cellweight - (self.cellweight / 2 - 20)- 70 , 20)];
            
            [self addSubview:self.myTimeLable];
            self.timLable = [[MZTimerLabel alloc] initWithLabel:self.myTimeLable andTimerType:MZTimerLabelTypeTimer];
            [self.timLable setCountDownTime:self.mytimeInteger];
            self.timLable.timeLabel.textColor = [UIColor brownColor];
            [self.timLable start];
            self.timLable.timeLabel.textAlignment = NSTextAlignmentCenter;
            
            
            
        }
        
        
    }else {
        
        
        
        
        if (_mytimeInteger != mytimeInteger) {
            
            
            if (self.myTimeLable) {
                
                [self.myTimeLable removeFromSuperview];
                self.myTimeLable = nil;
                [self.timLable removeFromSuperview];
                self.timLable = nil;
                
            }

            _mytimeInteger = mytimeInteger;
            self.myTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(72+(self.cellheight - 12 )/51 *44 + 5, self.cellheight / 4 * 2 + 30, self.cellweight - (self.cellweight / 2 - 20)- 70 , 20)];
            [self addSubview:self.myTimeLable];
            self.timLable= [[MZTimerLabel alloc] initWithLabel:self.myTimeLable andTimerType:MZTimerLabelTypeTimer];
            [self.timLable setCountDownTime:self.mytimeInteger];
            self.timLable.timeLabel.textColor = [UIColor brownColor];
            [self.timLable start];
            self.timLable.timeLabel.textAlignment = NSTextAlignmentCenter;
            
            
            
            
        }
        
    }
    
    
    
    
}
-(void)costom
{
    
    CGFloat imagewith = (self.cellheight - 12 )/51 *44;
    
    if (self.cellweight == 320) {
        
        //俩个底背景
        UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.cellweight, self.cellheight)];
        image1.image = [UIImage imageNamed:@"首页cell背景.png"];
        [self addSubview:image1];
        UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 4, self.cellweight - 10, self.cellheight - 4)];
        image2.image = [UIImage imageNamed:@"白背景.png"];
        [self addSubview:image2];
        //商品
        self.myGoodImageVeiw  = [[UIImageView alloc]initWithFrame:CGRectMake(6, 6, (self.cellheight - 12 )/51 *44,self.cellheight - 12 )];
        self.myGoodImageVeiw.image = [UIImage imageNamed:@"1.jpg"];
        [self addSubview:self.myGoodImageVeiw];
        
        //描述的lable
        self.mydescritionLable = [[UILabel alloc]initWithFrame:CGRectMake(10+(self.cellheight - 12 )/51 *44 + 5, self.cellheight / 3, self.cellweight - (10+(self.cellheight - 12 )/51 *44) - 6 , self.cellheight / 3)];
        self.mydescritionLable.text = @"这是描述商品的";
        self.mydescritionLable.numberOfLines = 0;
        self.mydescritionLable.font = [UIFont fontWithName:@"DBLCDTempBlack" size:12];
        self.mydescritionLable.textColor = [UIColor grayColor];
        
        [self addSubview:self.mydescritionLable];
        
        self.mybutton = [[UIButton alloc]initWithFrame:CGRectMake((kMainWidth - imagewith ) / 2 +imagewith - 60, self.cellheight / 4 * 3 + 10, 120 , self.cellheight / 4 - 10)];
        [self.mybutton setBackgroundImage:[UIImage imageNamed:@"免费试用@2x.png"] forState:(UIControlStateNormal)];
        [self.mybutton setBackgroundImage:[UIImage imageNamed:@"免费试用dianji@2x.png"] forState:(UIControlStateSelected)];
        
        [self.mybutton addTarget:self action:@selector(mybutton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.mybutton];
        
        UILabel *goodS = [[UILabel alloc]initWithFrame:CGRectMake(10+(self.cellheight - 12 )/51 *44, 6, 60, 12)];
        
        goodS.text = @"免费提供:";
        [self addSubview:goodS];
        goodS.font = [UIFont systemFontOfSize:10];
        
        self.myallGoodsCount = [[UILabel alloc]initWithFrame:CGRectMake(53+(self.cellheight - 12 )/51 *44, 4, 30, 15)];
        
        self.myallGoodsCount.text = @"200";
        self.myallGoodsCount.font = [UIFont systemFontOfSize:15];
        self.myallGoodsCount.textColor = [UIColor redColor];
        [self addSubview:self.myallGoodsCount];
        
        UILabel *goodnumber = [[UILabel alloc]initWithFrame:CGRectMake(78+(self.cellheight - 12 )/51 *44, 4, 15, 15)];
        goodnumber.text = @"份";
        goodnumber.font = [UIFont systemFontOfSize:10];
        [self addSubview:goodnumber];
        
        UILabel *person = [[UILabel alloc]initWithFrame:CGRectMake(self.cellweight - 95, 6, 60, 12)];
        person.text = @"申请人数:";
        person.font = [UIFont systemFontOfSize:10];
        [self addSubview:person];
        
        self.mynowPerson = [[UILabel alloc]initWithFrame:CGRectMake(self.cellweight - 55, 4, 50, 15)];
        self.mynowPerson.text = @"10000";
        self.mynowPerson.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.mynowPerson];
        self.mynowPerson.textColor = [UIColor redColor];
        
        UILabel *personNumber = [[UILabel alloc]initWithFrame:CGRectMake(self.cellweight - 13, 6, 12, 12)];
        personNumber.text  = @"人";
        personNumber.font = [UIFont systemFontOfSize:10];
        [self addSubview:personNumber];
        
        self.myGoodName = [[UILabel alloc]initWithFrame:CGRectMake(10+(self.cellheight - 12 )/51 *44 + 5, 25, self.cellweight -(self.cellheight - 12 )/51 *44 + 5  , 20)];
        self.myGoodName.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.myGoodName];
        self.myGoodName.text = @"商品的名称是啥呢";
        
        
        
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(38+(self.cellheight - 12 )/51 *44 + 5, self.cellheight / 4 * 2 + 30,60, 20)];
        lable.text = @"剩余时间:";
        
        [self addSubview:lable];
        lable.font = [UIFont systemFontOfSize:12];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10+(self.cellheight - 12 )/51 *44 + 5, self.cellheight / 4 * 2 + 30,20 , 20)];
        image.image = [UIImage imageNamed:@"闹铃@2x.png"];
        [self addSubview:image];
        
        
        
        
    }else{
        
        
        //俩个底背景
        UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.cellweight, self.cellheight)];
        image1.image = [UIImage imageNamed:@"首页cell背景.png"];
        [self addSubview:image1];
        UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 4, self.cellweight - 10, self.cellheight - 4)];
        image2.image = [UIImage imageNamed:@"白背景.png"];
        [self addSubview:image2];
        //商品
        self.myGoodImageVeiw  = [[UIImageView alloc]initWithFrame:CGRectMake(6, 6, (self.cellheight - 12 )/51 *44,self.cellheight - 12 )];
        self.myGoodImageVeiw.image = [UIImage imageNamed:@"1.jpg"];
        [self addSubview:self.myGoodImageVeiw];
        
        //描述的lable
        self.mydescritionLable = [[UILabel alloc]initWithFrame:CGRectMake(10+(self.cellheight - 12 )/51 *44 + 5, self.cellheight / 3, self.cellweight - (10+(self.cellheight - 12 )/51 *44) - 6 , self.cellheight / 3)];
        self.mydescritionLable.text = @"这是描述商品的";
        self.mydescritionLable.numberOfLines = 0;
        self.mydescritionLable.font = [UIFont fontWithName:@"DBLCDTempBlack" size:self.cellheight / 3 / 3 - 3];
        self.mydescritionLable.textColor = [UIColor grayColor];
        
        [self addSubview:self.mydescritionLable];
        
                self.mybutton = [[UIButton alloc]initWithFrame:CGRectMake((kMainWidth - imagewith ) / 2 +imagewith - 60, self.cellheight / 4 * 3 + 10, 120 , self.cellheight / 4 - 10)];
        
        self.mybutton = [[UIButton alloc]initWithFrame:CGRectMake((kMainWidth - imagewith ) / 2 +imagewith - 75, self.cellheight / 4 * 3 + 10, 150 , self.cellheight / 4 - 10)];
        [self.mybutton setBackgroundImage:[UIImage imageNamed:@"免费试用@2x.png"] forState:(UIControlStateNormal)];
        [self.mybutton setBackgroundImage:[UIImage imageNamed:@"免费试用dianji@2x.png"] forState:(UIControlStateSelected)];
        
        [self.mybutton addTarget:self action:@selector(mybutton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.mybutton];
        
        UILabel *goodS = [[UILabel alloc]initWithFrame:CGRectMake(10+(self.cellheight - 12 )/51 *44, 6, 60, 12)];
        
        goodS.text = @"免费提供:";
        [self addSubview:goodS];
        goodS.font = [UIFont systemFontOfSize:12];
        
        self.myallGoodsCount = [[UILabel alloc]initWithFrame:CGRectMake(63+(self.cellheight - 12 )/51 *44, 4, 30, 15)];
        
        self.myallGoodsCount.text = @"200";
        self.myallGoodsCount.font = [UIFont systemFontOfSize:17];
        self.myallGoodsCount.textColor = [UIColor redColor];
        [self addSubview:self.myallGoodsCount];
        
        UILabel *goodnumber = [[UILabel alloc]initWithFrame:CGRectMake(93+(self.cellheight - 12 )/51 *44, 4, 15, 17)];
        goodnumber.text = @"份";
        goodnumber.font = [UIFont systemFontOfSize:10];
        [self addSubview:goodnumber];
        
        UILabel *person = [[UILabel alloc]initWithFrame:CGRectMake(self.cellweight - 125, 6, 60, 12)];
        person.text = @"申请人数:";
        person.font = [UIFont systemFontOfSize:12];
        [self addSubview:person];
        
        self.mynowPerson = [[UILabel alloc]initWithFrame:CGRectMake(self.cellweight - 70, 4, 50, 15)];
        self.mynowPerson.text = @"10000";
        self.mynowPerson.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.mynowPerson];
        self.mynowPerson.textColor = [UIColor redColor];
        
        UILabel *personNumber = [[UILabel alloc]initWithFrame:CGRectMake(self.cellweight - 20, 6, 12, 12)];
        personNumber.text  = @"人";
        personNumber.font = [UIFont systemFontOfSize:12];
        [self addSubview:personNumber];
        
        
        
        self.myGoodName = [[UILabel alloc]initWithFrame:CGRectMake(10+(self.cellheight - 12 )/51 *44 + 5, 28, self.cellweight -(self.cellheight - 12 )/51 *44 + 5  , 20)];
        self.myGoodName.font = [UIFont systemFontOfSize:20];
        [self addSubview:self.myGoodName];
        self.myGoodName.text = @"商品的名称是啥呢";
        
        
        
        
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(50+(self.cellheight - 12 )/51 *44 + 5, self.cellheight / 4 * 2 + 30,60 , 20)];
        lable.text = @"剩余时间:";
        
        [self addSubview:lable];
        lable.font = [UIFont systemFontOfSize:12];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(25+(self.cellheight - 12 )/51 *44 + 5, self.cellheight / 4 * 2 + 30,20 , 20)];
        image.image = [UIImage imageNamed:@"闹铃@2x.png"];
        [self addSubview:image];
        
        
        
    }
    
    
    
    
    
}

-(void)mybutton:(UIButton *)button
{
    
    if ([self.delegagate respondsToSelector:@selector(actionButton:)]) {
        [self.delegagate actionButton:button];
        
    }
}

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
