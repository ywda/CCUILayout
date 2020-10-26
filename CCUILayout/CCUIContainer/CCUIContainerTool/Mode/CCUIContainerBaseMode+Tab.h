//
//  CCUIContainerBaseMode+Tab.h
//  CCUIContainer
//
//  Created by Admin on 2020/10/24.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerBaseMode.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCUIContainerBaseMode (Tab)

//@property(nonatomic,assign) CGFloat tabContainerHeight;

@property(nonatomic,strong)NSMutableArray<NSString*> *reuseIdentifiers;

// MARK: 创建 TableView 的页面元素
- (void) create_SubViewsForTab:(UITableView*)tableView;

// MARK: 获取 TableView 的页面元素总容量的实时高度
- (void) get_SubViewsForTab:(UITableView*)tableView contentSizeHeightRb:(void(^)(CGFloat)) totalHeightRb;

// MARK: 更新 TableView 的页面元素
- (void) update_SubViewsForTab:(UITableView*)tableView;

// MARK: 注册 CELL 重用标识
- (void) register_Cell_ReuseIdentifierFor:(UITableView*)tableView;

// MARK: 注册 TabHeader 重用标识
- (void) register_TabHeader_ReuseIdentifierFor:(UITableView*)tableView;

// MARK: cellForRowAtIndexPath 方法内部的逻辑转移
- (UITableViewCell *)getTableView:(UITableView *)tableView
            cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
