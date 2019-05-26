//
//  CusNavViewController.m
//  test2
//
//  Created by 余晓聪 on 2019/4/20.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "CusNavViewController.h"

@interface CusNavViewController ()

@end

@implementation CusNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//支持旋转
-(BOOL)shouldAutorotate {
    
    return [self.topViewController shouldAutorotate];
}

//支持方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return [self.topViewController supportedInterfaceOrientations];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
