//
//  CCUILayoutSuperBaseCell.m
//  WDZForAppStore
//  MARK: 超级 View <一些公用的处理父类实现>
//  Created by Admin on 2020/9/5.
//  Copyright © 2020 Wandianzhang. All rights reserved.
//

#import "CCUILayoutSuperBaseCell.h"

@interface CCUILayoutSuperBaseCell ()

@property (nonatomic, assign) CCUILayoutViewState state;
@property (nonatomic, strong) UIView *movieViewParentView;
@property (nonatomic) CGRect movieViewFrame;

@end

@implementation CCUILayoutSuperBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.state = CCUILayoutViewStateSmall;
    }
    return self;
}

// MARK: 处理全屏后的 movieView 的布局适配
- (void) layoutWhenChEnterFull {
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.movieView layoutSubviews];
    }];
}

// MARK: 进入全屏
- (void) enterFullscreen{

    if (self.state != CCUILayoutViewStateSmall) {
        return;
    }

    self.state = CCUILayoutViewStateAnimating;

    /*
     * FIXME: 记录进入全屏前的parentView和frame
     */
    
    self.movieViewParentView = [UIApplication sharedApplication].windows.firstObject;
    self.movieViewFrame = self.movieView.frame;

    /*
     * FIXME: movieView移到window上
     */
    CGRect rectInWindow = [self.movieView convertRect:self.movieView.bounds toView:[UIApplication sharedApplication].windows.firstObject];
    [self.movieView removeFromSuperview];
    self.movieView.frame = rectInWindow;
    [[UIApplication sharedApplication].windows.firstObject addSubview:self.movieView];

    /*
     * FIXME: 执行动画
     */
    [UIView animateWithDuration:0.5 animations:^{
        self.movieView.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.movieView.bounds = CGRectMake(0, 0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds));
        self.movieView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
    } completion:^(BOOL finished) {
        self.state = CCUILayoutViewStateFullscreen;
    }];
}

// MARK: 退出全屏
- (void) exitFullscreen{

    if (self.state != CCUILayoutViewStateFullscreen) {
        return;
    }

    self.state = CCUILayoutViewStateAnimating;

    CGRect frame = [self convertRect:self.movieViewFrame toView:[UIApplication sharedApplication].windows.firstObject];

    [UIView animateWithDuration:0.5 animations:^{
        self.movieView.transform = CGAffineTransformIdentity;
        self.movieView.frame = frame;
    } completion:^(BOOL finished) {
        /*
         * FIXME: movieView回到小屏位置
         */
        [self.movieView removeFromSuperview];
        self.movieView.frame = self.movieViewFrame;
        self.movieViewParentView = nil;
        [self addSubview:self.movieView];
        self.state = CCUILayoutViewStateSmall;
    }];
}

// MARK: 自动切换全屏-非全屏
- (void) autoEnterOrExitFullscreen
{
    if (self.state != CCUILayoutViewStateSmall) {
        [self exitFullscreen];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           !self.chUiLayoutRb?:self.chUiLayoutRb(CCUILayoutViewStateSmall);
        });
        [self layoutWhenChEnterFull];
        return;
    }
    
    if (self.state != CCUILayoutViewStateFullscreen) {
        
        [UIView animateWithDuration:0.5 animations:^{
            !self.chUiLayoutRb?:self.chUiLayoutRb(CCUILayoutViewStateFullscreen);
        }];
        
        [self enterFullscreen];
        [self layoutWhenChEnterFull];
        
        return;
    }
}

@end


/**
 
 convert ：转换，转变

 // 将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值
 - (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
 // 将像素point从view中转换到当前视图中，返回在当前视图中的像素值
 - (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
   
 // 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
 - (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
 // 将rect从view中转换到当前视图中，返回在当前视图中的rect
 - (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
 */
