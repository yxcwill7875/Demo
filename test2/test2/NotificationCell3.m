//
//  NotificationCell3.m
//  test2
//
//  Created by 余晓聪 on 2019/4/22.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "NotificationCell3.h"

@implementation NotificationCell3

-(instancetype)init{
    self = [super init];
    if (self) {
        _titleLabel = [[UILabel alloc]init];
        _tipsLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_tipsLabel];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(10, 0, self.contentView.frame.size.width - 75, self.contentView.frame.size.height / 2);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    
    _tipsLabel.frame = CGRectMake(10, _titleLabel.frame.size.height / 2 + 5, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
    _tipsLabel.font = [UIFont systemFontOfSize:10];
    _tipsLabel.textColor = [UIColor grayColor];
    

}


@end
