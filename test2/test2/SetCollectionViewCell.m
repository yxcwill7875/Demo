//
//  SetCollectionViewCell.m
//  test2
//
//  Created by 余晓聪 on 2019/4/10.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "SetCollectionViewCell.h"

@implementation SetCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc]init];
        [self.contentView addSubview:_label];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:30];
    
}



@end
