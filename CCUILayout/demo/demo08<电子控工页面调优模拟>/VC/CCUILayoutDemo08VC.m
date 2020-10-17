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
@property(nonatomic,strong) WDZWDZElectrContrDetailMain *mainView;
@end

@implementation CCUILayoutDemo08VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view1 = [UIView new];
    view1.backgroundColor = UIColor.redColor;
    view1.frame = CGRectMake(0, 64, UIScreen.mainScreen.bounds.size.width, 44);
    [self.view addSubview:view1];
    
    UIView * view2 = [UIView new];
    view2.frame = CGRectMake(0, 64+44, UIScreen.mainScreen.bounds.size.width, 200);
    view2.backgroundColor = UIColor.greenColor;
    [self.view addSubview:view2];
    
    UILabel * lab1 = [UILabel new];
    lab1.text = @"工位刷新区";
    lab1.font = [UIFont systemFontOfSize:20];
    lab1.frame = CGRectMake(10, 10, 200, 30);
    [view1 addSubview:lab1];
    
    
    UILabel * lab2 = [UILabel new];
    lab2.text = @"工位视频播放器";
    lab2.font = [UIFont systemFontOfSize:20];
    lab2.frame = CGRectMake(10, 10, 200, 30);
    [view2 addSubview:lab2];
    
    
    self.mainView = [WDZWDZElectrContrDetailMain new];
    self.mainView.frame = CGRectMake(0, 64+44+200, UIScreen.mainScreen.bounds.size.width,
                            UIScreen.mainScreen.bounds.size.height - 64-44-200);
    self.mainView.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.mainView];
    
}


@end
