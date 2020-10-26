//
//  CCUIContainerBaseMode+Tab.m
//  CCUIContainer
//
//  Created by Admin on 2020/10/24.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerBaseMode+Tab.h"
#import "CCUIContainerView.h"
#import "CCUIContainerCell.h"
#import <objc/runtime.h>
//#import "CCUIContainerSegLineView.h"
//#import <Masonry/Masonry.h>


//const void *CCUILBM_Tab_containerHeight_KEY = &CCUILBM_Tab_containerHeight_KEY;
const void *CCUILBM_Tab_reuseIdentifiers_KEY = &CCUILBM_Tab_reuseIdentifiers_KEY;
//static const char * CCUILBM_Tab_reuseIdentifiers_KEY = "runtime_containerHeight_KEY";

@implementation CCUIContainerBaseMode (Tab)

//- (CGFloat)tabContainerHeight {
//
//    return [objc_getAssociatedObject(self, CCUILBM_Tab_containerHeight_KEY) floatValue];
//}
//- (void)setTabContainerHeight:(CGFloat)tabContainerHeight {
//
//    objc_setAssociatedObject(self, CCUILBM_Tab_containerHeight_KEY, @(tabContainerHeight), OBJC_ASSOCIATION_ASSIGN);
//}


- (NSMutableArray<NSString *> *)reuseIdentifiers {
    
    return objc_getAssociatedObject(self, CCUILBM_Tab_reuseIdentifiers_KEY);
}
- (void)setReuseIdentifiers:(NSMutableArray<NSString *> *)reuseIdentifiers {
    
    objc_setAssociatedObject(self, CCUILBM_Tab_reuseIdentifiers_KEY, reuseIdentifiers, OBJC_ASSOCIATION_RETAIN);
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.reuseIdentifiers = [NSMutableArray array];
    }
    return self;
}

// MARK: 创建 TableView 的页面元素
- (void) create_SubViewsForTab:(UITableView*)tableView
{
   // 创建 view
   self.dbUi = [NSMutableArray array];
   for (NSInteger i = 0; i < self.dbMode.count; i++) {

       NSString *className = self.dbMode[i].name;
       
       if ([self classifiedUiControlsBy:className] == CCUIContainerElementTypeCell) {
           
           //... 复用实现 ...
           NSString *rucMask = self.reuseIdentifiers[i];
           NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
           
           // FIXME: forIndexPath 易引起<在实例初始化页面的时候>崩溃，需要注意下
           CCUIContainerCell *cell = [tableView dequeueReusableCellWithIdentifier:rucMask forIndexPath:indexPath];
           cell.tag = (100 + i);
           cell.CLM = self.dbMode[i];
           [self.dbUi addObject:cell];
           self.containerHeight += cell.CLM.height;
           
       }else if([self classifiedUiControlsBy:className] == CCUIContainerElementTypeView){
           
           CCUIContainerView * tmp= [NSClassFromString(className) new];
           tmp.tag = (100 + i);
           tmp.CLM = self.dbMode[i];
           [self.dbUi addObject:tmp];
           self.containerHeight += tmp.CLM.height;
           
       }else {
           
           // 无效资源创建空白 view 展示
           CCUIContainerView * tmp= [CCUIContainerView new];
           tmp.tag = (100 + i);
           tmp.CLM = self.dbMode[i];
           // 将无效的类名重置为父类名
           tmp.CLM.name = @"CCUIContainerView";
           [self.dbUi addObject:tmp];
           self.containerHeight += tmp.CLM.height;
       }
       
       // 回调view实例对象、容器总高度值
       if ((i + 1) == self.dbMode.count) {
           !self.uisubviewsRb ? : self.uisubviewsRb([NSArray arrayWithArray:self.dbUi],self.dbMode);
           
           // 容器高度也要包含 ·日志部分的高度·
           self.containerHeight += [self getTotalHeightsFromElementNotesdb];
           !self.contentSizeHeightRb? : self.contentSizeHeightRb(self.containerHeight);
       }
   }
}

