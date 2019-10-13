//
//  BlueToothSingleton.m
//  test2
//
//  Created by 余晓聪 on 2019/9/17.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "BlueToothSingleton.h"
#define kServiceUUID (@"aaabbbccc")
static BlueToothSingleton *BTS = nil;


@implementation BlueToothSingleton


- (instancetype)init
{
    self = [super init];
    if (self) {
        //这里centralManager需要设置CBCentralManagerDelegate,CBPeripheralDelegate这两个代理
        _myCentralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil options:nil];
    }
    return self;
}

+ (instancetype)shareInstance
{
    //这里是通过GCD的once方法实现单例的创建，该方法在整个应用程序中只会执行一次，所以经常用作单例的创建。
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BTS = [[self alloc] init];
    });
    
    return BTS;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BTS = [super allocWithZone:zone];
    });
    
    return BTS;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - 懒加载
- (NSMutableArray *)deviceArr
{
    if (!_deviceArr) {
        _deviceArr = [NSMutableArray array];
    }
    
    return _deviceArr;
}


#pragma mark - 扫面设备
-(void)scanDevice
{
    [self.deviceArr removeAllObjects];
    //这里的第一个参数设置为nil，就扫描所有的设备，如果只想返回特定的服务的设备，就给服务的数组
    [_myCentralManager scanForPeripheralsWithServices:nil options:nil];
}

#pragma mark 停止扫描
-(void)stopScan
{
    [_myCentralManager stopScan];
}


-(void)connectPeripheral:(CBPeripheral *)peripheral
{
    self.currentPer = peripheral;
    //请求连接到此外设
    [_myCentralManager connectPeripheral:peripheral options:nil];
}

- (void)unConnectPeripheral
{
    [self.myCentralManager cancelPeripheralConnection:self.currentPer];
}

//重连方法
-(void)reConnectDevice:(BOOL)isConnect {
    
    
}

- (NSArray *)retrieveConnectedPeripherals
{
    //这里值得注意，在ios9.0之前，可以用retrieveConnectedPeripherals这个方法来返回手机已经连接的设备，
    //但是在9.0被废弃了，现在需要特定的服务UUID才能返回特定的已连接设备。
    return [_myCentralManager retrieveConnectedPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
}

#pragma mark - CBCentralManagerDelegate
//检查设备蓝牙开关的状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state == CBCentralManagerStatePoweredOn) {
        NSLog(@"蓝牙已打开");
        [_myCentralManager scanForPeripheralsWithServices:nil options:nil];
    }else {
        NSLog(@"蓝牙已关闭");
    }
}

//查找到正在广播的外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"Discovered %@", peripheral.name);
    //当你发现你感兴趣的外围设备，停止扫描其他设备，以节省电能。
    if (![self.deviceArr containsObject:peripheral]) {
        [self.deviceArr addObject:peripheral];
        if ([self.discoverDelegate respondsToSelector:@selector(BLEDidDiscoverDeviceWithMAC:)])   {
            //返回扫描到的设备实例
            [self.discoverDelegate BLEDidDiscoverDeviceWithMAC:peripheral];
        }
    }
}

//连接成功
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接%@外设成功",peripheral.name);
    peripheral.delegate = self;
    //传入nil会返回所有服务;一般会传入你想要服务的UUID所组成的数组,就会返回指定的服务
    [peripheral discoverServices:nil];
}

//连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"连接失败");
}

#pragma mark - CBPeripheralDelegate
//发现到服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    for (CBService *service in peripheral.services) {
        NSLog(@"Discovered service %@",service.UUID);
        
        //返回特定的服务，订阅的特征即可
//        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kWriteCharacteristicUUID],[CBUUID UUIDWithString:kNotifyCharacteristicUUID]] forService:service];
    }
}

//获得某服务的特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"Discovered characteristic %@", characteristic.UUID);
        
        //保存写入特征
//        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kWriteCharacteristicUUID]]) {
//            self.currentDev.writeCharacteristic = characteristic;
//        }
        
        //保存订阅特征
//        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kNotifyCharacteristicUUID]]) {
//            self.currentDev.notifyCharacteristic = characteristic;
//            //订阅该特征
//            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//        }
    }
}



@end
