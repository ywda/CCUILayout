//
//  CCUIContainerBaseMode.m
//  CCUIContainer
//  MARK: 某个 BaseVC BaseTabVC 页面、BaseView 控制的的 UiMode
//  Created by Admin on 2020/5/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerBaseMode.h"
#import "CCUIContainerView.h"
#import "CCUIContainerCell.h"
#import "CCUIContainerSegLineView.h"
#import <Masonry/Masonry.h>


@implementation CCUIContainerBaseMode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.containerHeight = 0;
        self.dbMode = [NSMutableArray array];
        self.dbUi = [NSMutableArray array];
        self.dbNoteUis = [NSMutableArray array];
        self.dbNoteUims = [NSMutableArray array];
        self.showDebugTag = NO; 
    }
    return self;
}

- (NSMutableArray<CCUIContainerUiMode *> *)dbMode {
    if (!_dbMode) {
        _dbMode = [NSMutableArray array];
    }
    return _dbMode;
}

- (NSMutableArray<UIResponder *> *)dbUi {
    if (!_dbUi) {
        _dbUi = [NSMutableArray array];
    }
    return _dbUi;
}

- (NSMutableArray<CCUIContainerDebugView *> *)dbNoteUis{
    if (!_dbNoteUis) {
        _dbNoteUis = [NSMutableArray array];
    }
    return _dbNoteUis;
}

- (NSMutableArray<CCUIContainerDebugUiMode *> *)dbNoteUims {
    if (!_dbNoteUims) {
        _dbNoteUims = [NSMutableArray array];
    }
    return _dbNoteUims;
}


// ——————————————————————————————————————————————————
// MARK: 👇👉 容器的 公用方法
// ——————————————————————————————————————————————————

// MARK: 获取 Element 元素类型
- (CCUIContainerElementType) classifiedUiControlsBy:(NSString *) className
{
    if ([NSClassFromString(className) isSubclassOfClass:[CCUIContainerCell class]] ||
        [NSClassFromString(className) isSubclassOfClass:[UITableViewCell class]]) {
        
        return CCUIContainerElementTypeCell;
        
    }else if([NSClassFromString(className) isSubclassOfClass:[CCUIContainerView class]]){
        
        return CCUIContainerElementTypeView;
        
    }else if([NSClassFromString(className) isSubclassOfClass:[CCUIContainerDebugView class]]){
        
        return CCUIContainerElementTypeDebugView;
        
    }else {
        
        return CCUIContainerElementTypeUnKonw;
    }
}

// MARK: 获取 所有·非日志·部分的总体高度
- (CGFloat) getTotalHeightsFromElementsdb {
    
    CGFloat height = 0.0;
    if ( self.dbMode && self.dbMode.count) {
        for (CCUIContainerUiMode *object in self.dbMode ) {
            height += object.height;
        }
    }
    return height;
}

// MARK: 获取 所有·日志·部分的总体高度
- (CGFloat) getTotalHeightsFromElementNotesdb {
    
    CGFloat height = 0.0;
    if (self.dbNoteUims && self.dbNoteUims.count && self.showDebugTag) {
        for (CCUIContainerDebugUiMode *object in self.dbNoteUims) {
            height += object.height;
        }
    }
    return height;
}

// MARK: 回调·容器总体·含有日志的总体高度值
- (void) rbContainerHeightFor:(void(^)(CGFloat)) totalHeightRb {
    
    self.contentSizeHeightRb = ^(CGFloat totalHeight) {
        !totalHeightRb? : totalHeightRb(totalHeight);
    };
}

// MARK: 更新与改变日志部分的 ui\uim 数据源
- (void)setShowDebugTag:(BOOL)showDebugTag {
    
    _showDebugTag = showDebugTag;
    [self getElementNotesUimsFromSelf];
}

// MARK: 获取日志部分的 uim 数据源
- (void) getElementNotesUimsFromSelf {
    
    if (self.dbMode && self.dbMode.count) {
        // 有效的高度非0元素个数与日志个数不相等的时候,也要更新...意义不大，这里就没有做这层更新的逻辑处理...
        // 下面仅简单的设置了日志条数...
        if (!self.dbNoteUims.count) {
            self.dbNoteUims = [CCUIContainerDebugUiMode getCalculateNotesModesFrom:self.dbMode];
        }
    }
}


@end