// MARK: 获取 TableView 的页面元素总容量的实时高度
- (void) get_SubViewsForTab:(UITableView*)tableView contentSizeHeightRb:(void(^)(CGFloat)) totalHeightRb {
    
    [self rbContainerHeightFor:totalHeightRb];
}

// MARK: 更新 TableView 的页面元素
- (void) update_SubViewsForTab:(UITableView*)tableView {
    
    CGFloat tmp_H = 0.0;
    tmp_H += [self getTotalHeightsFromElementsdb];
    tmp_H += [self getTotalHeightsFromElementNotesdb];
    self.containerHeight = tmp_H;
    !self.contentSizeHeightRb? : self.contentSizeHeightRb(self.containerHeight);
}


// MARK: 注册 CELL 重用标识
- (void) register_Cell_ReuseIdentifierFor:(UITableView*)tableView
{
    self.reuseIdentifiers = [NSMutableArray array];
    for (int i = 0; i < self.dbMode.count; i++) {
        NSString *cellMask = [self registerClassWith:self.dbMode[i] by:i view:tableView];
        [self.reuseIdentifiers addObject:cellMask];
    }
}

// 防止发生错误的重用
-(NSString*)registerClassWith:(CCUIContainerUiMode *)obj by:(NSInteger) section view:(UITableView*)tableView
{
    BOOL isCustomerCell = ([self classifiedUiControlsBy:obj.name] == CCUIContainerElementTypeCell) ? YES : NO;
    Class CELL = isCustomerCell ? [NSClassFromString(obj.name) class] : [CCUIContainerCell class];
    
    NSString *cellMask = [obj.name stringByAppendingFormat:@"_%ld",section];
    [tableView registerClass:CELL forCellReuseIdentifier:cellMask];
    
    return cellMask;
}

// MARK: cellForRowAtIndexPath 方法内部的逻辑转移
- (UITableViewCell *)getTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** FIXME: 这里也可以使用 configUIControlsWithFilename 中创建好的cell  直接使用 uidb[indexPath.section] ,因为复用，这里性能差不多 */
    
    NSString *className = self.dbMode[indexPath.section].name;
    
    NSString *reuserIdentifier = self.reuseIdentifiers[indexPath.section];
    
    CCUIContainerCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier forIndexPath:indexPath];

    // 防止多次添加的标记 tag
    NSInteger tag = (100+indexPath.section);
    
    if ([self classifiedUiControlsBy:className] == CCUIContainerElementTypeCell) {
    
        return cell;
        
    }else if([self classifiedUiControlsBy:className] == CCUIContainerElementTypeView){
        
        //... 创建一个 VIEW 放到 CELL 上 ...
        //... 防止多次添加
        if (![cell viewWithTag:tag]) {
            CCUIContainerView * tmp= (CCUIContainerView*)self.dbUi[indexPath.section];
            tmp.tag = tag;
            [cell addSubview:tmp];
            [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(0);
            }];
        }
    }else{
        
        // 这里也可以不再添加...
        /* */
        if (![cell viewWithTag:tag]) {
            CCUIContainerView * tmp= [CCUIContainerView new];
            tmp.tag = tag;
            [cell addSubview:tmp];
            [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(0);
            }];
        }
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColor.clearColor;
    cell.contentView.backgroundColor = UIColor.clearColor;
    
    // FIXME: 这么处理是外部有·隐藏-显示·某块 VIEW 元素的时候背景色导致的突兀效果处理
    // 动画的·隐藏-显示·的时候做一处突兀处理
    UIColor *color = self.dbMode[indexPath.section].bgColor;
    if (color) {
        cell.backgroundColor = color;
        cell.contentView.backgroundColor = color;
    }
    
    return cell;
}

// MARK: 注册 TabHeader 重用标识
- (void) register_TabHeader_ReuseIdentifierFor:(UITableView*)tableView
{
    [tableView registerClass:[CCUIContainerDebugView class] forHeaderFooterViewReuseIdentifier:@"CCUIContainerDebugView"];
}

@end
