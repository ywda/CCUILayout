//
//  WDZLoginCenterVC.m
//  refactor_LoginCenter
//
//  Created by Admin on 2020/5/15.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutDemo07VC.h"
#import "WDZLoginCenterItem00.h"   // `切换服务器`元素
#import "WDZLoginCenterItem01.h"   // `AppLogo图标`元素
#import "WDZLoginCenterItem02.h"   // `电话号码/用户名、密码、手机号码、验证码`4个元素
#import "WDZLoginCenterItem03.h"   // `登录按钮`元素
#import "WDZLoginCenterItem04.h"   // `账号登录<->验证码登录`元素
#import "WDZLoginCenterItem05.h"   // `忘记密码|新用户注册`元素
#import "WDZLoginCenterItem06.h"   // `版本号`元素
#import "WDZLoginCenterSegLine.h"  // `分割线(空白填充)`元素


@interface CCUILayoutDemo07VC ()

@end

@implementation CCUILayoutDemo07VC

- (instancetype)init
{
    self = [super init];
    if (self) {
        //这里不选择从plist加载，因为有些元素要变化，后面更新工具用plist适配这样的场景中
        [self configUIControlsIsLoadDebug:YES mainTabEdges:UIEdgeInsetsZero adapterApp:NO];
        
        //实例化创建页面
//        NSMutableArray *uiElements = [self createInstantiationUiElements];
//
//        [self configUIControls:uiElements[0]
//                        layout:uiElements[1]
//                  mainTabEdges:UIEdgeInsetsZero];
        
    }
    return self;
}

