//
//  DataNameTableViewCell.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/13.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "DataNameTableViewCell.h"

@implementation DataNameTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.nameField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nameField resignFirstResponder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
