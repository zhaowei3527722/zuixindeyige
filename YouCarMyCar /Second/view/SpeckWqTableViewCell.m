//
//  SpeckWqTableViewCell.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/31.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "SpeckWqTableViewCell.h"

#import "PrefixHeader.pch"

@implementation SpeckWqTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self  coustom];//布局
        
    }
    
    return  self;
    
}

-(void)coustom
{
    self.myToImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 30, 30)];
    self.myNameLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 100, 20)];
    self.myToImageView.layer.cornerRadius = 15;
    self.myToImageView.layer.masksToBounds  = YES;
    self.myNameLable.textAlignment = NSTextAlignmentCenter;
    self.myNameLable.textColor = [UIColor brownColor];
    
    [self addSubview:self.myNameLable];
    [self addSubview:self.myToImageView];
    
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 40, 35, 20 )];
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 65, 35, 20 )];
    self.myAspectLableW = [[UILabel alloc]initWithFrame:CGRectMake(55, 65,kMainWidth - 80, 20)];
    UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 90, 35, 20 )];
    self.myWeithtLableZ = [[UILabel alloc]initWithFrame:CGRectMake(55, 90,kMainWidth - 80, 20)];
    UIImageView *image4 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 115, 35, 20 )];
    self.myPriceLableJ = [[UILabel alloc]initWithFrame:CGRectMake(55, 115,kMainWidth - 80, 20)];
    
    
    
    image1.image = [UIImage imageNamed:@"综合@2x.png"];
    image2.image = [UIImage imageNamed:@"外观@2x.png"];
    image3.image = [UIImage imageNamed:@"质量@2x.png"];
    image4.image = [UIImage imageNamed:@"价格@2x.png"];
    
    
    [self addSubview:image1];
    [self addSubview:image2];
    [self addSubview:image3];
    [self addSubview:image4];
    [self addSubview:self.myAspectLableW];
    [self addSubview:self.myWeithtLableZ];
    [self addSubview:self.myPriceLableJ];
    
    
    
    //星星
    
    self.my1ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(55, 40, 20, 20)];
    
    self.my2ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 40, 20, 20)];
    self.my3IMageViw = [[UIImageView alloc]initWithFrame:CGRectMake(105, 40, 20, 20)];
    self.my4ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 40, 20, 20)];
    self.my5imageView = [[UIImageView alloc]initWithFrame:CGRectMake(155, 40, 20, 20)];
    
    
    self.my1ImageView.image = [UIImage imageNamed:@"未选评分@2x.png"];
    self.my2ImageView.image = [UIImage imageNamed:@"未选评分@2x.png"];
    self.my3IMageViw.image = [UIImage imageNamed:@"未选评分@2x.png"];
    self.my4ImageView.image = [UIImage imageNamed:@"未选评分@2x.png"];
    self.my5imageView.image = [UIImage imageNamed:@"未选评分@2x.png"];
    
    
    [self addSubview:self.my5imageView];
    [self addSubview:self.my4ImageView];
    [self addSubview:self.my3IMageViw];
    [self addSubview:self.my2ImageView];
    [self addSubview:self.my1ImageView];
    
    
    
    
    
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 139, 50, 50)];
    
    [self addSubview:self.myImageView];
    
    UILabel *xian = [[UILabel alloc]initWithFrame:CGRectMake(0, 189, kMainWidth, 1)];
    [self addSubview:xian];
    xian.alpha = 0.3;
    xian.backgroundColor = [UIColor grayColor];
    
    
    
}

-(void)setMySpeckXingNumberInteger:(NSInteger)mySpeckXingNumberInteger
{
    if (mySpeckXingNumberInteger >= 1 && mySpeckXingNumberInteger <= 5) {
        if (_mySpeckXingNumberInteger != mySpeckXingNumberInteger) {
            _mySpeckXingNumberInteger = mySpeckXingNumberInteger;
            
            switch (mySpeckXingNumberInteger) {
                case 1:
                    self.my1ImageView.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my2ImageView.image = [UIImage imageNamed:@"未选评分@2x.png"];
                    self.my3IMageViw.image = [UIImage imageNamed:@"未选评分@2x.png"];
                    self.my4ImageView.image = [UIImage imageNamed:@"未选评分@2x.png"];
                    self.my5imageView.image = [UIImage imageNamed:@"未选评分@2x.png"];
                    
                    break;
                case 2:
                    self.my1ImageView.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my2ImageView.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my3IMageViw.image = [UIImage imageNamed:@"未选评分@2x.png"];
                    self.my4ImageView.image = [UIImage imageNamed:@"未选评分@2x.png"];
                    self.my5imageView.image = [UIImage imageNamed:@"未选评分@2x.png"];
                    
                    break;
                case 3:
                    self.my1ImageView.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my2ImageView.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my3IMageViw.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my4ImageView.image = [UIImage imageNamed:@"未选评分@2x.png"];
                    self.my5imageView.image = [UIImage imageNamed:@"未选评分@2x.png"];
                    
                    break;
                case 4:
                    self.my1ImageView.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my2ImageView.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my3IMageViw.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my4ImageView.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my5imageView.image = [UIImage imageNamed:@"未选评分@2x.png"];
                    
                    break;
                case 5:
                    self.my1ImageView.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my2ImageView.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my3IMageViw.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my4ImageView.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    self.my5imageView.image = [UIImage imageNamed:@"形状-3@2x.png"];
                    
                    break;
                    
                    
                default:
                    break;
            }
            
            
        }
        
    }
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
