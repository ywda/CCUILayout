//
//  CCUIContainerBaseView.m
//  CCUIContainer
//
//  Created by Admin on 2020/5/14.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerBaseView.h"
#import "CCUIContainerBaseLogic.h"
#import "CCUIContainerBaseMode+Tab.h"

@interface CCUIContainerBaseView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)CCUIContainerBaseMode *base;
/** FIXME: 页面某元素高度为0的时候，避免因为复杂元素内部计算缓慢引起的性能问题,让页面滑动更加流畅...*/
/** FIXME: 某元素高度为0的时候，cellForRow 方法依旧会执行，执行就会走某元素的内部方法，导致无效计算，因此这么处理...*/
@property(nonatomic,strong)UITableViewCell *zeroCell;


@end

@implementation CCUIContainerBaseView

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
    self.base = [CCUIContainerBaseMode new];
    [self setUpdateTab];
    
    // 注册观察属性 base
    [self.base addObserver:self
                forKeyPath:@"showDebugTag"
                   options:NSKeyValueObservingOptionNew
                   context:NULL];
}

- (UITableViewCell *)zeroCell {
    if (!_zeroCell) {
        _zeroCell = [UITableViewCell new];
    }
    return _zeroCell;
}

- (UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.frame
                                                  style:UITableViewStyleGrouped];
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        // FIXME: 解决刷新的时候跳动的问题
        if (@available(iOS 11,*)) {
            
            UITableView.appearance.estimatedRowHeight = 0;
            UITableView.appearance.estimatedSectionHeaderHeight = 0;
            UITableView.appearance.estimatedSectionFooterHeight = 0;
            
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
    }
    return _tableView;
}

- (void) setUpdateTab
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
}

- (void) configUIControlsIsLoadDebug:(BOOL)isDebug mainTabEdges:(UIEdgeInsets)edges adapterApp:(BOOL)isAdapter
{
    [self update_TabEdges:edges];
    
    Class c = [self class];
    NSString *cName = NSStringFromClass(c);
    
    // 如果开启适配 App 定制化，则要创建相关的定制配置 plist 文件
    if (isAdapter) {
        cName = [CCUIContainerConfig getConfigPlistNameBy:cName];
    }
    
    NSString *fileName = isDebug ? [cName stringByAppendingFormat:@"_debug"] : cName;
    
    [self configUIControlsWithFilename:fileName];
}

- (void) configUIControls:(NSArray<UIResponder *> *)subUis
                   layout:(NSArray<CCUIContainerUiMode*> *)subLModes
             mainTabEdges:(UIEdgeInsets)edges
{
    [self update_TabEdges:edges];
    
    CCUIContainerBaseLogic *checkLg = [CCUIContainerBaseLogic checkPropertyWithUIControls:subUis
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
    
    NSMutableArray *queryData = [CCUIContainerUiMode mj_objectArrayWithFilename:plist];
    self.base.dbMode = [NSMutableArray arrayWithArray:queryData];
    
    if (!self.base.uisubviewsRb) {
        
        __weak typeof(self) ws = self;
        
        self.base.uisubviewsRb = ^(NSArray<UIResponder *> *uis, NSMutableArray<CCUIContainerUiMode *> *uims) {
            ws.cc_subviews = [NSArray arrayWithArray:uis];
            ws.cc_subviewModes = [NSMutableArray arrayWithArray:uims];;
        };
    }
    
    [self setUpUI];
}

- (void) setUpUI
{
    [self.base register_Cell_ReuseIdentifierFor:self.tableView];
    [self.base register_TabHeader_ReuseIdentifierFor:self.tableView];
    [self.base create_SubViewsForTab:self.tableView];
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
    
    CCUIContainerUiMode *cm = self.base.dbMode[indexPath.section];
    if (cm.height <= 0) {
        return self.zeroCell;
    }
    return [self.base getTableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger index = indexPath.section;
    !self.base.clickElementRb ? : self.base.clickElementRb(self.base.dbUi[index],
                                                           self.base.dbMode[index],index);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.base.dbMode[indexPath.section].height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    BOOL isCheckOk = (self.base.showDebugTag &&
                      self.base.dbNoteUims.count) ? YES : NO;
    return isCheckOk ? self.base.dbNoteUims[section].height : 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BOOL isCheckOk = (self.base.showDebugTag &&
                      self.base.dbNoteUims.count) ? YES : NO;
    if (isCheckOk) {
        
        CCUIContainerDebugView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CCUIContainerDebugView"];
        
        if (header == nil) {
            header = [[CCUIContainerDebugView alloc] initWithReuseIdentifier:@"CCUIContainerDebugView"];
        }
        [header setWithElementInfo:self.base.dbNoteUims[section]];
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

- (void) wholeUIControls:(void(^)(NSArray<UIResponder*>*,NSMutableArray<CCUIContainerUiMode*>*))subviews
{
    self.base.uisubviewsRb = ^(NSArray<UIResponder *> *uis,
                               NSMutableArray<CCUIContainerUiMode *> *uims) {
        !subviews ? : subviews(uis,uims);
    };
}

- (void) getUIControlsTouchIndex:(void(^)(UIResponder *ui,CCUIContainerUiMode
                                          *uim,NSInteger index))reback
{
    self.base.clickElementRb = ^(UIResponder *ui, CCUIContainerUiMode *uim,
                                 NSInteger index) {
        !reback ? : reback(ui,uim,index);
    };
}

- (void) updateUIControls:(NSMutableArray<CCUIContainerUiMode*> *)cc_subviewModes
                animation:(BOOL)isOpen{
    self.base.dbMode = [NSMutableArray arrayWithArray:cc_subviewModes];
    [self.base update_SubViewsForTab:self.tableView];
    if (isOpen) {
        [CCSpeedyTool cc_setInSlideAanimation:self.tableView delay:0.25];
    }
    [self.tableView reloadData];
}

- (void) updateUIControl:(CCUIContainerUiMode*)cc_uimode animation:(BOOL)isOpen {
     for (int i = 0; i < self.base.dbMode.count; i++) {
         
         CCUIContainerUiMode *one = self.base.dbMode[i];
         
         if (one.bind == cc_uimode.bind &&
             [one.name isEqualToString:cc_uimode.name]) {
             
             [self.base.dbMode replaceObjectAtIndex:i withObject:cc_uimode];
             [self.base update_SubViewsForTab:self.tableView];
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

- (void) setDebugShowSection:(BOOL)isOpen
{
    self.base.showDebugTag = isOpen;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    NSLog(@"\n %s —— %@ ",__func__,change);
    
    if ([keyPath isEqualToString:@"showDebugTag"]) {
        
        if ([change[@"new"] intValue] == 1) {
            
            if (self.base.dbMode.count > 0) {
                self.base.dbNoteUims = [CCUIContainerDebugUiMode getCalculateNotesModesFrom:self.base.dbMode];
                [self.tableView reloadData];
            }
        }
    }
}

- (CCUIContainerUiMode* _Nullable) getClmFrom:(NSInteger) bindNum {
    
    if (self.cc_subviewModes.count) {
        
        for (NSInteger i = 0; i < self.cc_subviewModes.count; i++) {
            CCUIContainerUiMode *object = self.cc_subviewModes[i];
            
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
