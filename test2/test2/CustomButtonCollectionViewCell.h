//
//  CustomButtonCollectionViewCell.h
//  test2
//
//  Created by 余晓聪 on 2019/4/14.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomButtonCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong)UIImageView *insideImageView;
@property(nonatomic, strong)UILabel *insideLabel;
@property(nonatomic, strong)UISwitch *mySwitch;
@property(nonatomic, strong)UIView *BGView;

@end

NS_ASSUME_NONNULL_END
