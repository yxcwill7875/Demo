//
//  SelectPicViewController.m
//  test2
//
//  Created by 余晓聪 on 2019/4/12.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "SelectPicViewController.h"
#import "SelectPicCell.h"

#define kIs_iPhoneX (kSCREEN_WIDTH == 375.f && kSCREEN_HEIGHT == 812.f)
#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface SelectPicViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate>

@property (nonatomic, copy)NSMutableArray *dataArray;
@property (nonatomic, strong)UIView *inputBGView;
@property (nonatomic, strong)UITextView *inputTextView;
@property (nonatomic, assign)NSInteger row2;

@end

@implementation SelectPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Select Desired Label";
    self.navigationController.navigationBar.translucent = YES;

    //初始化dataArray
    [self setDataArray];
    
    //页面布局
    [self createViews];
    
    _row2 = -1;
    
    
}

#pragma 数据源数组初始化
-(void)setDataArray {
    _dataArray = [NSMutableArray array];
    for (int i = 0; i < 52; i++) {
        NSString *str = [NSString stringWithFormat:@"/Users/yuxiaocong/Desktop/back/test2/ico/pic%d.png", i + 1 ];
        [_dataArray addObject:str];
    }
    
}

#pragma 页面布局
- (void)createViews {
    //开始UICollectionView布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //cell大小
    flowLayout.itemSize = CGSizeMake(kSCREEN_WIDTH / 9 / 6 * 5, kSCREEN_WIDTH / 9 / 6 * 5);
    //cell最小间距
    flowLayout.minimumInteritemSpacing = kSCREEN_WIDTH / 9 / 6 / 2;
    //每个cell间距
    flowLayout.sectionInset = UIEdgeInsetsMake(kSCREEN_WIDTH / 60, kSCREEN_WIDTH / 60, kSCREEN_WIDTH / 60, kSCREEN_WIDTH / 60);
//    //头视图大小
//    flowLayout.headerReferenceSize = CGSizeMake(kSCREEN_WIDTH, 50);
//    //设置头视图悬停
//    flowLayout.sectionHeadersPinToVisibleBounds = YES;
//
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - kSCREEN_WIDTH / 9) collectionViewLayout:flowLayout];
    
    collectionView.backgroundColor= [UIColor whiteColor];
    //设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
//    //注册头视图
//    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //注册cell
    [collectionView registerClass:[SelectPicCell class] forCellWithReuseIdentifier:@"identifier"];
    
    [self.view addSubview:collectionView];
    
    //设置添加文字按钮
    UIButton *addTextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addTextButton setFrame:CGRectMake(kSCREEN_WIDTH / 60, collectionView.frame.size.height + kSCREEN_WIDTH / 60, flowLayout.itemSize.width, flowLayout.itemSize.height)];
    [addTextButton setImage:[UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/添加.png"] forState:UIControlStateNormal];
    [addTextButton addTarget:self action:@selector(addTextAction) forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:addTextButton];
    
    //设置取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setFrame:CGRectMake(kSCREEN_WIDTH / 3 * 2, addTextButton.frame.origin.y + kSCREEN_WIDTH / 60, kSCREEN_WIDTH / 9, addTextButton.frame.size.height - kSCREEN_WIDTH / 30)];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:24];
    cancelButton.tintColor = [UIColor blackColor];
    cancelButton.backgroundColor = [UIColor whiteColor];
    //设置圆角
    cancelButton.layer. cornerRadius = 5.0f;
    cancelButton.layer.borderWidth = 2.0f;
    [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:cancelButton];
    
    //设置保存按钮
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveButton setFrame:CGRectMake(cancelButton.frame.origin.x + cancelButton.frame.size.width + flowLayout.itemSize.width * 2 / 3, addTextButton.frame.origin.y + kSCREEN_WIDTH / 60, kSCREEN_WIDTH / 9, addTextButton.frame.size.height - kSCREEN_WIDTH / 30)];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:24];
    saveButton.tintColor = [UIColor blackColor];
    saveButton.backgroundColor = [UIColor whiteColor];
    //设置圆角
    saveButton.layer. cornerRadius = 5.0f;
    saveButton.layer.borderWidth = 2.0f;
    //添加点击方法
    [saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:saveButton];
    
    //初始化输入背景视图
    _inputBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT * 2)];
    _inputBGView.backgroundColor = [UIColor whiteColor];
    _inputBGView.alpha = 0.0f;
    
    [self.view addSubview:_inputBGView];
    
    //初始化输入框
    _inputTextView = [[UITextView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH / 2 - flowLayout.itemSize.width * 0.75 , kSCREEN_HEIGHT / 2 - flowLayout.itemSize.width * 0.75, flowLayout.itemSize.width * 1.5, flowLayout.itemSize.width * 1.5)];
    _inputTextView.font = [UIFont systemFontOfSize:24];//字体大小
    _inputTextView.textAlignment = NSTextAlignmentCenter;//居中对齐
    _inputTextView.backgroundColor = [UIColor clearColor];
    _inputTextView.editable = YES;//允许编辑
    _inputTextView.layer.borderWidth = 2.0;//设置边框宽度
    _inputTextView.layer.borderColor = UIColor.grayColor.CGColor;//设置边框颜色
    _inputTextView.layer.cornerRadius = 10.0f;//设置圆角
    _inputTextView.returnKeyType = UIReturnKeyDefault;//return键的类型
    
    _inputTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型

    _inputTextView.delegate = self;
    [_inputBGView addSubview:_inputTextView];
    
    
    //注册通知,监听键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)name:UIKeyboardDidShowNotification object:nil];
    
    //注册通知,监听键盘消失事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden)name:UIKeyboardDidHideNotification object:nil];
    

}

