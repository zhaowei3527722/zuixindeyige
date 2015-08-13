//
//  MyTextFiedNoimage.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/22.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "MyTextFiedNoimage.h"


@interface NSObject ()<UITextFieldDelegate>

@end


@implementation MyTextFiedNoimage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    if (self) {
        [self cuostom];
        
        
    }
    return self;
    
    
}

-(void)cuostom

{
    self.myBigimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.myBigimageView.image = [UIImage imageNamed:@"背景框@2x.png"];
    [self addSubview:self.myBigimageView];
    self.mytextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height)];
    self.mytextField.delegate = self;
    [self addSubview:self.mytextField];
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(ReturnAction:)]) {
        [self.delegate ReturnAction:self.mytextField];
        
    }
    return YES;
    
}


@end
