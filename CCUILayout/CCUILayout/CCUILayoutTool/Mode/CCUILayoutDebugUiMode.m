//
//  CCUILayoutDebugUiMode.m
//  WDZForAppStore
//  MARK: 注释部分的 debugUiMode
//  Created by Admin on 2020/9/5.
//  Copyright © 2020 Wandianzhang. All rights reserved.
//

#import "CCUILayoutDebugUiMode.h"

@implementation CCUILayoutDebugUiMode

/** MARK: 获取计算得到的描述文字高度数组 */
+ (NSArray<CCUILayoutDebugUiMode*>*) getCalculateNotesModesFrom:(NSArray<CCUILayoutUiMode*>*)dbm
{
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width - 30;
    
    NSMutableArray<CCUILayoutDebugUiMode*>* noteModes = [NSMutableArray array];
    
    for (int i = 0; i < dbm.count; i++) {
        
        CCUILayoutUiMode *cLm = dbm[i];
        
        CCUILayoutDebugUiMode *dm = [CCUILayoutDebugUiMode getElementViewDesc:cLm];
        
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

+ (CCUILayoutDebugUiMode*) getElementViewDesc:(CCUILayoutUiMode*)mode
{
    CCUILayoutDebugUiMode *um = [CCUILayoutDebugUiMode new];
    
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
