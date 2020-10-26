//
//  CCUIContainerDemo03VC.m
//  CCUIContainer
//  MARK: 模拟从创建的实例数组快速创建 页面 demo 父类 CCUIContainerBaseVC
//  Created by Admin on 2020/5/14.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerDemo03VC.h"

@interface CCUIContainerDemo03VC ()

@end

@implementation CCUIContainerDemo03VC

- (instancetype)init
{
    self = [super init];
    if (self) {
        //{top, left, bottom, right};
        UIEdgeInsets insets = UIEdgeInsetsMake(100, 0, 0, -0);
        
        NSMutableArray *uis = [NSMutableArray array];
        NSMutableArray *uiMs = [NSMutableArray array];
        
        // 通过实例创建 5 个 View
        for (int i = 0; i < 5; i++) {
            // MARK: 模拟传入实例对象值
            CCUIContainerView *tmp = [CCUIContainerView new];
            // 不能在这里 为 tmp 中添加子元素 <tmp 是独立封装好的 view 类>
            [uis addObject:tmp];
            
            CCUIContainerUiMode *cm = [CCUIContainerUiMode new];
            cm.height = (50+3*i);
            cm.bind = [[NSNumber alloc] initWithInt:i];
            [uiMs addObject:cm];
        }
        [self configUIControls:[NSArray arrayWithArray:uis]
                        layout:[NSArray arrayWithArray:uiMs]
                  mainTabEdges:insets];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self simulation_navBar];
    [self setDebugShowSection:YES];
}

// MARK: 模拟当前项目中的导航条
- (void) simulation_navBar
{
    UIView *top = [UIView new];
    top.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:top];
    
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(100);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    // 模拟 wdz 项目中的一个导航条
    [self.view bringSubviewToFront:top];
    
    __weak typeof(self) ws = self;
    [self wholeUIControls:^(NSArray<UIResponder *> * uis, NSMutableArray<CCUIContainerUiMode *> * uims) {
        ws.cc_subviews = uis;
        ws.cc_subviewModes = uims;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 模拟更新UI 仅仅展示出 bind 为奇数的 views
        NSMutableArray *newTmp = [NSMutableArray array];
        for (CCUIContainerUiMode *object in ws.cc_subviewModes) {
            if ([object.bind integerValue] % 2 !=0) {
                [newTmp addObject:object];
            }
        }
        
        [self updateUIControls:[NSMutableArray arrayWithArray:newTmp] animation:YES];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 模拟更新UI 仅仅展示出 bind 为偶数的 views
            NSMutableArray *newTmp = [NSMutableArray array];
            for (CCUIContainerUiMode *object in ws.cc_subviewModes) {
                if ([object.bind integerValue] % 2 ==0) {
                    [newTmp addObject:object];
                }
            }
            [self updateUIControls:[NSMutableArray arrayWithArray:newTmp] animation:YES];
        });
        
    });
    
    
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end

