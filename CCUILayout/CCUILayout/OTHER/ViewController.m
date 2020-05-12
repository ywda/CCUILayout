//
//  ViewController.m
//  CCUILayout
//
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "ViewController.h"
#import "CCUILayoutDemoVC.h"
#import "WDZMyInforVC.h"   // 重写`我的`页面

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // demo1 实现
//    CCUILayoutDemoVC *vc = [CCUILayoutDemoVC new];
//    [self.navigationController pushViewController:vc animated:YES];
    
    // demo2 实现
    WDZMyInforVC *vc = [WDZMyInforVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