#pragma mark 控制输入框文本长度方法及点击return执行方法
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (range.location >= 20) {
        //控制文本输入长度
        return NO;
    }
    //取出当前设备字典
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionary];
    deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];
    //点击return执行的方法
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        //文本长度不为0
        if (_inputTextView.text.length != 0 ) {
            //如果已存图片信息,清除
            //判断是否存在存储cell信息的字典
             NSMutableDictionary *cellDic = [NSMutableDictionary dictionary];
            //防止cell字典为空
            if ([deviceDic objectForKey:[NSString stringWithFormat:@"cell%ld", _row]]) {
                cellDic = [NSMutableDictionary dictionaryWithDictionary:[deviceDic objectForKey:[NSString stringWithFormat:@"cell%ld", _row]]];
            }
           
            if ([cellDic objectForKey:@"pic"]) {
                [cellDic removeObjectForKey:@"pic"];
                NSLog(@"%@", cellDic);
            }
            //保存输入的文本
            
            [cellDic setValue:textView.text forKey:@"text"];
            [deviceDic setObject:cellDic forKey:[NSString stringWithFormat:@"cell%ld", _row]];
            [defaults setObject:deviceDic forKey:deviceStr];
            [defaults synchronize];
            //回到上个界面
            [self.navigationController popViewControllerAnimated:YES];
            return NO;
        }
    }
    
    return YES;
}

#pragma mark 点击取消按钮方案
-(void)cancelButtonAction {
    
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark 点击保存按钮方法
-(void)saveButtonAction {
    //判断是否有操作,无操作则返回
    if (_row2 != -1) {
        //取出当前设备字典
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *deviceStr = [defaults objectForKey:@"DeviceName"];
        NSMutableDictionary *deviceDic = [NSMutableDictionary dictionary];
        deviceDic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:deviceStr]];
        NSMutableDictionary *cellDic = [NSMutableDictionary dictionary];
        //防止cell字典为空
        if ([deviceDic objectForKey:[NSString stringWithFormat:@"cell%ld", _row]]) {
            cellDic = [NSMutableDictionary dictionaryWithDictionary:[deviceDic objectForKey:[NSString stringWithFormat:@"cell%ld", _row]]];
        }
        //删除文字
        if ([cellDic objectForKey:@"text"]) {
            [cellDic removeObjectForKey:@"text"];
        }
        

        //保存选择的图标在数组中的下标
        NSString *str = [NSString stringWithFormat:@"%ld", _row2 + 1];
        
        [cellDic setValue:str forKey:@"pic"];
        [deviceDic setObject:cellDic forKey:[NSString stringWithFormat:@"cell%ld", _row]];
        [defaults setObject:deviceDic forKey:deviceStr];//更新设备字典
        [defaults synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark 点击添加文字按钮方法
-(void)addTextAction {
    
    if (_inputBGView.alpha < 0.01f) {
        _inputBGView.alpha = 0.8f;
    }
    [_inputTextView isFirstResponder];
}

#pragma mark 设置cell样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    
    cell.cellImageView.image = [UIImage imageNamed:_dataArray[indexPath.row]];
    
    return cell;
}

#pragma mark cell个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
}


#pragma mark cell点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    _row2 = indexPath.row;
    
}


// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kSCREEN_WIDTH / 60;
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kSCREEN_WIDTH / 60;
}

#pragma mark 键盘遮挡问题
// 键盘弹出时
-(void)keyboardDidShow:(NSNotification *)notification
{
    //获取键盘高度
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    
    [keyboardObject getValue:&keyboardRect];
    
    //得到键盘的高度
//    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //调整放置有textView的view的位置
    
    //设置动画
    [UIView beginAnimations:nil context:nil];
    
    //定义动画时间
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:0];
    
    //设置view的frame，往上平移
    [_inputBGView setFrame:CGRectMake(0, 0 - keyboardRect.size.height + 100, kSCREEN_WIDTH, kSCREEN_HEIGHT * 2)];
    
    //提交动画
    [UIView commitAnimations];
    
}

//键盘消失时
-(void)keyboardDidHidden
{
    //定义动画
    [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:0.25f];
    
    //设置view的frame，往下平移
    [_inputBGView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT * 2)];
    _inputBGView.alpha = 0.0f;
     [UIView commitAnimations];
}

//点击屏幕空白处
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //回收键盘，两种方式
//    [_inputTextView resignFirstResponder];
    [self.view endEditing:YES];
    
    
}


@end
