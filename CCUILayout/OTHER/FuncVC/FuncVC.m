//
//  FuncVC.m
//  CCUILayout
//
//  Created by Admin on 2020/5/15.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "FuncVC.h"
#import "FuncCELL.h"

#import "CCUILayoutDemo01VC.h"
#import "CCUILayoutDemo02VC.h"
#import "CCUILayoutDemo03VC.h"
#import "CCUILayoutDemo04VC.h"
#import "CCUILayoutDemo05VC.h"
#import "CCUILayoutDemo06VC.h"
#import "CCUILayoutDemo07VC.h"
#import "CCUILayoutDemo08VC.h"

@interface FuncVC ()

@end

@implementation FuncVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self configUIControlsIsLoadDebug:NO mainTabEdges:UIEdgeInsetsZero adapterApp:NO];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDebugShowSection:YES];
    /** MARK: 返回所有的布局 view 类实例 <方便使用场景VC中操作>*/
    [self wholeUIControls:^(NSArray<UIResponder *> * subviews, NSMutableArray<CCUILayoutUiMode *> * cc_subviewModes) {
        NSLog(@"uis = %@ -- 子视图的个数 %ld",subviews,subviews.count);
        for (int i = 0 ; i < subviews.count; i++) {
            
            NSString *name = cc_subviewModes[i].name;
            NSString *desc = cc_subviewModes[i].desc;
            NSString *text = [NSString stringWithFormat:@"元素类名：%@ \n%@",name,desc];
            
            ((FuncCELL*)subviews[i]).textLabel.text = text;
            ((FuncCELL*)subviews[i]).textLabel.numberOfLines = 0;
        }
    }];
    
    // 点击事件
    [self getUIControlsTouchIndex:^(UIResponder * ui, CCUILayoutUiMode * uim, NSInteger index) {
        switch (index) {
            case 0:
                {
                    [self createdemo001];
                }
                break;
            case 1:
                {
                    [self createdemo002];
                }
                break;
            case 2:
                {
                    [self createdemo003];
                }
                break;
            case 3:
                {
                    [self createdemo004];
                }
                break;
            case 4:
                {
                    [self createdemo005];
                }
                break;
            case 5:
                {
                    [self createdemo006];
                }
                break;
            case 6:
                {
                    [self createdemo007];
                }
                break;
            case 7:
                {
                    [self createdemo008];
                }
                break;
            default:
                break;
        }
    }];
    
    [self setDebugShowSection:NO];
}


// MARK: 描述： CCUILayoutBaseTabVC + plist 创建
- (void) createdemo001{
    CCUILayoutDemo01VC *vc = [CCUILayoutDemo01VC new];
    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: 描述： CCUILayoutBaseVC + plist 创建
- (void) createdemo002{
    CCUILayoutDemo02VC *vc = [CCUILayoutDemo02VC new];
    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: 描述： CCUILayoutBaseTabVC + 实例数组 创建
- (void) createdemo003{
    CCUILayoutDemo03VC *vc = [CCUILayoutDemo03VC new];
    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: 描述： CCUILayoutBaseVC + 实例数组 创建
- (void) createdemo004{
    CCUILayoutDemo04VC *vc = [CCUILayoutDemo04VC new];
    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: 描述： CCUILayoutBaseView + plist 创建
- (void) createdemo005{
    CCUILayoutDemo05VC *vc = [CCUILayoutDemo05VC new];
    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: 描述： CCUILayoutBaseView + 实例数组 创建
- (void) createdemo006{
    CCUILayoutDemo06VC *vc = [CCUILayoutDemo06VC new];
    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: 描述：一个没有写好的案例
- (void) createdemo007{
    CCUILayoutDemo07VC *vc = [CCUILayoutDemo07VC new];
    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: 描述：电子控工页面调优模拟
- (void) createdemo008{
    CCUILayoutDemo08VC *vc = [CCUILayoutDemo08VC new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
