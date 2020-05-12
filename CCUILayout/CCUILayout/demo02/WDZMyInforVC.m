//
//  WDZMyInforVC.m
//  CCUILayout
//
//  Created by Admin on 2020/4/30.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "WDZMyInforVC.h"
#import "CCUILayout_Func.h"
#import <MJRefresh/MJRefresh.h>

#import "WDZMyInfoSegLine.h"
#import "WDZMyInfoItem00.h"
#import "WDZMyInfoItem01.h"

@interface WDZMyInforVC ()

@end

@implementation WDZMyInforVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        //{top, left, bottom, right};
        UIEdgeInsets insets = UIEdgeInsetsMake(180, 0, 0, -0);
        [self configUIControlsIsLoadDebug:NO mainTabEdges:insets];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *top = [UIView new];
    top.backgroundColor = UIColor.redColor;
    [self.view addSubview:top];
    
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(180);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    // 模拟 wdz 项目中的一个导航条
    [self.view bringSubviewToFront:top];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    
    /** MARK: 返回所有的布局 view 类实例 <方便使用场景VC中操作>*/
    __weak typeof(self) weakSelf = self;
    
    [self wholeUIControls:^(NSArray<UIResponder *> * subviews, NSMutableArray<CCUILayoutMode *> * subviewModes) {
        NSLog(@"uis = %@ -- 子视图的个数 %ld",subviews,subviews.count);
        weakSelf.subviews = subviews;
        weakSelf.dataSourceMode = [NSMutableArray arrayWithArray:subviewModes];
        
        // 更新与设置值
        for (int i = 0; i < subviews.count; i++) {
            
            UIResponder *rp = subviews[i];
            
            if ([rp isKindOfClass:[WDZMyInfoSegLine class]]) {
                
                [weakSelf actionReuseUiControl_For_WDZMyInfoSegLine:(WDZMyInfoSegLine*)rp];
            }
            if ([rp isKindOfClass:[WDZMyInfoItem00 class]]) {
                
                [weakSelf actionReuseUiControl_For_WDZMyInfoItem00:(WDZMyInfoItem00*)rp];
            }
            if ([rp isKindOfClass:[WDZMyInfoItem01 class]]) {
                
                [weakSelf actionReuseUiControl_For_WDZMyInfoItem01:(WDZMyInfoItem01*)rp];
            }
        }
    }];
    
    // MARK: 模拟 5秒后，更新页面布局 <主要是分区的高度>
    /* */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 模拟改变 subview 的高度
        for (int i = 0; i < weakSelf.dataSourceMode.count; i++) {
            self.dataSourceMode[i].height += (i==0) ? 100 : 0;
        }
        
        [self updateUIControlHeights:self.dataSourceMode];
    });
    
    [self setDebugShowSection:NO];
}

// MARK: 复用于 `WDZMyInfoSegLine` 类的子UI控件
- (void) actionReuseUiControl_For_WDZMyInfoSegLine: (WDZMyInfoSegLine*)rp
{
    switch ([rp.CLM.bind intValue]) {
        case -1:
            {
                rp.backgroundColor = CCUILayout_RED;
                
            }
            break;
        case -2:
            {
                rp.backgroundColor = CCUILayout_GREEN;
            }
            break;
        case -3:
            {
                rp.backgroundColor = CCUILayout_ORANG;
            }
            break;
        case -4:
            {
                rp.backgroundColor = CCUILayout_YELLOW;
            }
            break;
        default:
        {
            rp.backgroundColor = CCUILayout_BLACK;
        }
            break;
    }
}

// MARK: 复用于 `WDZMyInfoItem00` 类的子UI控件
- (void) actionReuseUiControl_For_WDZMyInfoItem00: (WDZMyInfoItem00*)rp
{
    
    [rp setUpCellWithLab:[NSString stringWithFormat:@"%d %@",rp.CLM.bind.intValue,rp.CLM.desc]];
    
    switch ([rp.CLM.bind intValue]) {
        case 1:
            {
                rp.backgroundColor = CCUILayout_RANDOM_COLOR;
                
            }
            break;
        case 2:
            {
                rp.backgroundColor = CCUILayout_RANDOM_COLOR;
                
            }
            break;
        default:
        {
            rp.backgroundColor = CCUILayout_WHITE;
        }
            break;
    }
}

// MARK: 复用于 `WDZMyInfoItem00` 类的子UI控件
- (void) actionReuseUiControl_For_WDZMyInfoItem01: (WDZMyInfoItem01*)rp
{
    switch ([rp.CLM.bind intValue]) {
        case 3:
            {
                rp.backgroundColor = CCUILayout_RANDOM_COLOR;
            }
            break;
        case 4:
            {
                rp.backgroundColor = CCUILayout_RANDOM_COLOR;
            }
            break;
        case 5:
            {
                rp.backgroundColor = CCUILayout_RANDOM_COLOR;
            }
            break;
        case 6:
            {
                rp.backgroundColor = CCUILayout_RANDOM_COLOR;
            }
            break;
        default:
        {
            rp.backgroundColor = CCUILayout_WHITE;
        }
            break;
    }
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
