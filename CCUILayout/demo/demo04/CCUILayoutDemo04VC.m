//
//  CCUILayoutDemo04VC.m
//  CCUILayout
//  MARK: 模拟从创建的实例数组快速创建 页面 demo 父类 CCUILayoutBaseTabVC
//  Created by Admin on 2020/5/15.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutDemo04VC.h"

@interface CCUILayoutDemo04VC ()

@end

@implementation CCUILayoutDemo04VC

- (instancetype)init
{
    self = [super init];
    if (self) {
        //{top, left, bottom, right};
        UIEdgeInsets insets = UIEdgeInsetsMake(100, 0, 50, 0);
        
        NSMutableArray *uis = [NSMutableArray array];
        NSMutableArray *uiMs = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            // MARK: 模拟传入实例对象值
            CCUILayoutView *tmp = [CCUILayoutView new];
            // 不能在这里 为 tmp 中添加子元素 <tmp 是独立封装好的 view 类>
            [uis addObject:tmp];
            
            CCUILayoutUiMode *cm = [CCUILayoutUiMode new];
            cm.height = 50;
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
    // MARK: 模拟当前项目中的自定义导航条部分
    // FIXME: 存在的问题，后续兼容导航条能够渐变效果不是很好，这里要将后续能够兼容的需求考虑到，尽量避免后期维护的时候出现严重的困难
    UIView *top = [UIView new];
    top.backgroundColor = UIColor.redColor;
    [self.view addSubview:top];
    top.frame = CGRectMake(0, -100, self.view.frame.size.width, 90);
    
    // 模拟 wdz 项目中的一个导航条
    [self.view bringSubviewToFront:top];
}


- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
