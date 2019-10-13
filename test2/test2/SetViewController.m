//
//  SetViewController.m
//  test2
//
//  Created by 余晓聪 on 2019/4/9.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "SetViewController.h"
#import "SetCollectionViewCell.h"
#import "SetPicViewController.h"
#import "PanelsViewController.h"
#import "DeviceManagementViewController.h"
#import "AboutViewController.h"
#import "SettingViewController.h"

#define kIs_iPhoneX (kSCREEN_WIDTH == 375.f && kSCREEN_HEIGHT == 812.f)
#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface SetViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)NSArray *dataArray;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];//导航栏颜色
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];//返回键颜色
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackButtonAction)];
    self.title = @"haonwiaiakfjklankfnaifianwfhafnkabfkunakfuiafiabkuf";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0f], NSForegroundColorAttributeName:[UIColor whiteColor]}];//title颜色和字体大小
    
    _dataArray = [NSArray arrayWithObjects:@"Custom Buttons", @"Panels", @"Device Management", @"Setting", @"About", nil];
    
    [self createViews];
    
}

#pragma mark 布局页面
- (void)createViews {
    //初始化U集合视图布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //每个cell大小
    flowLayout.itemSize = CGSizeMake(kSCREEN_WIDTH / 2 - 50, kSCREEN_HEIGHT / 5);
    flowLayout.sectionInset = UIEdgeInsetsMake(kSCREEN_HEIGHT / 16, kSCREEN_HEIGHT / 16, kSCREEN_HEIGHT / 16, kSCREEN_HEIGHT / 16);
    //cell间距
    flowLayout.minimumInteritemSpacing = kSCREEN_HEIGHT / 16;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) collectionViewLayout:flowLayout];
    
    
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //注册cell
    [_collectionView registerClass:[SetCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    
    [self.view addSubview:_collectionView];
    
}

#pragma mark 返回按钮方法
- (void)clickBackButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark cell个数

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
    
}

#pragma mark cell样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.label.text = _dataArray[indexPath.row];
    
    return cell;
    
}

#pragma mark cell点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SetPicViewController *stvc = [[SetPicViewController alloc] init];
    PanelsViewController *pvc = [[PanelsViewController alloc]init];
    DeviceManagementViewController *dmvc = [[DeviceManagementViewController alloc]init];
    AboutViewController *avc = [[AboutViewController alloc]init];
    SettingViewController *svc = [[SettingViewController alloc]init];
    //获取当前设备名称
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];

    switch (indexPath.row) {
        case 0:
            if (deviceDic) {
                //把当前数据存入stvc.dic中
                stvc.dic = deviceDic;
            }
            
            [self.navigationController pushViewController:stvc animated:YES];
            
                        break;
        case 1:
            [self.navigationController pushViewController:pvc animated:YES];

            break;
        case 2:
            [self.navigationController pushViewController:dmvc animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:svc animated:YES];
            break;
        
        case 4:
            [self.navigationController pushViewController:avc animated:YES];
            break;
    }
    
}

//-(BOOL)shouldAutorotate {
//
//    return YES;
//}
//
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
//
//    return UIInterfaceOrientationMaskLandscapeLeft;
//}


//-(void)viewWillAppear:(BOOL)animated{
//    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
//    
//    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
//    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
//}


// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kSCREEN_HEIGHT / 16 ;
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kSCREEN_HEIGHT / 14;
}


@end
