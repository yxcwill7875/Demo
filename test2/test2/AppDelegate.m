//
//  AppDelegate.m
//  test
//
//  Created by 余晓聪 on 2019/4/2.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CusNavViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    //创建视图控制器的对象
    ViewController *vc = [[ViewController alloc]init];
    //创建导航控制器
    CusNavViewController *nav = [[CusNavViewController alloc]initWithRootViewController:vc];
    //修改状态栏的背景颜色(系统方法)
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    
    //设置window的根视图控制器
    _window.rootViewController = nav;
    
    //初始化UISwitch的状态
//    NSDictionary *dic = [NSDictionary dictionary];//布局使用的字典
//
//    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"style"];
//
   
    [self registerAPN];
    
    [self setStyle];
    
    return YES;
}

- (void)registerAPN {
    if (@available(iOS 10.0, *)) { // iOS10 以上
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
    } else {// iOS8.0 以上
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}

#pragma mark 设置初始风格
-(void)setStyle {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"DeviceName"]) {
        [defaults setObject:@"Device Name" forKey:@"DeviceName"];//设置初始的设备名称
    }
    NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionary];
    if (![defaults objectForKey:deviceStr]) {
        [deviceDic setObject:@"0" forKey:@"style"];//设置默认的风格
        [defaults setObject:deviceDic forKey:deviceStr];
    }
    
}

#pragma mark 支持窗口翻转
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window

{
    
    if (_allowRotation == YES) {
        
        return UIInterfaceOrientationMaskLandscapeRight;
        
    }else{
        
        return (UIInterfaceOrientationMaskPortrait);
        
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
