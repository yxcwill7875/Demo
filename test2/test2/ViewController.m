//
//  ViewController.m
//  test
//
//  Created by 余晓聪 on 2019/4/2.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ButtonCollectionViewCell.h"
#import "SetViewController.h"
#import <UserNotifications/UserNotifications.h>

#define kIs_iPhoneX (kSCREEN_WIDTH == 375.f && kSCREEN_HEIGHT == 812.f)
#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
//    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];
//    NSLog(@"style-------%@---------style", [deviceDic objectForKey:@"style"]);
    
    //横屏
    [self setRotationMethod];
    
    //初始化数据源数组
    _dataArray = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
    //页面布局
    [self createViews];
    
    
}

#pragma 页面布局方法
- (void)createViews {
    //开始UICollecView布局
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
    _collectionView.allowsMultipleSelection = YES;
    _collectionView.backgroundColor = [UIColor blackColor];
    
    //注册cell
    [_collectionView registerClass:[ButtonCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    
    [self.view addSubview:_collectionView];
    
    //初始化电池label
    UILabel *batteryLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, kSCREEN_HEIGHT - kSCREEN_HEIGHT / 8, flowLayout.itemSize.width, kSCREEN_HEIGHT / 8)];
    batteryLabel.text = @"DC 13.4V";
    batteryLabel.backgroundColor = [UIColor blackColor];
    batteryLabel.textColor = [UIColor whiteColor];
    batteryLabel.textAlignment = NSTextAlignmentCenter;
    batteryLabel.font = [UIFont systemFontOfSize:24];
    
    [self.view addSubview:batteryLabel];
    
    //初始化电池图片
    UIImageView *batteryImageView = [[UIImageView alloc]initWithFrame:CGRectMake(batteryLabel.frame.origin.x + batteryLabel.frame.size.width, batteryLabel.frame.origin.y, batteryLabel.frame.size.width, batteryLabel.frame.size.height)];
    [batteryImageView setImage:[UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test/ico/battery.png"]];
    
    [self.view addSubview:batteryImageView];
    
    //设置标题Label
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH / 2, batteryImageView.frame.origin.y, kSCREEN_WIDTH / 2 - batteryImageView.frame.size.height, batteryImageView.frame.size.height)];
    _titleLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceName"];
    _titleLabel.font = [UIFont systemFontOfSize:24];
    _titleLabel.textColor = batteryLabel.textColor;
    _titleLabel.backgroundColor = self.view.backgroundColor;
    
    [self.view addSubview:_titleLabel];
    
    //设置按钮
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [setButton setFrame:CGRectMake(_titleLabel.frame.size.width + _titleLabel.frame.origin.x, _titleLabel.frame.origin.y, _titleLabel.frame.size.height, _titleLabel.frame.size.height)];
    [setButton setBackgroundImage:[UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test/ico/shezhi.png"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(clickSetButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:setButton];
    
}

#pragma 设置按钮调用方法
- (void)clickSetButtonMethod {
    
    SetViewController *setVC = [[SetViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];

}

#pragma 横屏方法
- (void)setRotationMethod {
    //横屏
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.allowRotation = YES;//(以上2行代码,可以理解为打开横屏开关)
    
    [self setNewOrientation:YES];//调用转屏代码
    
}

#pragma mark collectionView的cell数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

#pragma mark collectionView的cell样式
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    //取出设备对应的字典
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellDic = [NSMutableDictionary dictionary];
    deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];
    if ([deviceDic objectForKey:[NSString stringWithFormat:@"cell%ld", indexPath.row]]) {//判断是否存在储存cell设置的字典
        cellDic = [deviceDic objectForKey:[NSString stringWithFormat:@"cell%ld", indexPath.row]];
    }
    
    
    NSLog(@"select---%@", [cellDic objectForKey:@"select"]);
    //根据NSUserDefault保存的数据对cell初始化
    NSString *pic = [cellDic objectForKey:@"pic"];
    
    NSString *text = [cellDic objectForKey:@"text"];

    
    if (pic) {
        //数组里有值
        cell.picImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"/Users/yuxiaocong/Desktop/back/test2/ico/pic%@.png", pic]];
        [cell.insideLabel setHidden:YES];
        [cell.picImageView setHidden:NO];
        
    }else if (text) {
        //存的是文本
        [cell.insideLabel setHidden:NO];
        cell.insideLabel.text = text;
        [cell.picImageView setHidden:YES];
        
    }else {
        //原cell所存图标
        
        [cell.picImageView setHidden:YES];
        
        [cell.insideLabel setHidden:NO];
        
        cell.insideLabel.text = _dataArray[indexPath.row];
        
    }
    if ([[deviceDic objectForKey:@"style"] isEqualToString:@"0"]) {
        //常规布局
        
        cell.cellImageView.image = [UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/SP5110-UI Btn-OFF-外框_20190403.png"];
        cell.insideImageView.image = [UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/SP5110-UI Btn-OFF-內框_20190403.png"];
        
        
    }else if ([[deviceDic objectForKey:@"style"] isEqualToString:@"1"]){
        //水滴形布局
         cell.cellImageView.image = [UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/SP5110-UI-2 Btn-OFF-外框_20190412.png"];
        cell.insideImageView.image = [UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/SP5110-UI-2 Btn-OFF-內框_20190412.png"];
    }
    
    cell.backgroundColor = self.view.backgroundColor;
    
    if (indexPath.row == 4 || indexPath.row == 9) {
        cell.leftLineImageView.alpha = 0.0f;
    }
    if (indexPath.row > 4 ) {
        cell.downLineImageView.alpha = 0.0f;
        
    }
    
    //取出select状态
    NSNumber * boolNum = [cellDic objectForKey:@"select"];
    BOOL isOn = [boolNum boolValue];
    //cell是否打开
    if (isOn) {//如果cell是被点击的
                [cell setSelected:isOn];
    }else {
                [cell setSelected:NO];
    }
    
    return cell;
}

#pragma mark cell点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ButtonCollectionViewCell *cell = (ButtonCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    //取出设备对应的字典
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellDic = [NSMutableDictionary dictionary];
    deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];
    if ([deviceDic objectForKey:[NSString stringWithFormat:@"cell%ld", indexPath.row]]) {
        cellDic = [NSMutableDictionary dictionaryWithDictionary:[deviceDic objectForKey:[NSString stringWithFormat:@"cell%ld", indexPath.row]]];
    }
    
    NSNumber * boolSwitch = [cellDic objectForKey:@"switch"];
    BOOL isOn = [boolSwitch boolValue];
    
    if (isOn) {
        //开关是开的(长按)
        
        NSLog(@"这个Cell要长按才行啊!!!");
        
    }else {//开关是关的,记录cell的点击状态(BOOL值记录)
        NSNumber * boolSelect = [cellDic objectForKey:@"select"];
        BOOL isSelect = [boolSelect boolValue];//取出点击状态bool值
        if (isSelect) {//如果cell是被点击的
            boolSelect = [NSNumber numberWithBool:NO];
            
            [cellDic setObject:boolSelect forKey:@"select"];//存入点击状态
            [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        }else {
            boolSelect = [NSNumber numberWithBool:YES];
            [cellDic setObject:boolSelect forKey:@"select"];
            [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        }
        
        NSLog(@"select---%@", [cellDic objectForKey:@"select"]);
        
        [deviceDic setObject:cellDic forKey:[NSString stringWithFormat:@"cell%ld",indexPath.row]];
        [defaults setObject:deviceDic forKey:deviceStr];
    }
    
    
    
}


#pragma mark 添加通知
- (void)addLocalNoticeWithIndexPath:(NSIndexPath *)indexPath {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        // 标题
        content.title = @"测试标题";
        content.subtitle = @"测试通知副标题";
        // 内容
        content.body = @"测试通知的具体内容";
        // 声音
        // 默认声音
        //    content.sound = [UNNotificationSound defaultSound];
        // 添加自定义声音
        content.sound = [UNNotificationSound soundNamed:@"Alert_ActivityGoalAttained_Salient_Haptic.caf"];
        // 角标 （我这里测试的角标无效，暂时没找到原因）
        content.badge = @1;
        // 多少秒后发送,可以将固定的日期转化为时间
        NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:1] timeIntervalSinceNow];
        //        NSTimeInterval time = 10;
        // repeats，是否重复，如果重复的话时间必须大于60s，要不会报错
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];
        
        // 添加通知的标识符，可以用于移除，更新等操作
        NSString *identifier = @"noticeId";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            NSLog(@"成功添加推送");
        }];
    }else {
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        // 发出推送的日期
        notif.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
        // 推送的内容
        notif.alertBody = @"你已经10秒没出现了";
        // 可以添加特定信息
        notif.userInfo = @{@"noticeId":@"00001"};
        // 角标
        notif.applicationIconBadgeNumber = 1;
        // 提示音
        notif.soundName = UILocalNotificationDefaultSoundName;
        // 每周循环提醒
        notif.repeatInterval = NSCalendarUnitWeekOfYear;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
}

