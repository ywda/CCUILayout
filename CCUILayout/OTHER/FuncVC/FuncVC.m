//
//  FuncVC.m
//  CCUIContainer
//
//  Created by Admin on 2020/5/15.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "FuncVC.h"
#import "FuncCELL.h"

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
    [self wholeUIControls:^(NSArray<UIResponder *> * subviews, NSMutableArray<CCUIContainerUiMode *> * cc_subviewModes) {
        NSLog(@"uis = %@ -- 子视图的个数 %ld",subviews,subviews.count);
        for (int i = 0 ; i < subviews.count; i++) {
            
            NSString *name = cc_subviewModes[i].name;
            NSString *desc = cc_subviewModes[i].desc;
            NSString *text = [NSString stringWithFormat:@"元素类名：%@ \n%@",name,desc];
            
            ((FuncCELL*)subviews[i]).textLabel.text = text;
            ((FuncCELL*)subviews[i]).textLabel.numberOfLines = 0;
        }
    }];
    
    NSArray *pageClass = @[@"CCUIContainerDemo01VC",
                           @"CCUIContainerDemo02VC",
                           @"CCUIContainerDemo03VC",
                           @"CCUIContainerDemo04VC",
                           @"CCUIContainerDemo05VC",
                           @"CCUIContainerDemo06VC",
                           @"CCUIContainerDemo07VC",
                           @"CCUIContainerDemo08VC",
                           @"CCUIContainerDemo09VC",];
    
    // 点击事件
    [self getUIControlsTouchIndex:^(UIResponder * ui, CCUIContainerUiMode * uim, NSInteger index) {
        
        
        if (self.cc_subviewModes.count < (1+index)) {
            NSInteger bind = uim.bind.intValue;
            if (pageClass.count >= bind) {
                [self.navigationController pushViewController:[[NSClassFromString(pageClass[bind-1]) class] new] animated:YES];
            }
            return;
        }
        
        [self.navigationController pushViewController:[[NSClassFromString(pageClass[index]) class] new] animated:YES];
    }];
    
    [self setDebugShowSection:NO];
}




@end
