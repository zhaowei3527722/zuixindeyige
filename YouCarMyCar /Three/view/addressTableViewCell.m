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
    NSLog(@"这个是编辑");
}
- (IBAction)shanchuButton:(id)sender {
     NSLog(@"这个是删除");
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
