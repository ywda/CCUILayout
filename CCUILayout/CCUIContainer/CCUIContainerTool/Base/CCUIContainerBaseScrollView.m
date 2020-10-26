//
//  CCUIContainerBaseScrollView.m
//  CCUIContainer
//
//  Created by Admin on 2020/10/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerBaseScrollView.h"
#import "CCUIContainerBaseLogic.h"
#import "CCUIContainerBaseMode+Scroll.h"

@interface CCUIContainerBaseScrollView ()<UIScrollViewDelegate>

@property(nonatomic,strong)CCUIContainerBaseMode *base;

@end

@implementation CCUIContainerBaseScrollView

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
    [self addSubview:self.scrollView];
    [self.base addObserver:self
                forKeyPath:@"showDebugTag"
                   options:NSKeyValueObservingOptionNew
                   context:NULL];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.delegate = self;
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.layer.masksToBounds = YES;
        _scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        
    }
    return _scrollView;
}

- (void) configUIControls:(NSArray<UIResponder *> *)subUis
                   layout:(NSArray<CCUIContainerUiMode*> *)subLModes
             mainTabEdges:(UIEdgeInsets)edges
{
    [self update_TabEdges:edges];
    
    CCUIContainerBaseLogic *checkLg = [CCUIContainerBaseLogic checkPropertyWithUIControls:subUis
                                                                                layout:subLModes];
    self.base.dbMode = [NSMutableArray arrayWithArray:checkLg.uims];
    
    [self setUpUI];
}

- (void)update_TabEdges:(UIEdgeInsets)edges
{
    self.base.edges = edges;
    [self update_scroll];
}

- (void) update_scroll {
    
    CGFloat top = self.base.edges.top;
    CGFloat left = self.base.edges.left;
    CGFloat bottom = self.base.edges.bottom;
    CGFloat right = self.base.edges.right;
    
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
        make.left.mas_equalTo(left);
        make.bottom.mas_equalTo(bottom);
        make.right.mas_equalTo(right);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self update_scroll];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(performWhenLayoutSubviews)
                                                   object:nil];

    [self performSelector:@selector(performWhenLayoutSubviews)
               withObject:nil
               //afterDelay:0];
               afterDelay:0.0075];
}

- (void) performWhenLayoutSubviews {
    [self.base update_SubViewsForScrollView:self.scrollView];
    [self.base layout_SubViewsForScrollView:self.scrollView];
}

- (void) configUIControlsIsLoadDebug:(BOOL)isDebug
                        mainTabEdges:(UIEdgeInsets)edges
                          adapterApp:(BOOL)isAdapter{
    [self update_TabEdges:edges];
    
    Class c = [self class];
    NSString *cName = NSStringFromClass(c);
    
    if (isAdapter) {
        cName = [CCUIContainerConfig getConfigPlistNameBy:cName];
    }
    
    NSString *fileName = isDebug ? [cName stringByAppendingFormat:@"_debug"] : cName;
    
    [self configUIControlsWithFilename:fileName];
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
    self.cc_subviewModes = self.base.dbMode;
    self.cc_subviews = [self.base create_SubViewsForScrollView:self.scrollView];
    
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
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.base update_SubViewsForScrollView:self.scrollView];
        [self.base layout_SubViewsForScrollView:self.scrollView];
    });
}

- (void) wholeUIControls:(void(^)(NSArray<UIResponder*>*,NSMutableArray<CCUIContainerUiMode*>*))subviews
{
    self.base.uisubviewsRb = ^(NSArray<UIResponder *> *uis, NSMutableArray<CCUIContainerUiMode *> *uims) {
        !subviews ? : subviews(uis,uims);
    };
}

- (void) getUIControlsTouchIndex:(void(^)(UIResponder *ui,CCUIContainerUiMode *uim,NSInteger index))reback
{
    self.base.clickElementRb = ^(UIResponder *ui, CCUIContainerUiMode *uim, NSInteger index) {
        !reback ? : reback(ui,uim,index);
    };
}

- (void) updateUIControls:(NSMutableArray<CCUIContainerUiMode*> *)cc_subviewModes
                animation:(BOOL)isOpen{
    self.base.dbMode = [NSMutableArray arrayWithArray:cc_subviewModes];
    if (isOpen) {
        [CCSpeedyTool cc_setInSlideAanimation:self.scrollView delay:0.3];
    }
    [self layoutSubviews];
}

- (void) updateUIControl:(CCUIContainerUiMode*)cc_uimode animation:(BOOL)isOpen {
     for (int i = 0; i < self.base.dbMode.count; i++) {
         
         CCUIContainerUiMode *one = self.base.dbMode[i];
         
         if (one.bind == cc_uimode.bind &&
             [one.name isEqualToString:cc_uimode.name]) {
             
             [self.base.dbMode replaceObjectAtIndex:i withObject:cc_uimode];
             //[self updateUIControls:self.base.dbMode animation:isOpen];
             
             __weak typeof(self) weakSelf = self;
             UIView *ui = (UIView*)weakSelf.cc_subviews[i];
             
             if (cc_uimode.height <= 0) {
                 
                 [CCSpeedyTool cc_setInAanimation:ui delay:0.4];
                 [ui mas_updateConstraints:^(MASConstraintMaker *make) {
                     make.height.mas_equalTo(0);
                 }];
                 ui.alpha = 0;
                 
             }else{
                 
                 ui.alpha = 1;
                 [CCSpeedyTool cc_setInAanimation:ui delay:0.4];
                 [ui mas_updateConstraints:^(MASConstraintMaker *make) {
                     make.height.mas_equalTo(cc_uimode.height);
                 }];
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
                
                [self performWhenLayoutSubviews];
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

@end
