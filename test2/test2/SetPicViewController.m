//
//  SetPicViewController.m
//  test2
//
//  Created by 余晓聪 on 2019/4/10.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "SetPicViewController.h"
#import "SelectPicViewController.h"
#import "CustomButtonCollectionViewCell.h"

#define kIs_iPhoneX (kSCREEN_WIDTH == 375.f && kSCREEN_HEIGHT == 812.f)
#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface SetPicViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, copy)NSArray *dataArray;
@property(nonatomic, copy)NSMutableArray *reloadDataArray;
@property(nonatomic, strong)UICollectionView *collectionView;

@end

@implementation SetPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];//导航栏颜色
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];//返回键颜色
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(clickCancelButtonMethod)];
    self.title = @"haonwiaiakfjklankfnaifianwfhafnkabfkunakfuiafiabkuf";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0f], NSForegroundColorAttributeName:[UIColor whiteColor]}];//title颜色和字体大小
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setDataArray];
    //页面布局
    [self createViews];
    
    NSLog(@"-----dic---dic---%@", _dic);
}

-(void)setDataArray{
    //初始化数据源数组
    _dataArray = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
    
    _reloadDataArray = [NSMutableArray array];
    for (int i = 0; i < 52; i++) {
        NSString *str = [NSString stringWithFormat:@"pic%d", i + 1 ];
        [_reloadDataArray addObject:str];
    }
    
}

#pragma 页面布局方法
- (void)createViews {
    //开始UICollectionView布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //每个按钮的大小
    flowLayout.itemSize = CGSizeMake(kSCREEN_WIDTH / 5 , kSCREEN_HEIGHT / 2.5);
    //每个按钮的最小间距
    flowLayout.minimumInteritemSpacing = 0;
    //每个按钮的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
  
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) collectionViewLayout:flowLayout];
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionView.backgroundColor = [UIColor blackColor];
    
    //注册cell
    [_collectionView registerClass:[CustomButtonCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    
    [self.view addSubview:_collectionView];
    
    //设置标题Label
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, kSCREEN_HEIGHT - kSCREEN_HEIGHT / 8, flowLayout.itemSize.width * 3, kSCREEN_HEIGHT / 8)];
    titleLabel.text = @"  My  Boat's  Control  Panel";
    titleLabel.font = [UIFont systemFontOfSize:30];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = self.view.backgroundColor;
    
    [self.view addSubview:titleLabel];
    
    //设置取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setFrame:CGRectMake(titleLabel.frame.size.width + titleLabel.frame.origin.x + 10, titleLabel.frame.origin.y, flowLayout.itemSize.width - 20, titleLabel.frame.size.height)];
    
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cancelButton setTintColor:[UIColor blackColor]];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:24];
    //设置button弧度
    cancelButton.layer.cornerRadius = 10.0f;
    
    [cancelButton addTarget:self action:@selector(clickCancelButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancelButton];
    
    //设置保存按钮
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveButton setFrame:CGRectMake(cancelButton.frame.size.width + cancelButton.frame.origin.x + 10, titleLabel.frame.origin.y, cancelButton.frame.size.width, titleLabel.frame.size.height)];
    
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    saveButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [saveButton setTintColor:[UIColor blackColor]];
    saveButton.backgroundColor = [UIColor whiteColor];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:24];
    //设置button弧度
    saveButton.layer.cornerRadius = cancelButton.layer.cornerRadius;
    
    [saveButton addTarget:self action:@selector(clickSaveButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveButton];
    
}

#pragma mark 保存按钮调用方法
- (void)clickSaveButtonMethod {
    //保存数据
    //取出当前设备字典
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionary];
    deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];
 
    NSLog(@"--dic--%@--deviceDic%@--", _dic, deviceDic);
    //提示框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存设置成功" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(createAlert:) userInfo:alertController repeats:NO];
    
}

//设置提示框定时消失
-(void)createAlert:(NSTimer *)timer {
    UIAlertController *alertController = [timer userInfo];
    [alertController dismissViewControllerAnimated:YES completion:^{
    [self.navigationController popToRootViewControllerAnimated:YES];//保存后回到主视图
    }];
    alertController = nil;
}

#pragma mark 取消按钮调用方法
- (void)clickCancelButtonMethod {
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceName"];
    //存入原来的字典
    [[NSUserDefaults standardUserDefaults] setObject:_dic forKey:str];
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark collectionView的cell数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

#pragma mark collectionView的cell样式
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //注册cell
    CustomButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    //监控switch值的变化
    [cell.mySwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    
   //取出设备对应的字典
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellDic = [NSMutableDictionary dictionary];
    deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];
    if ([deviceDic objectForKey:[NSString stringWithFormat:@"cell%ld", indexPath.row]]) {//判断是否存在储存cell设置的字典
        cellDic = [deviceDic objectForKey:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
    }
    
    //设置switch状态
    NSNumber * boolNum = [cellDic objectForKey:@"switch"];
    BOOL isOn = [boolNum boolValue];
    [cell.mySwitch setOn:isOn animated:YES];
    
    
    //根据NSUserDefault保存的数据对cell初始化
    NSString *pic = [cellDic objectForKey:@"pic"];
    
    NSString *text = [cellDic objectForKey:@"text"];

    if (pic) {
        //数组里有值
        cell.insideImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%@", pic]];
        [cell.insideLabel setHidden:YES];
        [cell.insideImageView setHidden:NO];
    }else if (text) {
        //存的是文本
        [cell.insideLabel setHidden:NO];
        cell.insideLabel.text = text;
        [cell.insideImageView setHidden:YES];
        
    }else {
    //原cell所存图标
        
    [cell.insideImageView setHidden:YES];
    
    [cell.insideLabel setHidden:NO];

    cell.insideLabel.text = _dataArray[indexPath.row];
        
    }
    
    return cell;
}

#pragma cell点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    SelectPicViewController *spvc = [[SelectPicViewController alloc]init];
    spvc.row = indexPath.row;
    
    [self.navigationController pushViewController:spvc animated:YES];
    
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.collectionView reloadData];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(kSCREEN_WIDTH / 5 , kSCREEN_HEIGHT / 2.5);
}

#pragma mark switch状态监控
-(void) switchChange:(UISwitch*)sender {
    CustomButtonCollectionViewCell *cell = (CustomButtonCollectionViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];

    //获取当前设备名称
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];
    NSMutableDictionary *cellDic = [NSMutableDictionary dictionary];
    //判断存储cell状态的字典是否存在
    if ([deviceDic objectForKey:[NSString stringWithFormat:@"cell%ld", indexPath.row]]) {
        cellDic = [NSMutableDictionary dictionaryWithDictionary:[deviceDic objectForKey:[NSString stringWithFormat:@"cell%ld", indexPath.row]]];
    }
   //记录switch的状态
    if([sender isOn]) {
        NSNumber * boolNum = [NSNumber numberWithBool:YES];
        [cellDic setObject:boolNum forKey:@"switch"];
        [cellDic setValue:@"0" forKey:@"select"];//如果switch是打开的（允许长按），把cell的点击状态设置为未点击状态
        //存入cell字典中的switch状态
        [deviceDic setObject:cellDic forKey:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
        [defaults setObject:deviceDic forKey:deviceStr];
        [defaults synchronize];
    } else {
        NSNumber * boolNum = [NSNumber numberWithBool:NO];
        [cellDic setObject:boolNum forKey:@"switch"];
        //存入cell字典中的switch状态
        [deviceDic setObject:cellDic forKey:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
        [defaults setObject:deviceDic forKey:deviceStr];
        [defaults synchronize];
        
    }
}


@end
