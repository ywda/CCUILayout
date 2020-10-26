//
//  CCUIContainerBaseVC.m
//  CCUIContainer
//  MARK: 容器工具 CCUIContainerBaseVC 类
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerBaseVC.h"
#import "CCUIContainerBaseLogic.h"
#import "CCUIContainerBaseMode+Tab.h"

@interface CCUIContainerBaseVC ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)CCUIContainerBaseMode *base;
@property(nonatomic,assign)UITableViewStyle pageType;

@end

@implementation CCUIContainerBaseVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageType = UITableViewStyleGrouped;
        self.base = [CCUIContainerBaseMode new];
    }
    return self;
}

- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame
                                                  style:self.pageType];
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
    [self.view addSubview:self.tableView];
}

- (void) configUIControlsIsLoadDebug:(BOOL)isDebug
                        mainTabEdges:(UIEdgeInsets)edges
                          adapterApp:(BOOL)isAdapter
{
    [self setUpdateTab];
    [self updateContainerEdges:edges];
    
    Class c = [self class];
    NSString *cName = NSStringFromClass(c);
    
    if (isAdapter) {
        cName = [CCUIContainerConfig getConfigPlistNameBy:cName];
    }
    
    NSString *fileName = isDebug ? [cName stringByAppendingFormat:@"_debug"] : cName;
    
    [self configUIControlsWithFilename:fileName];
}

- (void) configUIControlsIsLoadDebug:(BOOL)isDebug
                        mainTabEdges:(UIEdgeInsets)edges
                          adapterApp:(BOOL)isAdapter
                           pageStyle:(UITableViewStyle)style{
    self.pageType = style;
    [self configUIControlsIsLoadDebug:isDebug
                         mainTabEdges:edges
                           adapterApp:isAdapter];
}

- (void) configUIControlsIsLoadDebug:(BOOL)isDebug
                        mainTabEdges:(UIEdgeInsets)edges
                          adapterApp:(BOOL)isAdapter
                           pageColor:(UIColor*)color{
    if (!color) {
        [self configUIControlsIsLoadDebug:isDebug
                             mainTabEdges:edges
                               adapterApp:isAdapter];
    }else{
        self.pageType = UITableViewStylePlain;
        [self configUIControlsIsLoadDebug:isDebug
                             mainTabEdges:edges
                               adapterApp:isAdapter];
        self.tableView.backgroundColor = color;
    }
}

- (void) configUIControls:(NSArray<UIResponder *> *)subUis
                   layout:(NSArray<CCUIContainerUiMode*> *)subLModes
             mainTabEdges:(UIEdgeInsets)edges
{
    [self setUpdateTab];
    [self updateContainerEdges:edges];
    
    CCUIContainerBaseLogic *checkLg = [CCUIContainerBaseLogic checkPropertyWithUIControls:subUis
                                                                                layout:subLModes];
    if (!checkLg.isCheckOk) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
            [CCSpeedyTool cc_SetUpAlterWithView:self Message:checkLg.warEr];
        });
        
        return ;
    }
    
    self.base.dbMode = [NSMutableArray arrayWithArray:checkLg.uims];
    
    [self setUpUI];
}

- (void)updateContainerEdges:(UIEdgeInsets)edges
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
        
        self.base.uisubviewsRb = ^(NSArray<UIResponder *> *uis,
                                   NSMutableArray<CCUIContainerUiMode *> *uims) {
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView reloadData];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
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

- (void) getUIControlsTouchIndex:(void(^)(UIResponder *ui,CCUIContainerUiMode *uim,NSInteger index))reback
{
    self.base.clickElementRb = ^(UIResponder *ui,
                                 CCUIContainerUiMode *uim,
                                 NSInteger index) {
        
        !reback ? : reback(ui,uim,index);
    };
}

- (void) updateUIControls:(NSMutableArray<CCUIContainerUiMode*> *)cc_subviewModes animation:(BOOL)isOpen
{
    self.base.dbMode = [NSMutableArray arrayWithArray:cc_subviewModes];
    if (isOpen) {
        [CCSpeedyTool cc_setInAanimation:self.tableView delay:0.25];
    }
    [self.tableView reloadData];
}

- (void) updateUIControl:(CCUIContainerUiMode*)cc_uimode animation:(BOOL)isOpen {
     for (int i = 0; i < self.base.dbMode.count; i++) {
         
         CCUIContainerUiMode *one = self.base.dbMode[i];
         
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

- (void) setShowNoteView:(BOOL)isOpen
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
