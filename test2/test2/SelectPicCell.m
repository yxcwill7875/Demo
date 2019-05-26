//
//  SelectPicCell.m
//  test2
//
//  Created by 余晓聪 on 2019/4/17.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "SelectPicCell.h"

@implementation SelectPicCell
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cellImageView = [[UIImageView alloc]init];
        _insideImageView = [[UIImageView alloc]init];
        _insideLabel = [[UILabel alloc]init];
        _downLineImageView = [[UIImageView alloc]init];
        _leftLineImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_cellImageView];
        [self.contentView addSubview:_insideImageView];
        [self.contentView addSubview:_insideLabel];
        [self.contentView addSubview:_leftLineImageView];
        [self.contentView addSubview:_downLineImageView];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    _cellImageView.frame = CGRectMake(self.contentView.frame.size.width / 6, self.contentView.frame.size.height / 6, self.contentView.frame.size.width * 2 / 3, self.contentView.frame.size.height * 2 / 3);
    
    _insideImageView.frame = CGRectMake(_cellImageView.frame.origin.x + _cellImageView.frame.size.width / 8, _cellImageView.frame.origin.y + _cellImageView.frame.size.height / 8, _cellImageView.frame.size.width / 4 * 3, _cellImageView.frame.size.height / 4 * 3);
    
    
    _insideLabel.frame = _insideImageView.frame;
    //设置Label背景透明，文字不透明
    _insideLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.0f];
    _insideLabel.textColor = [UIColor blackColor];
    _insideLabel.textAlignment = NSTextAlignmentCenter;
    _insideLabel.font = [UIFont systemFontOfSize:30];
    
    _leftLineImageView.frame = CGRectMake(self.contentView.frame.size.width - 1, 0, 1, self.contentView.frame.size.height);
    _leftLineImageView.backgroundColor = [UIColor grayColor];
    
    _downLineImageView.frame = CGRectMake(0, self.contentView.frame.size.height - 1, self.contentView.frame.size.width, 1);
    _downLineImageView.backgroundColor = [UIColor grayColor];
    
}

// 设置高亮效果
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    } else {
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.backgroundColor = [UIColor whiteColor];
        } completion:nil];
    }
}

// 设置选中选
-(void)setSelected:(BOOL)selected {
    if (selected) {
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
