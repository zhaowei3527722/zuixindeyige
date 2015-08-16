//
//  CollectionCell.m
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/1.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "CollectionCell.h"
#import "PrefixHeader.pch"
@implementation CollectionCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
        
    }
    return self;
}
//用来添加子视图
-(void)addAllViews
{
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.frame];
    NSLog(@"%f",self.frame.size.width);
    imageView.image = [UIImage imageNamed:@"往期背景.png"];
    self.backgroundView = imageView;

    [imageView addSubview:self.myimageView];
    
        [imageView addSubview:self.myView];
    self.mylabel.textColor = [UIColor whiteColor];
    self.qishuLable.textColor = [UIColor whiteColor];
    self.qishuLable.textAlignment = NSTextAlignmentCenter;
    self.mylabel.font = [UIFont systemFontOfSize:12];
    self.qishuLable.font = [UIFont systemFontOfSize:16];
    self.myView.backgroundColor = COLOR(0, 162, 246, 0.9);

    [imageView addSubview:self.mylabel];
    [imageView addSubview:self.qishuLable];
   
}
-(UILabel *)mylabel
{
    if (!_mylabel) {
        _mylabel = [[UILabel alloc]init];
    }
    return _mylabel;
}
-(UIView *)myView
{
    if (!_myView) {
        _myView = [[UIView alloc]init];
    }
    return _myView;
}
-(UIImageView *)myimageView
{
    if (!_myimageView) {
        _myimageView = [[UIImageView alloc]init];
    }
    return _myimageView;
}

-(UILabel *)qishuLable
{
    if (!_qishuLable) {
        _qishuLable = [[UILabel alloc]init];
    }
    return _qishuLable;
}

//当 父类的farm  设置的时候 走的这个方法
-(void)layoutSubviews
{
    
    //调用父类的方法
    [super layoutSubviews];
    
    
    [self.myimageView setFrame:CGRectMake(1, 1, self.frame.size.width - 3, self.frame.size.height - 2)];
    [self.myView setFrame:CGRectMake(0, self.frame.size.height*27/32, self.frame.size.width, self.frame.size.height*5/32)];
    [self.qishuLable setFrame:CGRectMake(0, self.frame.size.height*27/32, self.frame.size.width/4, self.myView.frame.size.height )];
    [self.mylabel setFrame:CGRectMake(self.frame.size.width/4, self.frame.size.height*27/32,self.frame.size.width*3/4,self.myView.frame.size.height )];
}
@end
