//
//  CCUILayoutBaseVC.m
//  CCUILayout
//
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutBaseVC.h"

@interface CCUILayoutBaseVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

/** 布局原型  列表 */
@property(nonatomic,strong)NSMutableArray<CCUILayoutMode*> *dbMode;
/** 处理后的展示的 view  列表 */
@property(nonatomic,strong)NSMutableArray<UIResponder*> *dataSourceUi;
/** 注册防止重用的 reuseIdentifier  列表 */
@property(nonatomic,strong)NSMutableArray<NSString*> *reuseIdentifiers;

/** 是否开启调试分区开关 */
@property(nonatomic,assign) BOOL isDebugShowSection;
/** 初始化 subviews 完成后进行数据回调 */
@property(nonatomic,copy) void (^uisubviewsRb)(NSArray<UIResponder*>*,NSMutableArray<CCUILayoutMode*>*);

@end

@implementation CCUILayoutBaseVC

- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

- (void) setUpdateTab
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

/** @open   是否从 _debug 的文件中加载配置
    @edges  mainTab 的四个边距
    MARK:  需要在子类的 init 方法中调用 */
- (void) configUIControlsIsLoadDebug:(BOOL)open mainTabEdges:(UIEdgeInsets)edges;
{
    [self setUpdateTab];
    [self update_TabEdges:edges];
    
    Class c = [self class];
    NSString *cName = NSStringFromClass(c);
    NSString *fileName = open ? [cName stringByAppendingFormat:@"_debug"] : cName;
    
    [self configUIControlsWithFilename:fileName];
}

// MARK: 更新 mainTab 布局
- (void)update_TabEdges:(UIEdgeInsets)edges
{
    CGFloat top = edges.top;
    CGFloat left = edges.left;
    CGFloat bottom = edges.bottom;
    CGFloat right = edges.right;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
        make.left.mas_equalTo(left);
        make.bottom.mas_equalTo(bottom);
        make.right.mas_equalTo(right);
    }];
}

