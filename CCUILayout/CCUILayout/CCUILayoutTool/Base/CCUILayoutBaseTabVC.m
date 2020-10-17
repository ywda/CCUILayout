//
//  CCUILayoutBaseTabVC.m
//  CCUILayout
//  MARK: 布局页面工具 CCUILayoutBaseTabTabVC 类
//  Created by Admin on 2020/5/6.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutBaseTabVC.h"
#import "CCUILayoutBaseLogic.h"

@interface CCUILayoutBaseTabVC ()

@property(nonatomic,strong)CCUILayoutBaseMode *base;

@end

@implementation CCUILayoutBaseTabVC

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.base = [CCUILayoutBaseMode new];
    }
    return self;
}

- (void) configUIControlsIsLoadDebug:(BOOL)isDebug mainTabEdges:(UIEdgeInsets)edges adapterApp:(BOOL)isAdapter
{
    self.base.edges = edges;
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
    self.base.edges = edges;
    
    CCUILayoutBaseLogic *checkLg = [CCUILayoutBaseLogic checkPropertyWithUIControls:subUis
                                                                                layout:subLModes];
    if (!checkLg.isCheckOk) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [CCSpeedyTool cc_SetUpAlterWithView:self Message:checkLg.warEr];
        });
        
        return ;
    }
    
    self.base.dbMode = [NSMutableArray arrayWithArray:checkLg.uims];
    
    [self setUpUI];
}


// MARK: 需要在子类的 init 方法中调用
- (void) configUIControlsIsLoadDebug:(BOOL)open
{
    Class c = [self class];
    NSString *cName = NSStringFromClass(c);
    NSString *fileName = open ? [cName stringByAppendingFormat:@"_debug"] : cName;
    
    [self configUIControlsWithFilename:fileName];
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //{top, left, bottom, right};
    self.tableView.contentInset = self.base.edges;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    [self.tableView reloadData];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // 注册观察属性 base
    [self.base addObserver:self
                forKeyPath:@"showDebugTag"
                   options:NSKeyValueObservingOptionNew
                   context:NULL];
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
     BOOL isCheckOk = (self.base.showDebugTag &&
                       self.base.dbElementNotes.count) ? YES : NO;
     return isCheckOk ? self.base.dbElementNotes[section].height : 0.001;
 }
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
     BOOL isCheckOk = (self.base.showDebugTag &&
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

/** MARK: 页面数据有所变动，及时更新页面布局 */
- (void) updateUIControls:(NSMutableArray<CCUILayoutUiMode*> *)cc_subviewModes animation:(BOOL)isOpen
{
    self.base.dbMode = [NSMutableArray arrayWithArray:cc_subviewModes];
    if (isOpen) {
        [CCSpeedyTool cc_setInAanimation:self.tableView delay:0.25];
    }
    [self.tableView reloadData];
}

/** MARK: 页面某一块UI元素变动，仅仅刷新某一块布局 */
- (void) updateUIControl:(CCUILayoutUiMode*)cc_uimode animation:(BOOL)isOpen {
     for (int i = 0; i < self.base.dbMode.count; i++) {
         
         CCUILayoutUiMode *one = self.base.dbMode[i];
         
         if (one.bind == cc_uimode.bind &&
             [one.name isEqualToString:cc_uimode.name]) {
             
             [self.base.dbMode replaceObjectAtIndex:i withObject:cc_uimode];
             NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:i];
             
             if (isOpen) {
                 
                 [UIView animateWithDuration:0.25 animations:^{
                     [self.tableView reloadSections:indexSet
                                   withRowAnimation:UITableViewRowAnimationFade];
                 }];
                 
             }else{
                 
                 [self.tableView reloadSections:indexSet
                               withRowAnimation:UITableViewRowAnimationNone];
             }
             
             break;
         }
     }
}

/** MARK: 是否开启 分区布局调试 设置<默认关闭>【要在 viewDidLoad 中调用】 */
- (void) setDebugShowSection:(BOOL)isOpen
{
    self.base.showDebugTag = isOpen;
}

// 监控观察属性值变化
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    NSLog(@"\n %s —— %@ ",__func__,change);
    
    // 逻辑：监控到 self.base.dbMode 有元素存在的时候在刷新说明性描述元素
    if ([keyPath isEqualToString:@"showDebugTag"]) {
        
        if ([change[@"new"] intValue] == 1) {
            
            if (self.base.dbMode.count > 0) {
                self.base.dbElementNotes = [CCUILayoutDebugUiMode getCalculateNotesModesFrom:self.base.dbMode];
                [self.tableView reloadData];
            }
        }
    }
}


/** MARK: 根据 bind值 快速获取UI上的 uiMode */
- (CCUILayoutUiMode* _Nullable) getClmFrom:(NSInteger) bindNum {
    
    if (self.cc_subviewModes.count) {
        
        for (NSInteger i = 0; i < self.cc_subviewModes.count; i++) {
            CCUILayoutUiMode *object = self.cc_subviewModes[i];
//            object.enumIndex = i;
            if (object.bind.integerValue == bindNum) {
                
                return object;
                break;
            }
        }
    }
    return Nil;
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
