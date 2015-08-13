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
    UIView *view = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:view];
//    view.layer.cornerRadius = 15;
//    view.layer.masksToBounds = 15;
    view.backgroundColor = [UIColor grayColor];
    
    [view addSubview:self.myimageView];
    [view addSubview:self.myView];
    [view addSubview:self.mylabel];
//    self.mylabel.textAlignment = NSTextAlignmentCenter;
    self.mylabel.textColor = [UIColor whiteColor];
    self.myView.backgroundColor = [UIColor blueColor];
    self.myView.alpha = 0.3;
   
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

//当 父类的farm  设置的时候 走的这个方法
-(void)layoutSubviews
{
    
    //调用父类的方法
    [super layoutSubviews];
    [self.mylabel setFrame:CGRectMake(20, kMainWidth*1/2.65, kMainWidth*9/20,kMainWidth*1.4/18.75 )];
    [self.myimageView setFrame:CGRectMake(0, 0, kMainWidth*9/20, kMainWidth*9/20)];
    [self.myView setFrame:CGRectMake(0, kMainWidth*1/2.65, kMainWidth*9/20,kMainWidth*1.4/18.75 )];
}
@end
