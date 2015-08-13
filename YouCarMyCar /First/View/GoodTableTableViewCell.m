//
//  GoodTableTableViewCell.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/29.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "GoodTableTableViewCell.h"

#import "PrefixHeader.pch"


@implementation GoodTableTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self.cellHeight = 170;
    self.cellWeight = [UIScreen mainScreen].bounds.size.width;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self costom];//布局;
        
    }
    return self;
    
}
-(void)costom
{
//    //俩个底背景
//    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.cellWeight, self.cellHeight)];
//    image1.image = [UIImage imageNamed:@"首页cell背景.png"];
//    [self addSubview:image1];
//    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 4, self.cellWeight - 10, self.cellHeight - 4)];
//    image2.image = [UIImage imageNamed:@"白背景.png"];
//    [self addSubview:image2];
    
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.cellWeight - 10 ,(self.cellHeight - 10 )* kMainWidth / 320)];
    [self addSubview:self.myImageView];
    
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
