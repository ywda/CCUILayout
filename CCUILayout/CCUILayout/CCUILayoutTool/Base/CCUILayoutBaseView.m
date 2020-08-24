//
//  CCUILayoutBaseView.m
//  CCUILayout
//
//  Created by Admin on 2020/5/14.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutBaseView.h"
#import "CCUILayoutBaseLogic.h"

@interface CCUILayoutBaseView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)CCUILayoutBaseMode *base;

@end

@implementation CCUILayoutBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpDataAndUi];
    }
    return self;
}

- (void) setUpDataAndUi
{
    self.base = [CCUILayoutBaseMode new];
    [self setUpdateTab];
    
    // 注册观察属性 dbMode
    [self.base addObserver:self
                   forKeyPath:@"dbMode"
                      options:NSKeyValueObservingOptionNew
                      context:NULL];
}

- (UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

- (void) setUpdateTab
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:self.tableView];
}

- (void) configUIControlsIsLoadDebug:(BOOL)isDebug mainTabEdges:(UIEdgeInsets)edges adapterApp:(BOOL)isAdapter
{
    [self update_TabEdges:edges];
    
    Class c = [self class];
    NSString *cName = NSStringFromClass(c);
    
    // 如果开启适配 App 定制化，则要创建相关的定制配置 plist 文件
    if (isAdapter) {
        cName = [CCUILayoutConfig getConfigPlistNameBy:cName];
    }
    
    NSString *fileName = isDebug ? [cName stringByAppendingFormat:@"_debug"] : cName;
    
    [self configUIControlsWithFilename:fileName];
}

- (void) configUIControls:(NSArray<UIResponder *> *)subUis
                   layout:(NSArray<CCUILayoutUiMode*> *)subLModes
             mainTabEdges:(UIEdgeInsets)edges
{
    [self update_TabEdges:edges];
    
    CCUILayoutBaseLogic *checkLg = [CCUILayoutBaseLogic checkPropertyWithUIControls:subUis
                                                                                layout:subLModes];
    if (!checkLg.isCheckOk) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            //[CCSpeedyTool cc_SetUpAlterWithView:window Message:checkLg.warEr];
        });
        
        return ;
    }
    
    self.base.dbMode = [NSMutableArray arrayWithArray:checkLg.uims];
    
    [self setUpUI];
}

// MARK: 更新 mainTab 布局
- (void)update_TabEdges:(UIEdgeInsets)edges
{
    self.base.edges = edges;
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    CGFloat top = self.base.edges.top;
    CGFloat left = self.base.edges.left;
    CGFloat bottom = self.base.edges.bottom;
    CGFloat right = self.base.edges.right;
    
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
    
    NSMutableArray *queryData = [CCUILayoutUiMode mj_objectArrayWithFilename:plist];
    self.base.dbMode = [NSMutableArray arrayWithArray:queryData];
    
    [self setUpUI];
}

- (void) setUpUI
{
    [self.base register_Cell_ReuseIdentifierFor:self.tableView];
    [self.base register_TabHeader_ReuseIdentifierFor:self.tableView];
    [self.base create_SubViewsFor:self.tableView];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self layoutSubviews];
    });
    
}

// MARK: ———————————— 👇 tableView 代理方法  ————————————

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.base.dbMode.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.base getTableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger index = indexPath.section;
    !self.base.clickElementRb ? : self.base.clickElementRb(self.base.dbUi[index],self.base.dbMode[index],index);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.base.dbMode[indexPath.section].height;
}

/*  MARK: 👇 方便调试的展示方法*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    BOOL isCheckOk = (self.base.isDebugShowSection &&
                      self.base.dbElementNotes.count) ? YES : NO;
    return isCheckOk ? self.base.dbElementNotes[section].height : 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BOOL isCheckOk = (self.base.isDebugShowSection &&
                      self.base.dbElementNotes.count) ? YES : NO;
    if (isCheckOk) {
        
        CCUILayoutDebugView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CCUILayoutDebugView"];
        if (header == nil) {
            header = [[CCUILayoutDebugView alloc] initWithReuseIdentifier:@"CCUILayoutDebugView"];
        }
        [header setWithElementInfo:self.base.dbElementNotes[section]];
        return header;
    }
     return NULL;
 }

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return NULL;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

// MARK: ———————————— 👆 tableView 代理方法  ————————————

/** MARK: 返回所有的布局 view 类实例*/
- (void) wholeUIControls:(void(^)(NSArray<UIResponder*>*,NSMutableArray<CCUILayoutUiMode*>*))subviews
{
    self.base.uisubviewsRb = ^(NSArray<UIResponder *> *uis, NSMutableArray<CCUILayoutUiMode *> *uims) {
        !subviews ? : subviews(uis,uims);
    };
}

/** MARK: 返回用户点击 VIEW \ CELL元素的下标<某些场景可能有用>*/
- (void) getUIControlsTouchIndex:(void(^)(UIResponder *ui,CCUILayoutUiMode *uim,NSInteger index))reback
{
    self.base.clickElementRb = ^(UIResponder *ui, CCUILayoutUiMode *uim, NSInteger index) {
        !reback ? : reback(ui,uim,index);
    };
}

/** MARK: 页面数据有所变动，及时更新页面布局 */
- (void) updateUIControls:(NSMutableArray<CCUILayoutUiMode*> *)subviewModes
{
    self.base.dbMode = [NSMutableArray arrayWithArray:subviewModes];
    [self.tableView reloadData];
}


/** MARK: 是否开启 分区布局调试 设置<默认关闭> */
- (void) setDebugShowSection:(BOOL)isOpen
{
    self.base.isDebugShowSection = isOpen;
}

// 监控观察属性值变化
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    NSLog(@"\n %s —— %@ ",__func__,change);
    
    // 逻辑：监控到 self.base.dbMode 有元素存在的时候在刷新说明性描述元素
    if ([keyPath isEqualToString:@"dbMode"]) {
        
        if (((NSArray*)change[@"new"]).count > 0) {
            
            if (self.base.isDebugShowSection == YES) {
                self.base.dbElementNotes = [CCUILayoutDebugViewMode getCalculateNotesModesFrom:self.base.dbMode];
                [self.tableView reloadData];
            }
        }
    }
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}


@end
