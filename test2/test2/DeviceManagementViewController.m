//
//  DeviceManagementViewController.m
//  test2
//
//  Created by 余晓聪 on 2019/4/20.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "DeviceManagementViewController.h"
#import "DeviceManagementCell.h"

#define kIs_iPhoneX (kSCREEN_WIDTH == 375.f && kSCREEN_HEIGHT == 812.f)
#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface DeviceManagementViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSMutableArray *dataArray;//数据源数组
@property(nonatomic, copy)NSDictionary *dic;

@end

@implementation DeviceManagementViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickCancelButtonMethod)];
    self.title = @"蓝牙";
    
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceNames"];
    if (arr) {
        _dataArray = [NSMutableArray arrayWithArray:arr];
    }else {
        
        _dataArray = [NSMutableArray arrayWithObjects:@"dgkkie.oak-qff",@"kkclgoq002k.eo-1q24", nil];
        
    }
    
    
    
    [self createViews];
    
    
    
}

#pragma mark 页面布局
-(void)createViews {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
}

#pragma mark 设置cell样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"扫面装置";
            
        }else {
            cell.textLabel.text = @"配对装置";
            cell.textLabel.textColor = [UIColor cyanColor];
            
        }
        return cell;
    } else {
        
        //取出当前设备字典
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *deviceStr = _dataArray[indexPath.row - 2];//设置设备初始风格(默认风格1)
        NSMutableDictionary *deviceDic = [NSMutableDictionary dictionary];
        deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];
        //设置设备初始风格(默认风格1)
        if (![deviceDic objectForKey:@"style"]) {
            [deviceDic setObject:@"0" forKey:@"style"];
            [defaults setObject:deviceDic forKey:deviceStr];
            [defaults synchronize];
        }
        
        DeviceManagementCell *cell = [[DeviceManagementCell alloc]init];
        cell.deviceName.text = [_dataArray objectAtIndex:indexPath.row - 2];
        cell.time.text = @"上次配对时间:04-20 20:29";
        [cell.setting addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventAllEvents];
        
        return cell;
    }
    
}

#pragma mark 设置设备名称按钮
- (void)clickButton:(UIButton *)but{
    
    DeviceManagementCell *cell  = (DeviceManagementCell *)[[but superview] superview];
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"重新命名这个装置" message:@"提示信息" preferredStyle:UIAlertControllerStyleAlert];
    
    
    //点击确定
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *textField = alertController.textFields.firstObject;
        //输入文字不为空,则将输入文字赋值数组,重新布局界面
        if (textField.text.length != 0) {
            
            [self.dataArray replaceObjectAtIndex:indexPath.row - 2 withObject:textField.text];
            
            [[NSUserDefaults standardUserDefaults] setObject:self.dataArray forKey:@"DeviceNames"];//存入数据源数组
            
            [self.tableView reloadData];
        }
        
    }]];
    
    //点击取消
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }]];
    
    //输入文字
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark tableView行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count + 2;
}

#pragma mark tableView点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
            
        default:
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", _dataArray[indexPath.row - 2]] forKey:@"DeviceName"];//存入设备型号
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 60;
    }
    return 88;
}

#pragma mark 取消按钮
- (void)clickCancelButtonMethod {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
