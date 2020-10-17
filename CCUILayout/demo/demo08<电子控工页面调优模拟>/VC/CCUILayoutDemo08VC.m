//
//  CCUILayoutDemo08VC.m
//  CCUILayout
//
//  Created by Admin on 2020/10/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutDemo08VC.h"
#import "WDZWDZElectrContrDetailMain.h"

@interface CCUILayoutDemo08VC ()

@end

@implementation CCUILayoutDemo08VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view1 = [UIView new];
    [self.view addSubview:view1];
    
    UIView * view2 = [UIView new];
    [self.view addSubview:view2];

    
    UIView * mian = [UIView new];
    [self.view addSubview:mian];
    
    
    CGRect frame = CGRectMake(0,
                              100,
                              UIScreen.mainScreen.bounds.size.width,
                              UIScreen.mainScreen.bounds.size.height  - 44 - 100);
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
