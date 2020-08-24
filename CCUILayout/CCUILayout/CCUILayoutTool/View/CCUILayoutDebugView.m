//
//  CCUILayoutDebugView.m
//  CCUILayout
//  MARK: DebugView 类用来展示当前页面元素信息，方便调试
//  FIXME: <高度计算尚有瑕疵，但是基本满足当前需求，后面维护>
//  Created by Admin on 2020/5/15.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutDebugView.h"
#import "CCUILayout_Unit_Header.h"

@interface CCUILayoutDebugViewMode ()

@end

@implementation CCUILayoutDebugViewMode

/** MARK: 获取计算得到的描述文字高度数组 */
+ (NSArray<CCUILayoutDebugViewMode*>*) getCalculateNotesModesFrom:(NSArray<CCUILayoutUiMode*>*)dbm
{
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width - 30;
    
    NSMutableArray<CCUILayoutDebugViewMode*>* noteModes = [NSMutableArray array];
    
    for (int i = 0; i < dbm.count; i++) {
        
        CCUILayoutUiMode *cLm = dbm[i];
        
        CCUILayoutDebugViewMode *dm = [CCUILayoutDebugViewMode getElementViewDesc:cLm];
        
        NSArray *segs = [dm.desc componentsSeparatedByString:@"\n"];
        
        for (NSString *object in segs) {
            
            CGSize size = [CCSpeedyTool cc_calculateTextSizeWithText:object
                                                        WithTextFont:CCUILayout_FONT_PFSC_Regular_(12)
                                                            WithMaxW:w];
            CGFloat h = size.height;
            
            dm.height += h;
        }
        dm.height += 10;
        [noteModes addObject:dm];
    }
    
    return noteModes;
}

+ (CCUILayoutDebugViewMode*) getElementViewDesc:(CCUILayoutUiMode*)mode
{
    CCUILayoutDebugViewMode *um = [CCUILayoutDebugViewMode new];
    
    // 相关信息
    NSString * name = [@"name：" stringByAppendingString:mode.name];
    NSString * bind = [@"bind：" stringByAppendingString:[mode.bind stringValue]];
    NSString *height = [@"height：" stringByAppendingString:[NSString stringWithFormat:@"%.2f",mode.height]];
    NSString *desc = [@"desc：" stringByAppendingString:mode.desc];
    
    NSString *einfo = @"";
    einfo = [einfo stringByAppendingString:[NSString stringWithFormat:@"%@\n",name]];
    einfo = [einfo stringByAppendingString:[NSString stringWithFormat:@"%@\n",bind]];
    einfo = [einfo stringByAppendingString:[NSString stringWithFormat:@"%@\n",height]];
    einfo = [einfo stringByAppendingString:[NSString stringWithFormat:@"%@",desc]];
    
    um.desc = einfo;
    
    return um;
}

@end


// MARK: 🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞


@interface CCUILayoutDebugView ()

@property(nonatomic,strong) UILabel *Lab;

@end

@implementation CCUILayoutDebugView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpDataAndUi];
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpDataAndUi];
    }
    return self;
}

- (void) setUpDataAndUi
{
    
    self.Lab = [UILabel new];
    self.Lab.numberOfLines = 0;
    self.Lab.textColor = CCUILayout_WHITE;
    [self addSubview:self.Lab];
    self.Lab.backgroundColor = CCUILayout_BLACK;
    
    self.Lab.font = CCUILayout_FONT_PFSC_Regular_(12);
}

- (void) layoutSubviews
{
    
    [self.Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
    
    self.backgroundView.backgroundColor = CCUILayout_BLACK;
}

- (void)setWithElementInfo:(CCUILayoutDebugViewMode *)mode
{
    
    self.Lab.text = mode.desc;
    // 微调效果
    [self.Lab setAdjustsFontSizeToFitWidth:YES];
}

// 设置背景色
- (void) setWithElementInfoColor:(UIColor *)color
{
    self.Lab.backgroundColor = color;
    self.backgroundColor = color;
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
