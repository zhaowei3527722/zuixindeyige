//
//  Evaluate2TableViewCell.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/30.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "Evaluate2TableViewCell.h"

@implementation Evaluate2TableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.zwTextView = [[ZWTextView alloc]initWithFrame:CGRectMake(7, 1, kMainWidth - 50, self.shiyongImage.frame.size.height - 2)];
    self.zwTextView.placeholder = @"请您写下您使用该产品的价格的满意程度...";
    self.zwTextView.tag = 103;
    [self.shiyongImage addSubview:self.zwTextView];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
