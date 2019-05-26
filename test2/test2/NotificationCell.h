//
//  NotificationCell.h
//  test2
//
//  Created by 余晓聪 on 2019/4/22.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationCell : UITableViewCell
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *tipsLabel;
@property(nonatomic, strong)UISwitch *mySwitch;

@end

NS_ASSUME_NONNULL_END
