//
//  CustomButtonCollectionViewCell.m
//  test2
//
//  Created by 余晓聪 on 2019/4/14.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "CustomButtonCollectionViewCell.h"

@implementation CustomButtonCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _insideImageView = [[UIImageView alloc]init];
        _insideLabel = [[UILabel alloc]init];
        _mySwitch = [[UISwitch alloc]init];
        _BGView = [[UIView alloc]init];
        
        
        [_BGView addSubview:_insideImageView];
        [_BGView addSubview:_insideLabel];
        [self.contentView addSubview:_BGView];
        [self.contentView addSubview:_mySwitch];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _BGView.frame = CGRectMake(self.contentView.frame.size.width / 4 , self.contentView.frame.size.width / 8 , self.contentView.frame.size.width / 2, self.frame.size.width / 2);
    _BGView.backgroundColor = [UIColor whiteColor];
    _BGView.layer.cornerRadius = 10.0f;
    
    _insideImageView.frame = CGRectMake(0 , 0, _BGView.frame.size.width, _BGView.frame.size.height);
    _insideImageView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.0f];

    _insideLabel.frame = _insideImageView.frame;
    _insideLabel.backgroundColor = _insideImageView.backgroundColor;
    //设置Label背景透明，文字不透明
    _insideLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.0f];
    _insideLabel.textColor = [UIColor blackColor];
    _insideLabel.textAlignment = NSTextAlignmentCenter;
    _insideLabel.font = [UIFont systemFontOfSize:20];
    
    _mySwitch.frame = CGRectMake(_BGView.frame.origin.x + (_BGView.frame.size.width - 51) / 2, _BGView.frame.size.height + _BGView.frame.origin.y + 15.0f, _insideImageView.frame.size.width, _insideImageView.frame.size.height);
    
}

@end
