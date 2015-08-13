//
//  EvaluateTableViewCell.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/30.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "EvaluateTableViewCell.h"
@implementation EvaluateTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.zwTextView = [[ZWTextView alloc]initWithFrame:CGRectMake(7, 1, kMainWidth /4 *3 - 20, self.textImage.frame.size.height - 2)];
    self.zwTextView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.zwTextView.layer.borderWidth =1.0;
    self.textImage.userInteractionEnabled = YES;
    self.zwTextView.placeholder = @"请您写下您使用该产品的美观程度...";
    self.zwTextView.tag = 101;
    [self.textImage addSubview:self.zwTextView];

}

- (IBAction)zhaoxiang:(id)sender {
//    NSLog(@"chousiwole");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
