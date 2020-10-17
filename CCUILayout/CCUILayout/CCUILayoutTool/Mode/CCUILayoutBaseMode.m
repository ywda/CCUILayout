//
//  CCUILayoutBaseMode.m
//  CCUILayout
//  MARK: 某个 BaseVC BaseTabVC 页面、BaseView 控制的的 UiMode
//  Created by Admin on 2020/5/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutBaseMode.h"
#import "CCUILayoutDebugView.h"

@implementation CCUILayoutBaseMode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dbMode = [NSMutableArray array];
        self.dbUi = [NSMutableArray array];
        self.reuseIdentifiers = [NSMutableArray array];
        self.dbElementNotes = [NSMutableArray array];
        self.showDebugTag = NO; 
    }
    return self;
}

// MARK: 创建 TableView 的页面元素
- (void) create_SubViewsFor:(UITableView*)tableView
{
   // 创建 view
   self.dbUi = [NSMutableArray array];
   for (NSInteger i = 0; i < self.dbMode.count; i++) {

       NSString *className = self.dbMode[i].name;
       
       if ([self classifiedUiControlsBy:className] == CCUILayoutMaskType0) {
           
           //... 复用实现 ...
           NSString *rucMask = self.reuseIdentifiers[i];
           NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
           
           // FIXME: forIndexPath 易引起<在实例初始化页面的时候>崩溃，需要注意下
           CCUILayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:rucMask forIndexPath:indexPath];
           cell.tag = (100 + i);
           cell.CLM = self.dbMode[i];
           [self.dbUi addObject:cell];
           
       }else if([self classifiedUiControlsBy:className] == CCUILayoutMaskType1){
           
           CCUILayoutView * tmp= [NSClassFromString(className) new];
           tmp.tag = (100 + i);
           tmp.CLM = self.dbMode[i];
           [self.dbUi addObject:tmp];
           
       }else {
           
           // 无效资源创建空白 view 展示
           CCUILayoutView * tmp= [CCUILayoutView new];
           tmp.tag = (100 + i);
           tmp.CLM = self.dbMode[i];
           // 将无效的类名重置为父类名
           tmp.CLM.name = @"CCUILayoutView";
           [self.dbUi addObject:tmp];
       }
       // 回调view实例对象
       if ((i + 1) == self.dbMode.count) {
           !self.uisubviewsRb ? : self.uisubviewsRb([NSArray arrayWithArray:self.dbUi],self.dbMode);
       }
   }
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
-(NSString*)registerClassWith:(CCUILayoutUiMode *)obj by:(NSInteger) section view:(UITableView*)tableView
{
    BOOL isCustomerCell = ([self classifiedUiControlsBy:obj.name] == CCUILayoutMaskType0) ? YES : NO;
    Class CELL = isCustomerCell ? [NSClassFromString(obj.name) class] : [CCUILayoutCell class];
    
    NSString *cellMask = [obj.name stringByAppendingFormat:@"_%ld",section];
    [tableView registerClass:CELL forCellReuseIdentifier:cellMask];
    
    return cellMask;
}

- (CCUILayout_MaskType) classifiedUiControlsBy:(NSString *) className
{
    if ([NSClassFromString(className) isSubclassOfClass:[CCUILayoutCell class]] ||
        [NSClassFromString(className) isSubclassOfClass:[UITableViewCell class]]) {
        
        return CCUILayoutMaskType0;
        
    }else if([NSClassFromString(className) isSubclassOfClass:[CCUILayoutView class]] ||
             [NSClassFromString(className) isSubclassOfClass:[UIView class]]){
        
        return CCUILayoutMaskType1;
        
    }else {
        
        return CCUILayoutMaskType2;
    }
}

// MARK: cellForRowAtIndexPath 方法内部的逻辑转移
- (UITableViewCell *)getTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** FIXME: 这里也可以使用 configUIControlsWithFilename 中创建好的cell  直接使用 uidb[indexPath.section] ,因为复用，这里性能差不多 */
    
    NSString *className = self.dbMode[indexPath.section].name;
    
    NSString *reuserIdentifier = self.reuseIdentifiers[indexPath.section];
    
    CCUILayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier forIndexPath:indexPath];

    // 防止多次添加的标记 tag
    NSInteger tag = (100+indexPath.section);
    
    if ([self classifiedUiControlsBy:className] == CCUILayoutMaskType0) {
    
        return cell;
        
    }else if([self classifiedUiControlsBy:className] == CCUILayoutMaskType1){
        
        //... 创建一个 VIEW 放到 CELL 上 ...
        //... 防止多次添加
        if (![cell viewWithTag:tag]) {
            CCUILayoutView * tmp= (CCUILayoutView*)self.dbUi[indexPath.section];
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
            CCUILayoutView * tmp= [CCUILayoutView new];
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
    [tableView registerClass:[CCUILayoutDebugView class] forHeaderFooterViewReuseIdentifier:@"CCUILayoutDebugView"];
}

@end
