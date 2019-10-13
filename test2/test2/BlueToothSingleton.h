//
//  BlueToothSingleton.h
//  test2
//
//  Created by 余晓聪 on 2019/9/17.
//  Copyright © 2019年 余晓聪. All rights reserved.
//
//蓝牙控制器单例文件

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

//扫描设备协议
@protocol BleDelegate <NSObject>

@required
- (void)BLEDidDiscoverDeviceWithMAC:(CBPeripheral *)peripheral;
@end

@interface BlueToothSingleton : NSObject <CBCentralManagerDelegate,CBPeripheralDelegate>
@property (nonatomic ,strong) NSMutableArray *deviceArr;
//中央设备的属性，全部操作都是通过这个来
@property (nonatomic ,strong)CBCentralManager *myCentralManager;
@property (nonatomic ,strong) CBPeripheral *currentPer;
@property (nonatomic ,weak)id<BleDelegate>discoverDelegate;


+ (instancetype)shareInstance;

#pragma mark - action of connecting layer -连接层操作
//扫描设备
- (void)scanDevice;

//停止扫描
- (void)stopScan;

//连接设备
- (void)connectPeripheral:(CBPeripheral *)peripheral;

//断开设备连接
- (void)unConnectPeripheral;

//重连设备
- (void)reConnectDevice:(BOOL)isConnect;

//检索已连接的外接设备
- (NSArray *)retrieveConnectedPeripherals;

@end




