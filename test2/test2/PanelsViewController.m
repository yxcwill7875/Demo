//
//  PanelsViewController.m
//  test2
//
//  Created by 余晓聪 on 2019/4/20.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "PanelsViewController.h"
#import "StyleCell.h"

#define kIs_iPhoneX (kSCREEN_WIDTH == 375.f && kSCREEN_HEIGHT == 812.f)
#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface PanelsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, copy)NSMutableArray *dataArray;//数据源数组
@property(nonatomic, copy)NSDictionary *dic;

@end

@implementation PanelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(clickCancelButtonMethod)];
    self.title = @"Select template to apply";
    
    _dataArray = [NSMutableArray arrayWithObjects:@"image1", @"image2", nil];
    
    
    [self createViews];
    
}

#pragma mark 页面布局
-(void)createViews {
    
    //开始UICollecView布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //每个按钮的大小
    flowLayout.itemSize = CGSizeMake((kSCREEN_WIDTH - 75 ) / 2 , kSCREEN_HEIGHT / kSCREEN_WIDTH * (kSCREEN_WIDTH - 75 ) / 2 );
    //每个按钮的最小间距
    flowLayout.minimumInteritemSpacing = 25;
    //每个按钮的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(25, 25, 25, 25);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) collectionViewLayout:flowLayout];
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionView.backgroundColor = [UIColor blackColor];
    
    //注册cell
    [_collectionView registerClass:[StyleCell class] forCellWithReuseIdentifier:@"identifier"];
    
    [self.view addSubview:_collectionView];
    
}

#pragma mark collectionView的cell数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

#pragma mark collectionView的cell样式
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    [cell.BGImageView setImage:[UIImage imageNamed:_dataArray[indexPath.row]]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];
    
    if ([[deviceDic objectForKey:@"style"] isEqualToString:[NSString stringWithFormat:@"%ld", indexPath.row]]) {
        cell.backgroundColor = [UIColor grayColor];
    }
    
    
    return cell;
}

#pragma mark cell点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];
    [deviceDic setObject:[NSString stringWithFormat:@"%ld", indexPath.row] forKey:@"style"];
    [defaults setObject:deviceDic forKey:deviceStr];
    [defaults synchronize];
    [collectionView reloadData];
    
}


// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 25;
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 25;
}

#pragma mark - collectionViewCell点击高亮

// 高亮时调用
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
}

// 高亮结束调用
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

// 是否可以高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark 取消按钮
- (void)clickCancelButtonMethod {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
