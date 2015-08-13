//
//  SpeckTableViewCell.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/29.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "SpeckTableViewCell.h"

#import "PrefixHeader.pch"


@implementation SpeckTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self costom];//布局;
        
    }
    
    
      return self;

    
    
}
-(void)costom
{
    self.myPersonTimageView  = [[UIImageView alloc]initWithFrame:CGRectMake(30, 5, 30, 30)];
    [self addSubview:self.myPersonTimageView];
    
    self.myNameLable  = [[UILabel alloc]initWithFrame:CGRectMake(65, 10, 100, 25)];
    [self addSubview:self.myNameLable];
    self.mySpeckLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 55, kMainWidth - 40,45)];
    
    self.mySpeckLable.numberOfLines = 0;
    
    [self addSubview:self.mySpeckLable];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
