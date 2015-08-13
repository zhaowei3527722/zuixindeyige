//
//  ActivityTableViewCell.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/21.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLable;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIImageView *thingImage;
@property (weak, nonatomic) IBOutlet UIButton *baoGao;

@end