// MARK: 实例化创建页面元素初始化 Elements
- (NSMutableArray*) createInstantiationUiElements
{
    CGFloat SCREEN_H = self.view.frame.size.height;
    
    // 👇 各个元素的高度值设置<由上至下设值>
    CGFloat switchSever_H = 44;
    CGFloat appLogo_H = 200;
    CGFloat account_H = 50;
    CGFloat code_H = 50;
    CGFloat loginBtn_H = 40;
    CGFloat switchTF_H = 100;
    CGFloat segLine_H = 0.0f;
    CGFloat forget_register_H = 40;
    CGFloat version_H = 30;
    
    segLine_H = SCREEN_H - (switchSever_H + appLogo_H + account_H + code_H + loginBtn_H + switchTF_H + forget_register_H  + version_H);
    // 👆 各个元素的高度值设置
    NSMutableArray *uies = [NSMutableArray array];
    
    NSMutableArray<UIResponder*>*uis = [NSMutableArray array];
    NSMutableArray<CCUILayoutUiMode*>*uims = [NSMutableArray array];
    
    
    WDZLoginCenterItem00 * item0 = [WDZLoginCenterItem00 new];
    CCUILayoutUiMode *em0 = [CCUILayoutUiMode new];
    em0.bind = [NSNumber numberWithInt:1];
    em0.desc = @"备注说明：切换服务器_UI元素";
    em0.height = switchSever_H;
    em0.name = NSStringFromClass([item0 class]);
    item0.CLM = em0;
    [uis addObject:item0];
    [uims addObject:em0];
    
    
    WDZLoginCenterItem01 * item1 = [WDZLoginCenterItem01 new];
    CCUILayoutUiMode *em1 = [CCUILayoutUiMode new];
    em1.bind = [NSNumber numberWithInt:2];
    em1.desc = @"备注说明：AppLogo图标_UI元素";
    em1.height = appLogo_H;
    em1.name = NSStringFromClass([item1 class]);
    item1.CLM = em1;
    [uis addObject:item1];
    [uims addObject:em1];
    
    
    WDZLoginCenterItem02 * item2_0 = [WDZLoginCenterItem02 new];
    CCUILayoutUiMode *em2_0 = [CCUILayoutUiMode new];
    em2_0.bind = [NSNumber numberWithInt:3];
    em2_0.desc = @"备注说明：电话号码/用户名、密码、手机号码、验证码_UI元素(funcType字段值控制使用说明 \n eg: \n \
                  1、ccl_type0  电话号码/用户名 ✅ \n \
                  2、ccl_type1  密码 \n \
                  3、ccl_type2  手机号码 ✅ \n \
                  4、ccl_type3  验证码 ) \n ";
    em2_0.height = account_H;
    em2_0.name = NSStringFromClass([item2_0 class]);
    item2_0.CLM = em2_0;
    [uis addObject:item2_0];
    [uims addObject:em2_0];
    
    
    WDZLoginCenterItem02 * item2_1 = [WDZLoginCenterItem02 new];
    CCUILayoutUiMode *em2_1 = [CCUILayoutUiMode new];
    em2_1.bind = [NSNumber numberWithInt:4];
    em2_1.desc = @"备注说明：电话号码/用户名、密码、手机号码、验证码_UI元素(funcType字段值控制使用说明 \n eg: \n \
                 1、ccl_type0  电话号码/用户名 ✅ \n \
                 2、ccl_type1  密码 \n \
                 3、ccl_type2  手机号码 ✅ \n \
                 4、ccl_type3  验证码 ) \n ";
    em2_1.height = code_H;
    em2_1.name = NSStringFromClass([item2_1 class]);
    item2_1.CLM = em2_1;
    [uis addObject:item2_1];
    [uims addObject:em2_1];
    
    
    WDZLoginCenterItem03 * item3 = [WDZLoginCenterItem03 new];
    CCUILayoutUiMode *em3 = [CCUILayoutUiMode new];
    em3.bind = [NSNumber numberWithInt:5];
    em3.desc = @"备注说明：登录按钮区域_UI元素";
    em3.height = code_H;
    em3.name = NSStringFromClass([item3 class]);
    item3.CLM = em3;
    [uis addObject:item3];
    [uims addObject:em3];
    
    
    WDZLoginCenterItem04 * item4 = [WDZLoginCenterItem04 new];
    CCUILayoutUiMode *em4 = [CCUILayoutUiMode new];
    em4.bind = [NSNumber numberWithInt:6];
    em4.desc = @"备注说明：验证码登录<——>账号登录_UI元素";
    em4.height = switchTF_H;
    em4.name = NSStringFromClass([item4 class]);
    item4.CLM = em4;
    [uis addObject:item4];
    [uims addObject:em4];
    
    
    WDZLoginCenterItem05 * item5 = [WDZLoginCenterItem05 new];
    CCUILayoutUiMode *em5 = [CCUILayoutUiMode new];
    em5.bind = [NSNumber numberWithInt:-1];
    em5.desc = @"备注说明：分割线（空白填充）_UI元素";
    em5.height = segLine_H;
    em5.name = NSStringFromClass([item5 class]);
    item5.CLM = em5;
    [uis addObject:item5];
    [uims addObject:em5];
    
    
    WDZLoginCenterSegLine * segLine = [WDZLoginCenterSegLine new];
    CCUILayoutUiMode *sem = [CCUILayoutUiMode new];
    sem.bind = [NSNumber numberWithInt:7];
    sem.desc = @"忘记密码|新用户注册_UI元素";
    sem.height = forget_register_H;
    sem.name = NSStringFromClass([segLine class]);
    segLine.CLM = sem;
    [uis addObject:segLine];
    [uims addObject:sem];
    
    
    WDZLoginCenterItem06 * item6 = [WDZLoginCenterItem06 new];
    CCUILayoutUiMode *em6 = [CCUILayoutUiMode new];
    em6.bind = [NSNumber numberWithInt:8];
    em6.desc = @"备注说明：版本号信息_UI元素";
    em6.height = version_H;
    em6.name = NSStringFromClass([item6 class]);
    item6.CLM = em6;
    [uis addObject:item6];
    [uims addObject:em6];
    
    
    [uies addObject:uis];
    [uies addObject:uims];
    return uies;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CCUILayout_RANDOM_COLOR_LIGHT;
    
    //__weak typeof(self) weakSelf = self;
    [self wholeUIControls:^(NSArray<UIResponder *> *uis, NSMutableArray<CCUILayoutUiMode *> * uims) {
        
        // 重新更新布局
        //[weakSelf updateUIControls:@[]];
    }];
    
    [self setDebugShowSection:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

@end