#pragma mark 判断用户是否允许接收通知
- (void)checkUserNotificationEnable { // 判断用户是否允许接收通知
    if (@available(iOS 10.0, *)) {
        __block BOOL isOn = NO;
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.notificationCenterSetting == UNNotificationSettingEnabled) {
                isOn = YES;
                NSLog(@"打开了通知");
            }else {
                isOn = NO;
                NSLog(@"关闭了通知");
                [self showAlertView];
            }
        }];
    }else {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone){
            NSLog(@"关闭了通知");
            [self showAlertView];
        }else {
            NSLog(@"打开了通知");
        }
    }
}

- (void)showAlertView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"通知" message:@"未获得通知权限，请前去设置" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goToAppSystemSetting];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改
- (void)goToAppSystemSetting {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([application canOpenURL:url]) {
            if (@available(iOS 10.0, *)) {
                if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                    [application openURL:url options:@{} completionHandler:nil];
                }
            }else {
                [application openURL:url];
            }
        }
    });
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
    

#pragma mark 横屏方法
- (void)setNewOrientation:(BOOL)fullscreen

{
    if (fullscreen) {
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }else{
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES];
    _titleLabel = [UILabel alloc];
    [_titleLabel setText: [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceName"]];
    
    [_collectionView reloadData];
}



@end
