//
//  ButtonCollectionViewCell.m
//  test
//
//  Created by 余晓聪 on 2019/4/7.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "ButtonCollectionViewCell.h"

@implementation ButtonCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cellImageView = [[UIImageView alloc]init];
        _insideImageView = [[UIImageView alloc]init];
        _insideLabel = [[UILabel alloc]init];
        _downLineImageView = [[UIImageView alloc]init];
        _leftLineImageView = [[UIImageView alloc]init];
        _picImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_cellImageView];
        [self.contentView addSubview:_insideImageView];
        [self.contentView addSubview:_insideLabel];
        [self.contentView addSubview:_leftLineImageView];
        [self.contentView addSubview:_downLineImageView];
        [self.contentView addSubview:_picImageView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _cellImageView.frame = CGRectMake(self.contentView.frame.size.width / 6, self.contentView.frame.size.height / 6, self.contentView.frame.size.width * 2 / 3, self.contentView.frame.size.height * 2 / 3);
    
    _insideImageView.frame = CGRectMake(_cellImageView.frame.origin.x + _cellImageView.frame.size.width / 8, _cellImageView.frame.origin.y + _cellImageView.frame.size.height / 8, _cellImageView.frame.size.width / 4 * 3, _cellImageView.frame.size.height / 4 * 3);
//    _insideImageView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.0f];
    _insideImageView.backgroundColor = [UIColor whiteColor];
    _insideImageView.layer.cornerRadius = 5.0f;
    
    
    _insideLabel.frame = CGRectMake(_insideImageView.frame.origin.x + 10, _insideImageView.frame.origin.y + 10, _insideImageView.frame.size.width - 20, _insideImageView.frame.size.height - 20);
    //设置Label背景透明，文字不透明
    _insideLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.0f];
    _insideLabel.textColor = [UIColor blackColor];
    _insideLabel.textAlignment = NSTextAlignmentCenter;
    _insideLabel.font = [UIFont systemFontOfSize:30];
    
    _picImageView.frame = _insideLabel.frame;
    _picImageView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.0f];
    
    _leftLineImageView.frame = CGRectMake(self.contentView.frame.size.width - 1, 0, 1, self.contentView.frame.size.height);
    _leftLineImageView.backgroundColor = [UIColor grayColor];
    
    _downLineImageView.frame = CGRectMake(0, self.contentView.frame.size.height - 1, self.contentView.frame.size.width, 1);
    _downLineImageView.backgroundColor = [UIColor grayColor];
    
}

//// 设置高亮效果
//- (void)setHighlighted:(BOOL)highlighted {
//    [super setHighlighted:highlighted];
//    if (highlighted) {
//        self.backgroundColor = [UIColor grayColor];
//    } else {
//        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            self.backgroundColor = [UIColor blackColor];
//        } completion:nil];
//    }
//}

// 设置选中选中
-(void)setSelected:(BOOL)selected {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];
    
    if ([[deviceDic objectForKey:@"style"] isEqualToString:@"0"]) {
        //第一种风格
        if (selected) {
            self.backgroundColor = [UIColor grayColor];
            self.cellImageView.image = [UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/SP5110-UI Btn-ON-外框_20190403.png"];
            self.insideImageView.image = [UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/SP5110-UI Btn-ON_按鈕空白處_20190403.png"];
        } else {
            self.backgroundColor = [UIColor blackColor];
            self.cellImageView.image = [UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/SP5110-UI Btn-OFF-外框_20190403.png"];
            self.insideImageView.image = [UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/SP5110-UI Btn-OFF-內框_20190403.png"];
            
        }
    }else {//第二种风格
        if (selected) {
            self.backgroundColor = [UIColor grayColor];
            self.cellImageView.image = [UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/SP5110-UI-2 Btn-ON-外框_20190412.png"];
            self.insideImageView.image = [UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/SP5110-UI-2 Btn-ON-內框_20190412.png"];
        } else {
            self.backgroundColor = [UIColor blackColor];
            self.cellImageView.image = [UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/SP5110-UI-2 Btn-OFF-外框_20190412.png"];
            self.insideImageView.image = [UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/SP5110-UI-2 Btn-OFF-內框_20190412.png"];
            
        }
        
    }

}

@end
