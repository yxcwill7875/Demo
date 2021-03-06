//
//  SelectPicCell.h
//  test2
//
//  Created by 余晓聪 on 2019/4/17.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectPicCell : UICollectionViewCell
@property(nonatomic, strong)UIImageView *cellImageView;
@property(nonatomic, strong)UIImageView *insideImageView;
@property(nonatomic, strong)UILabel *insideLabel;
@property(nonatomic, strong)UIImageView *leftLineImageView;
@property(nonatomic, strong)UIImageView *downLineImageView;

@end

NS_ASSUME_NONNULL_END
