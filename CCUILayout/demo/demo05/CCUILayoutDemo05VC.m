//
//  CCUILayoutDemo05VC.m
//  CCUILayout
//
//  Created by Admin on 2020/5/18.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutDemo05VC.h"
#import "Demo05View.h"

@interface CCUILayoutDemo05VC ()

@end

@implementation CCUILayoutDemo05VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CCUILayout_RANDOM_COLOR;
    
    Demo05View *demo = [[Demo05View alloc] initWithFrame:CGRectMake(0,
                                                                    150,
                                                                    self.view.frame.size.width,
                                                                    self.view.frame.size.height - 150)];
    
    demo.backgroundColor = CCUILayout_RANDOM_COLOR_LIGHT;
    [self.view addSubview:demo];
}


@end
