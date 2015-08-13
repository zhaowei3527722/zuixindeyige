//
//  DataNameTableViewCell.h
//  YouCarMyCar
//
//  Created by ZhaoWei on 15/7/13.
//  Copyright (c) 2015年 LLY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataNameTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end
