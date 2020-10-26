//
//  CCUIContainerDemo05VC.m
//  CCUIContainer
//
//  Created by Admin on 2020/5/18.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerDemo05VC.h"
#import "Demo05View.h"

@interface CCUIContainerDemo05VC ()

@end

@implementation CCUIContainerDemo05VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CCUIContainer_RANDOM_COLOR;
    
    Demo05View *demo = [[Demo05View alloc] initWithFrame:CGRectMake(0,
                                                                    150,
                                                                    self.view.frame.size.width,
                                                                    self.view.frame.size.height - 150)];
    
    demo.backgroundColor = CCUIContainer_RANDOM_COLOR_LIGHT;
    [self.view addSubview:demo];
}


@end