/** 配置页面自动布局的 view */
- (void) configUIControlsWithFilename:(NSString*)plist
{
    
    if (![plist containsString:@".plist"]) {
        if (plist.length > 0 ) {
            plist = [plist stringByAppendingString:@".plist"];
        }else{
            return;
        }
    }
    
    NSMutableArray *queryData = [CCUILayoutMode mj_objectArrayWithFilename:plist];
    self.dbMode = [NSMutableArray arrayWithArray:queryData];
    
    [self registerClass];
    
    // 创建 view
    self.dataSourceUi = [NSMutableArray array];
    for (NSInteger i = 0; i < queryData.count; i++) {

        NSString *className = self.dbMode[i].name;
        
        if ([self classifiedUiControlsBy:className] == ccl_type0) {
            
            //... 复用实现 ...
            NSString *rucMask = self.reuseIdentifiers[i];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
            
            CCUILayoutBaseCell *cell = [self.tableView dequeueReusableCellWithIdentifier:rucMask forIndexPath:indexPath];
            cell.tag = (100 + i);
            cell.CLM = queryData[i];
            [self.dataSourceUi addObject:cell];
            
        }else if([self classifiedUiControlsBy:className] == ccl_type1){
            
            CCUILayoutBaseView * tmp= [NSClassFromString(className) new];
            tmp.tag = (100 + i);
            tmp.CLM = queryData[i];
            [self.dataSourceUi addObject:tmp];
            
        }else {
            
            // 无效资源创建空白 view 展示
            CCUILayoutBaseView * tmp= [CCUILayoutBaseView new];
            tmp.tag = (100 + i);
            tmp.CLM = queryData[i];
            // 将无效的类名重置为父类名
            tmp.CLM.name = @"CCUILayoutBaseView";
            [self.dataSourceUi addObject:tmp];
        }
        // 回调view实例对象
        if ((i + 1) == queryData.count) {
            !self.uisubviewsRb ? : self.uisubviewsRb([NSArray arrayWithArray:self.dataSourceUi],self.dbMode);
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isDebugShowSection = NO;
    [self.tableView reloadData];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

// MARK: ———————————— 👇 防止重用处理  ————————————

// 注册重用标识
-(void)registerClass
{
    self.reuseIdentifiers = [NSMutableArray array];
    for (int i = 0; i < self.dbMode.count; i++) {
        NSString *cellMask = [self registerClassWith:self.dbMode[i] by:i];
        [self.reuseIdentifiers addObject:cellMask];
    }
}

// 防止发生错误的重用
-(NSString*)registerClassWith:(CCUILayoutMode *)obj by:(NSInteger) section
{
    BOOL isCustomerCell = ([self classifiedUiControlsBy:obj.name] == ccl_type0) ? YES : NO;
    Class CELL = isCustomerCell ? [NSClassFromString(obj.name) class] : [CCUILayoutBaseCell class];
    
    NSString *cellMask = [obj.name stringByAppendingFormat:@"_%ld",section];
    [self.tableView registerClass:CELL forCellReuseIdentifier:cellMask];
    
    return cellMask;
}

// MARK: ———————————— 👆 防止重用处理  ————————————


- (CCUILayout_MaskType) classifiedUiControlsBy:(NSString *) className
{
    if ([NSClassFromString(className) isSubclassOfClass:[CCUILayoutBaseCell class]] ||
        [NSClassFromString(className) isSubclassOfClass:[UITableViewCell class]]) {
        
        return ccl_type0;
        
    }else if([NSClassFromString(className) isSubclassOfClass:[CCUILayoutBaseView class]] ||
             [NSClassFromString(className) isSubclassOfClass:[UIView class]]){
        
        return ccl_type1;
        
    }else {
        
        return ccl_type2;
    }
}

// MARK: ———————————— 👇 tableView 代理方法  ————————————

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dbMode.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /** FIXME: 这里也可以使用 configUIControlsWithFilename 中创建好的cell  直接使用 uidb[indexPath.section] ,因为复用，这里性能差不多 */
    
    NSString *className = self.dbMode[indexPath.section].name;
    
    NSString *reuserIdentifier = self.reuseIdentifiers[indexPath.section];
    
    CCUILayoutBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier forIndexPath:indexPath];

    // 防止多次添加的标记 tag
    NSInteger tag = (100+indexPath.section);
    
    if ([self classifiedUiControlsBy:className] == ccl_type0) {
    
        return cell;
        
    }else if([self classifiedUiControlsBy:className] == ccl_type1){
        
        //... 创建一个 VIEW 放到 CELL 上 ...
        //... 防止多次添加
        if (![cell viewWithTag:tag]) {
            CCUILayoutBaseView * tmp= (CCUILayoutBaseView*)self.dataSourceUi[indexPath.section];
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
            CCUILayoutBaseView * tmp= [CCUILayoutBaseView new];
            tmp.tag = tag;
            [cell addSubview:tmp];
            [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(0);
            }];
        }
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.dbMode[indexPath.section].height;
}

/*  MARK: 👇 方便调试的展示方法*/
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
 {
     return _isDebugShowSection ? 60 : 0.001;
 }
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
     UILabel *bg = [UILabel new];
     bg.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, (_isDebugShowSection ? 60 : 0.001));
     bg.alpha = _isDebugShowSection ? 1 : 0;
     if (_isDebugShowSection) {
         bg.text = [NSString stringWithFormat:@"👇%ld -> %@",section, self.dbMode[section].name];
         bg.textColor = CCUILayout_WHITE;
         bg.numberOfLines = 0;
         bg.backgroundColor = CCUILayout_BLACK;
     }
     return bg;
 }

// MARK: ———————————— 👆 tableView 代理方法  ————————————

/** MARK: 返回所有的布局 view 类实例*/
- (void) wholeUIControls:(void(^)(NSArray<UIResponder*>*,NSMutableArray<CCUILayoutMode*>*))subviews
{
    self.uisubviewsRb = ^(NSArray<UIResponder *> *uis, NSMutableArray<CCUILayoutMode *> *uims) {
        !subviews ? : subviews(uis,uims);
    };
}

/** MARK: 页面数据有所变动，及时更新高度布局 */
- (void) updateUIControlHeights:(NSMutableArray<CCUILayoutMode*> *)dataSourceMode
{
    self.dbMode = [NSMutableArray arrayWithArray:dataSourceMode];
    [self.tableView reloadData];
}


// MARK: ———————————— 👇 非主要功能方法  ————————————

/** MARK: 是否开启 分区布局调试 设置<默认关闭> */
- (void) setDebugShowSection:(BOOL)isOpen
{
    _isDebugShowSection = isOpen;
    [self.tableView reloadData];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

// MARK: ———————————— 👆 非主要功能方法  ————————————

@end
