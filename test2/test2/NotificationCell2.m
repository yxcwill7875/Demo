//
//  NotificationCell2.m
//  test2
//
//  Created by 余晓聪 on 2019/4/22.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "NotificationCell2.h"

@implementation NotificationCell2

-(instancetype)init{
    self = [super init];
    if (self) {
        _titleLabel = [[UILabel alloc]init];
        _mySwitch = [[UISwitch alloc]init];
        
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_mySwitch];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(10, 0, self.contentView.frame.size.width - 75, self.contentView.frame.size.height);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    
    _mySwitch.frame = CGRectMake(self.contentView.frame.size.width - 75, (self.frame.size.height - 66) / 2, 1, 1);
    
}

@end
