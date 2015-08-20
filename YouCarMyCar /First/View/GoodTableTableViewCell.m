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
    
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.cellWeight - 10 ,(self.cellHeight - 10 )* kMainWidth / 320)];
    [self addSubview:self.myImageView];
    
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
