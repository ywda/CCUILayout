//
//  CCUIContainerDemo06VC.m
//  CCUIContainer
//
//  Created by Admin on 2020/5/18.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerDemo06VC.h"
#import "Demo06View.h"

@interface CCUIContainerDemo06VC ()

@end

@implementation CCUIContainerDemo06VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CCUIContainer_RANDOM_COLOR;
    
    Demo06View *demo = [Demo06View new];
    demo.backgroundColor = CCUIContainer_RANDOM_COLOR_LIGHT;
    [self.view addSubview:demo];
    
    [demo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-100);
    }];
    
//    demo.frame = CGRectMake(15, 200, self.view.frame.size.width - 30, self.view.frame.size.height - 400);
}


@end

