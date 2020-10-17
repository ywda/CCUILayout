//
//  ViewController.m
//  CCUILayout
//
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "ViewController.h"
#import "FuncVC.h"
#import "CCUIShowFPS.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addShowFloatViewFPS];
}

// MARK: 添加实时 FPS 监测工具
- (void) addShowFloatViewFPS {
    
    CGRect frame = CGRectMake(0, 300, 80, 30);
    UIColor *btnBGColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    CCUIShowFPS *btn = [CCUIShowFPS setTouchWithFrame:frame
                                            titleFont:[UIFont systemFontOfSize:15]
                                      backgroundColor:btnBGColor
                                      backgroundImage:nil];
    
    [[UIApplication sharedApplication].keyWindow addSubview:btn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    FuncVC *vc = [FuncVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
