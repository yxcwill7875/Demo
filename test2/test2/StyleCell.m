//
//  StyleCell.m
//  test2
//
//  Created by 余晓聪 on 2019/4/26.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "StyleCell.h"

@implementation StyleCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _BGImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_BGImageView];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _BGImageView.frame =CGRectMake(5, 5, self.contentView.frame.size.width - 10, self.contentView.frame.size.height - 10);
    
    
}

@end
