//
//  addressTableViewCell.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/16.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "addressTableViewCell.h"

@implementation addressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)bianjiButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(buttonAction1:)]) {
        [self.delegate buttonAction1:sender];
    }
}
- (IBAction)shanchuButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(buttonAction2:)]) {
        [self.delegate buttonAction2:sender];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
