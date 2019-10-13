//
//  DeviceManagementCell.m
//  test2
//
//  Created by 余晓聪 on 2019/4/20.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "DeviceManagementCell.h"

@implementation DeviceManagementCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _deviceName = [[UILabel alloc]init];
        _time = [[UILabel alloc]init];
        _setting = [[UIButton alloc]init];
        
        [self.contentView addSubview:_deviceName];
        [self.contentView addSubview:_time];
        [self.contentView addSubview:_setting];
        
    }
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _deviceName.frame = CGRectMake(0, 0, self.contentView.frame.size.width / 4 * 3, self.contentView.frame.size.height / 5 * 3);
    _deviceName.font = [UIFont systemFontOfSize:20];
    
    _time.frame = CGRectMake(0, _deviceName.frame.size.height, _deviceName.frame.size.width, self.contentView.frame.size.height / 5 * 2);
    _time.font =[UIFont systemFontOfSize:14];
    _time.textColor = [UIColor grayColor];
    
    _setting.frame = CGRectMake(self.contentView.frame.size.width - 40, (self.contentView.frame.size.height - 40) / 2, 20, 20);
    [_setting setImage:[UIImage imageNamed:@"pic1"] forState:UIControlStateNormal];
    
}


//- (void)onClick:(UIButton *)but{
//
//    [_myDelegate clickButton:but];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
