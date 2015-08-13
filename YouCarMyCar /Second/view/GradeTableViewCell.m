//
//  GradeTableViewCell.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/30.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "GradeTableViewCell.h"
#import "CommonHandle.h"
@implementation GradeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    

}

- (IBAction)xingxing1:(id)sender {
    if ([self.delegate respondsToSelector:@selector(buttonAction1:)]) {
        [self.delegate buttonAction1:sender];
        
    }
    
    
}
- (IBAction)xingxing2:(id)sender {
    if ([self.delegate respondsToSelector:@selector(buttonAction2:)]) {
        [self.delegate buttonAction2:sender];
        
    }
    
}


- (IBAction)xingxing3:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(buttonAction3:)]) {
        [self.delegate buttonAction3:sender];
        
    }

}
- (IBAction)xingxing4:(id)sender {
    if ([self.delegate respondsToSelector:@selector(buttonAction4:)]) {
        [self.delegate buttonAction4:sender];
        
    }

}
- (IBAction)xingxing5:(id)sender {
    if ([self.delegate respondsToSelector:@selector(buttonAction5:)]) {
        [self.delegate buttonAction5:sender];
        
    }


}
- (IBAction)change:(id)sender {
    
    if ([CommonHandle shareHandle].isShiYongXieYi == YES) {
        [self.changeButton setImage:[UIImage imageNamed:@"未阅读.png"] forState:(UIControlStateNormal)];
        [CommonHandle shareHandle].isShiYongXieYi = NO;
    }else if ([CommonHandle shareHandle].isShiYongXieYi == NO){
        
        [self.changeButton setImage:[UIImage imageNamed:@"已阅读.png"] forState:(UIControlStateNormal)];
        [CommonHandle shareHandle].isShiYongXieYi = YES;
    }
    
}
- (IBAction)xieyi:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
