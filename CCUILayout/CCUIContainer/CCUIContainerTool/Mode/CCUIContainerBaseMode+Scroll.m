
//
//  CCUIContainerBaseMode+Scroll.m
//  CCUIContainer
//
//  Created by Admin on 2020/10/24.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerBaseMode+Scroll.h"
#import "CCUIContainerCell.h"
#import "CCUIContainerView.h"
#import "CCUIContainerSegLineView.h"
#import "CCUIContainerDebugView.h"
#import <objc/runtime.h>

//const void *CCUILBM_Scroll_containerHeight_KEY = &CCUILBM_Scroll_containerHeight_KEY;

@implementation CCUIContainerBaseMode (Scroll)

//- (CGFloat)scrollContainerHeight {
//
//    return [objc_getAssociatedObject(self, CCUILBM_Scroll_containerHeight_KEY) floatValue];
//}
//
//- (void)setScrollContainerHeight:(CGFloat)scrollContainerHeight{
//
//    objc_setAssociatedObject(self, CCUILBM_Scroll_containerHeight_KEY, @(scrollContainerHeight), OBJC_ASSOCIATION_ASSIGN);
//}


// MARK: 创建 scrollView 的页面元素
- (NSMutableArray<UIResponder *> *) create_SubViewsForScrollView:(UIScrollView*)scrollView {
    
    [self getElementNotesUimsFromSelf];
     
    // 创建 view
    self.dbUi = [NSMutableArray array];
    for (NSInteger i = 0; i < self.dbMode.count; i++) {

        // 非日志部分
        NSString *className = self.dbMode[i].name;

        if ([self classifiedUiControlsBy:className] == CCUIContainerElementTypeCell) {

            CCUIContainerCell *cell = [[NSClassFromString(className) class] new];
            cell.tag = (100 + i);
            cell.CLM = self.dbMode[i];
            [self.dbUi addObject:cell];
            [scrollView addSubview:cell];
            self.containerHeight += cell.CLM.height;

        }else if([self classifiedUiControlsBy:className] == CCUIContainerElementTypeView){

            CCUIContainerView * tmp= [NSClassFromString(className) new];
            tmp.tag = (100 + i);
            tmp.CLM = self.dbMode[i];
            [self.dbUi addObject:tmp];
            [scrollView addSubview:tmp];
            self.containerHeight += tmp.CLM.height;

        }else {

            // 无效资源创建空白 view 展示
            CCUIContainerView * tmp= [CCUIContainerView new];
            tmp.tag = (100 + i);
            tmp.CLM = self.dbMode[i];
            // 将无效的类名重置为父类名
            tmp.CLM.name = @"CCUIContainerView";
            [self.dbUi addObject:tmp];
            [scrollView addSubview:tmp];
            self.containerHeight += tmp.CLM.height;
        }

        // 回调view实例对象、容器总高度值
        if ((i + 1) == self.dbMode.count) {
            !self.uisubviewsRb ? : self.uisubviewsRb([NSArray arrayWithArray:self.dbUi],self.dbMode);
        }
    }
    
    return self.dbUi;
}


// MARK: 更新 scrollView 的页面元素
- (void) update_SubViewsForScrollView:(UIScrollView*)scrollView {
    
    [self getElementNotesUimsFromSelf];
    
    self.showDebugTag ? [self add_debugLogsForScrollView:scrollView] : [self del_debugLogsFromScrollView:scrollView];
    
    CGFloat tmp_H = 0.0;
    tmp_H += [self getTotalHeightsFromElementsdb];
    tmp_H += [self getTotalHeightsFromElementNotesdb];
    self.containerHeight = tmp_H;
    !self.contentSizeHeightRb? : self.contentSizeHeightRb(self.containerHeight);
}

