//
//  DataSexTableViewCell.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/13.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataSexTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sexLable;
@property (weak, nonatomic) IBOutlet UIImageView *yourImage;
@property (weak, nonatomic) IBOutlet UIView *back;
@property (weak, nonatomic) IBOutlet UILabel *myLable;

@end
