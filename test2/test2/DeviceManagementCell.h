//
//  DeviceManagementCell.h
//  test2
//
//  Created by 余晓聪 on 2019/4/20.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol deviceManagementCellDelegate <NSObject>
//
//-(void)clickButton:(UIButton *)but;
//
//@end

@interface DeviceManagementCell : UITableViewCell

@property(nonatomic, strong)UILabel *deviceName;
@property(nonatomic, strong)UILabel *time;
@property(nonatomic, strong)UIButton *setting;

//@property(nonatomic, weak)id<deviceManagementCellDelegate>myDelegate;

@end

NS_ASSUME_NONNULL_END