// MARK: ·添加·全部日志
- (void) add_debugLogsForScrollView:(UIScrollView*)scrollView {
    
    if (self.dbNoteUis.count) {
        return;
    }
    
    CGFloat tmp_H = 0.0;
    tmp_H += [self getTotalHeightsFromElementsdb];
    
    for (int i = 0; ((i < self.dbNoteUims.count) && self.showDebugTag && (self.dbNoteUis.count != self.dbMode.count)); i++) {
        
        CCUIContainerDebugView *dui = [CCUIContainerDebugView new];
        CCUIContainerDebugUiMode *duim = ((CCUIContainerDebugUiMode*)self.dbNoteUims[i]);
        dui.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, duim.height);
        [dui setWithElementInfo:self.dbNoteUims[i]];
        [self.dbNoteUis addObject:dui];
        [self addOneUiElement:dui forScrollView:scrollView];
    }
}

// MARK: ·移除·全部日志
- (void) del_debugLogsFromScrollView:(UIScrollView*)scrollView {
    
    if (!self.dbNoteUis.count) {
        return;
    }
    
    for (int i = 0; ((i < self.dbNoteUims.count) && !self.showDebugTag && self.dbNoteUis.count); i++) {
        
        CCUIContainerDebugView *dui = (CCUIContainerDebugView*)self.dbNoteUis[i];
        
        if (dui.superview == scrollView) {
            [dui removeFromSuperview];
            
        }
    }
}


// MARK: 开始为 scrollerView  添加一个 UIElement
- (void) addOneUiElement:(UIResponder*)uiElement forScrollView:(UIScrollView*)scrollView {
    
    
    if ([uiElement isKindOfClass:[CCUIContainerCell class]]) {
        [scrollView addSubview:((CCUIContainerCell*)uiElement)];
    }
    
    if ([uiElement isKindOfClass:[CCUIContainerView class]]) {
        [scrollView addSubview:((CCUIContainerView*)uiElement)];
    }
    
    if ([uiElement isKindOfClass:[CCUIContainerSegLineView class]]) {
        [scrollView addSubview:((CCUIContainerSegLineView*)uiElement)];
    }
    
    if ([uiElement isKindOfClass:[CCUIContainerDebugView class]]) {
        [scrollView addSubview:((CCUIContainerDebugView*)uiElement)];
    }
}

// MARK: 更新 scrollView 的页面元素 布局
- (void) layout_SubViewsForScrollView:(UIScrollView*)scrollView {
    
    if (!self.dbUi.count) {
        return;
    }
    scrollView.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, self.containerHeight);
    
    // 统一重载为 UIView 实例, 便于布局...
    NSMutableArray<UIView*> *uis = [NSMutableArray array];
    NSMutableArray<NSNumber*> *uiHs = [NSMutableArray array];
    
    for (int i = 0; i < self.dbUi.count; i++) {
        
        // 先加日志
        if (self.showDebugTag && self.dbNoteUis.count && (self.dbNoteUis.count == self.dbUi.count)) {
            [uis addObject:(UIView*)self.dbNoteUis[i]];
            [uiHs addObject:[NSNumber numberWithFloat:self.dbNoteUims[i].height]];
        }
        
        // 非日志部分
        [uis addObject:(UIView*)self.dbUi[i]];
        [uiHs addObject:[NSNumber numberWithFloat:self.dbMode[i].height]];
        ((UIView*)self.dbUi[i]).alpha = (((CCUIContainerUiMode*)self.dbMode[i]).height <= 0)?0:1;
    }
    
    // 显示日志
    for (int i = 0; i < uis.count; i++) {
        
        if (i == 0) {
            
            UIView *uiElement = uis[i];
            NSNumber *uiH = uiHs[i];
            
            [uiElement mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
                make.height.mas_equalTo(uiH.floatValue);
            }];
            
        }else if ( i > 0 ){
            
            UIView *uiElementPer = uis[i-1];
            UIView *uiElement = uis[i];
            NSNumber *uiH = uiHs[i];
            
            [uiElement mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(uiElementPer.mas_bottom);
                make.height.mas_equalTo(uiH.floatValue);
                make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
                make.left.right.mas_equalTo(0);
            }];
        }
    }
}

@end
