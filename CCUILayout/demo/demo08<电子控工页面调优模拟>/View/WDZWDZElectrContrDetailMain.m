//
//  WDZWDZElectrContrDetailMain.m
//  CCUILayout
//
//  Created by Admin on 2020/10/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "WDZWDZElectrContrDetailMain.h"
#import "WDZElectrContrDetailOrderInfoView.h"
#import "WDZElectrContrDetailVedioHandleView.h"
#import "WDZElectrContrDetailVedioBarView.h"
#import "WDZElectrContrDetailHistoryServeView.h"
#import "WDZElectrContrDetailActHeadView.h"
#import "CCUILayoutSegLineView.h"

@interface WDZWDZElectrContrDetailMain ()

@property(nonatomic,strong) WDZElectrContrDetailOrderInfoView *orderInfoView;
@property(nonatomic,strong) WDZElectrContrDetailVedioHandleView *vedioHandle;
@property(nonatomic,strong) WDZElectrContrDetailVedioBarView *vedioBar;
@property(nonatomic,strong) WDZElectrContrDetailHistoryServeView *historyServeView;
@property(nonatomic,strong) WDZElectrContrDetailActHeadView *actHeadView;


@end

@implementation WDZWDZElectrContrDetailMain

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
        [self configUIControlsIsLoadDebug:NO
                             mainTabEdges:insets
                               adapterApp:NO];
        [self setDebugShowSection:NO];
        [self setUpUi];
    }
    return self;
}

- (void)setUpUi {
    
    __weak typeof(self) weakSelf = self;
    [self wholeUIControls:^(NSArray<UIResponder *> * uis, NSMutableArray<CCUILayoutUiMode *> * uims) {
        weakSelf.cc_subviews = uis;
        weakSelf.cc_subviewModes = uims;
    }];
    self.tableView.showsVerticalScrollIndicator = YES;
    [self updateUiRealyData];
}


// MARK: 更新整个页面展示值...
- (void) updateUiRealyData {

    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < self.cc_subviewModes.count; i++) {

        UIResponder *ui = self.cc_subviews[i];
        CCUILayoutUiMode *clm = self.cc_subviewModes[i];
        
        // MARK: ·视频控制·
        if (clm.bind.intValue == 1) {
            
            self.vedioHandle = (WDZElectrContrDetailVedioHandleView*)ui;
            [self.vedioHandle updateWithRb:^(BOOL havePlayBar) {
                
                // 控制显隐·视频播放进度条·
                CCUILayoutUiMode *tmp = [weakSelf getClmFrom:2];
                // FIXME: 非常有必要，否则效果突兀 <原因：CCUILayoutBaseView 中cell背景色均去除了>
                tmp.bgColor = UIColor.whiteColor;
                if (tmp) {
                    tmp.height = havePlayBar?(35+90+15+10):0;
                    [weakSelf.cc_subviewModes replaceObjectAtIndex:i withObject:clm];
                    [weakSelf updateUIControls:weakSelf.cc_subviewModes animation:YES];
                    weakSelf.vedioBar.alpha = havePlayBar?1:0;
                    weakSelf.vedioBar.havePlayBar = havePlayBar;
                }
            }];
        }
        
        // MARK: ·视频进度条·
        if (clm.bind.intValue == 2) {
            
            self.vedioBar = (WDZElectrContrDetailVedioBarView*)ui;
            weakSelf.vedioBar.alpha = weakSelf.vedioBar.havePlayBar?1:0;
        }
        
        // MARK: ·工位详情·
        if (clm.bind.intValue == 3) {
            
            self.actHeadView = (WDZElectrContrDetailActHeadView*)ui;
        }

        // MARK: ·详情描述·
        if (clm.bind.intValue == 4) {
            
            self.orderInfoView = (WDZElectrContrDetailOrderInfoView*)ui;;
        }

        // MARK: ·今日历史服务·
        if (clm.bind.intValue == 5) {
        
        }

        // MARK: ·历史服务列表·
        if (clm.bind.intValue == 6) {
            
            self.historyServeView = (WDZElectrContrDetailHistoryServeView*)ui;
            clm.bgColor = UIColor.whiteColor;
            [weakSelf updateUIControl:clm animation:YES];
        }

        // MARK: ·分割线颜色·
        if (clm.bind.intValue == -1) {
            
            CCUILayoutSegLineView *uiSegline = (CCUILayoutSegLineView*)ui;
            uiSegline.backgroundColor =  UIColor.clearColor;
        }

        // MARK: ·底部留白颜色·
        if (clm.bind.intValue == -2) {
            
            CCUILayoutSegLineView *uiSpace = (CCUILayoutSegLineView*)ui;
            
            uiSpace.backgroundColor = UIColor.clearColor;
        }
    }
}

@end
