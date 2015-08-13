//
//  TouxiangTableViewCell.m
//  youCarmyCar
//
//  Created by ZhaoWei on 15/6/25.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "TouxiangTableViewCell.h"

@implementation TouxiangTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualEfView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [self.backimage setFrame:self.frame];
    visualEfView.alpha = 1.0;
    [self.backimage addSubview:visualEfView];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
