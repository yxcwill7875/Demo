//
//  ButtonCollectionViewCell.h
//  test
//
//  Created by 余晓聪 on 2019/4/7.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ButtonCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong)UIImageView *cellImageView;
@property(nonatomic, strong)UIImageView *insideImageView;
@property(nonatomic, strong)UILabel *insideLabel;
@property(nonatomic, strong)UIImageView *leftLineImageView;
@property(nonatomic, strong)UIImageView *downLineImageView;
@property(nonatomic, strong)UIImageView *picImageView;
@property(nonatomic, strong)UIButton *clickButton;
@property(nonatomic, strong)UIButton *touchButton;

@end

NS_ASSUME_NONNULL_END
