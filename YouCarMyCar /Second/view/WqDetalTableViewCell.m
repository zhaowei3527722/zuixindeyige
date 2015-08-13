//
//  WqDetalTableViewCell.m
//  YouCarMyCar
//
//  Created by LLY on 15/7/29.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import "WqDetalTableViewCell.h"
#import "PrefixHeader.pch"

#import "HEInfiniteScrollView.h"

@implementation WqDetalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self coustom];
        
    }
    return self;
    
}
-(void)coustom
{
    
    NSArray *images = @[ [UIImage imageNamed:@"Untitled2.jpg"],
                         [UIImage imageNamed:@"33.jpg"],
                         [UIImage imageNamed:@"45.jpg"],];
    HEInfiniteScrollView *infiniteScrollView = [[HEInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainWidth, 150 * kMainWidth / 320)];
    [self addSubview:infiniteScrollView];
    [infiniteScrollView setContentObjs:images Placeholder:nil];
    infiniteScrollView.pageControlContentMode = kHEPageControlContentModeBottomCenter;
    infiniteScrollView.switchType = kHESwitchTypeFadeOut;
    
    self.myGoodsNameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 150 * kMainWidth / 320, kMainWidth, 20)];
    [self addSubview:self.myGoodsNameLable];
    
    self.myGoodDescritionLable= [[UILabel alloc]initWithFrame:CGRectMake(10, 168 * kMainWidth / 320, 190, 40)];
    self.myGoodDescritionLable.font = [UIFont systemFontOfSize:12];
    self.myGoodDescritionLable.textColor = [UIColor grayColor];
    self.myGoodDescritionLable.numberOfLines = 0;
    [self addSubview:self.myGoodDescritionLable];
    
    self.myGoodDescritionLable.text = @"我打算打发阿萨德飞机阿道夫阿里山东方大神阿斯顿发生大发撒旦法阿斯达发";
    
    //==================
    UILabel *mian = [[UILabel alloc]initWithFrame:CGRectMake(20, 200 * kMainWidth / 320, 55, 20)];
    mian.text = @"免费提供:";
    mian.font = [UIFont systemFontOfSize:12];
    [self addSubview:mian];
    
    
    self.myGoodNumberLable = [[UILabel alloc]initWithFrame:CGRectMake(75, 200 * kMainWidth / 320, 38, 20)];
    self.myGoodNumberLable.text = @"2000";
    self.myGoodNumberLable.textColor = [UIColor redColor];
    self.myGoodNumberLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.myGoodNumberLable];
    
    
    UILabel *fen = [[UILabel alloc]initWithFrame:CGRectMake(112, 200 * kMainWidth / 320, 55, 20)];
    fen.text = @"份";
    fen.font = [UIFont systemFontOfSize:12];
    [self addSubview:fen];
    
    
    
    
    UILabel *per = [[UILabel alloc]initWithFrame:CGRectMake(20, 215 * kMainWidth / 320, 55, 20)];
    per.text = @"参与人数:";
    per.font = [UIFont systemFontOfSize:12];
    [self addSubview:per];
    
    
    self.myPeopleNumberLable = [[UILabel alloc]initWithFrame:CGRectMake(75, 215 * kMainWidth / 320, 45, 20)];
    self.myPeopleNumberLable.text = @"20000";
    self.myPeopleNumberLable.textColor = [UIColor redColor];
    self.myPeopleNumberLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.myPeopleNumberLable];
    
    
    UILabel *ren = [[UILabel alloc]initWithFrame:CGRectMake(120, 215 * kMainWidth / 320, 55, 20)];
    ren.text = @"人";
    ren.font = [UIFont systemFontOfSize:12];
    [self addSubview:ren];
    
    
    
    
    
    
    
    
    
    
    
    
    self.mySureAddressButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    
    if (kMainWidth == 320) {
        self.mySureAddressButton.frame = CGRectMake(200, 190 * kMainWidth / 320, kMainWidth - 210, 40 * kMainWidth / 320);
        
        
    }else {
        self.mySureAddressButton.frame = CGRectMake(220, 195 * kMainWidth / 320, kMainWidth - 240, 46);
        
        
        
    }
    
    [self.mySureAddressButton setBackgroundImage:[UIImage imageNamed:@"truck@2x.png"] forState:(UIControlStateNormal)];
    
    [self.mySureAddressButton addTarget:self action:@selector(mySureAddressButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self addSubview:self.mySureAddressButton];
    
    
    
    //===========可以不管 /// 是画的线
    UILabel *xian = [[UILabel alloc]initWithFrame:CGRectMake(0, 235 * kMainWidth / 320, kMainWidth, 1)];
    [self addSubview:xian];
    xian.backgroundColor = [UIColor grayColor];
    xian.alpha = 0.4;
    UILabel *xian2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 275 * kMainWidth / 320, kMainWidth, 1)];
    [self addSubview:xian2];
    xian2.backgroundColor = [UIColor grayColor];
    xian2.alpha = 0.4;
    UILabel *xian3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 315 * kMainWidth / 320, kMainWidth, 1)];
    [self addSubview:xian3];
    xian3.backgroundColor = [UIColor grayColor];
    xian3.alpha = 0.3;
    //=========
    
    self.myreportNumberLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 275 * kMainWidth / 320, kMainWidth, 40 * kMainWidth / 320)];
    [self addSubview:self.myreportNumberLable];
    self.myreportNumberLable.textColor = [UIColor redColor];
    self.myreportNumberLable.textAlignment = NSTextAlignmentCenter;
    
    self.myReportButton = [UIButton  buttonWithType:(UIButtonTypeCustom)];
    self.myReportButton.frame = CGRectMake(15, 240 * kMainWidth / 320, (kMainWidth - 45) / 2, 30 * kMainWidth / 320);
    [self addSubview:self.myReportButton];
    [self.myReportButton addTarget:self action:@selector(myReportButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.myReportButton setBackgroundImage:[UIImage imageNamed:@"提交试用报告@2x.png"] forState:(UIControlStateNormal)];
    
    
    
    self.myLooklistButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.myLooklistButton.frame = CGRectMake((kMainWidth - 45) / 2 + 30, 240 * kMainWidth / 320, (kMainWidth - 45) / 2, 30 * kMainWidth / 320);
    [self.myLooklistButton setBackgroundImage:[UIImage imageNamed:@"查看中奖名单@2x.png"] forState:(UIControlStateNormal)];
    [self.myLooklistButton addTarget:self action:@selector(myLooklistButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self addSubview:self.myLooklistButton];
    
    
}
//mygoodEvalutinteger的set方法 给星星换image
-(void)mySureAddressButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(sureAddress:)]) {
        [self.delegate sureAddress:button];
        
    }
}
-(void)myReportButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(liftButton:)]) {
        [self.delegate liftButton:button];
        
    }
}
-(void)myLooklistButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(rigthButton:)]) {
        [self.delegate rigthButton:button];
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
