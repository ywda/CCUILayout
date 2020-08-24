//
//  ViewController.m
//  CCUILayout
//
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "ViewController.h"
#import "FuncVC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
