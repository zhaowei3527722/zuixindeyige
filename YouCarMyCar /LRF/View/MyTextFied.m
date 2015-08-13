//
//  MyTextFied.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/20.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "MyTextFied.h"

@interface NSObject ()<UITextFieldDelegate>

@end

@implementation MyTextFied



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
    
    
    self.mySmallimageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, self.frame.size.height - 16, self.frame.size.height - 16)];
    [self addSubview:self.mySmallimageView];
    
    
    self.mytextField = [[UITextField alloc]initWithFrame:CGRectMake(self.frame.size.height + 8, 0, self.frame.size.width -  self.frame.size.height - 80*[UIScreen mainScreen].bounds.size.width / 320 - 8, self.frame.size.height)];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
