//
//  SettingViewController.m
//  test2
//
//  Created by 余晓聪 on 2019/4/20.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "SettingViewController.h"
#import "NotificationCell.h"
#import "NotificationCell2.h"
#import "NotificationCell3.h"

#define kIs_iPhoneX (kSCREEN_WIDTH == 375.f && kSCREEN_HEIGHT == 812.f)
#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSArray *dataArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(clickCancelButtonMethod)];
    self.title = @"设定通知";
  
    [self createViews];
    
}

-(void)createViews {
    
    _dataArray = @[@"显示通知", @"允许使用通知点", @"使用LED灯来显示来电通知", @"通知音效", @"低电压警报", @"单路跳电警报", @"总电流过载警报"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UITableView alloc]init];
    
    [self.view addSubview:_tableView];
    
}

#pragma mark cell样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 3) {
        NotificationCell3 *cell = [[NotificationCell3 alloc]init];
        if (indexPath.row == 0) {
            cell.tipsLabel.text = @"显示所有通知内容";
        } else {
            cell.tipsLabel.text = @",dkkookkf";
        }
        cell.titleLabel.text = _dataArray[indexPath.row];
        return cell;
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        
        NotificationCell2 *cell = [[NotificationCell2 alloc]init];
        cell.titleLabel.text = _dataArray[indexPath.row];
        if (indexPath.row == 1) {
            NSLog(@"cell1    =====    %d", [[NSUserDefaults standardUserDefaults] boolForKey:@"notif"]);
            [cell.mySwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"notif"]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } else {
            
            [cell.mySwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"notifLED"]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [cell.mySwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        
        
        return cell;
    } else {
        
        NotificationCell *cell = [[NotificationCell alloc]init];
        cell.titleLabel.text = _dataArray[indexPath.row];
        
        if (indexPath.row == 4) {
            cell.tipsLabel.text = @"电压过低时发出通知";
            [cell.mySwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"notifDDY"]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } else if (indexPath.row == 5) {
            cell.tipsLabel.text = @"单路负载跳电时发出通知";
            [cell.mySwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"notifDLTD"]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } else {
            cell.tipsLabel.text = @"总电流过载时发出通知";
            [cell.mySwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"notifZDLGZ"]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        [cell.mySwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        return cell;
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BOOL isOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"notif"];
    if (isOn) {
        return _dataArray.count;

    }
    return 2;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}

#pragma mark switch状态监控
-(void) switchChange:(UISwitch*)sender {
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSLog(@"-----%ld", indexPath.row);
    switch (indexPath.row) {
        case 1:
            if([sender isOn]){
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notif"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSLog(@"%d", sender.on);
                
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"notif"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            [_tableView reloadData];
            break;
            
        case 2:
            if([sender isOn]){
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notifLED"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"notifLED"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            [_tableView reloadData];
            break;
        case 4:
            if([sender isOn]){
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notifDDY"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"notifDDY"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            [_tableView reloadData];
            break;
        case 5:
            if([sender isOn]){
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notifDLTD"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"notifDLTD"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            [_tableView reloadData];
            break;
        case 6:
            if([sender isOn]){
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notifZDLGZ"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"notifZDLGZ"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            [_tableView reloadData];
            break;
            
    }
    
}

- (void)clickCancelButtonMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
