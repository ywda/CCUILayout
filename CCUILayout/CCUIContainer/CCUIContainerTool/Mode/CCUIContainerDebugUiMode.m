//
//  CCUIContainerDebugUiMode.m
//  WDZForAppStore
//  MARK: 注释部分的 debugUiMode
//  Created by Admin on 2020/9/5.
//  Copyright © 2020 Wandianzhang. All rights reserved.
//

#import "CCUIContainerDebugUiMode.h"

@implementation CCUIContainerDebugUiMode

/** MARK: 获取计算得到的描述文字高度数组 */
+ (NSMutableArray<CCUIContainerDebugUiMode*>*) getCalculateNotesModesFrom:(NSArray<CCUIContainerUiMode*>*)dbm
{
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width - 30;
    
    NSMutableArray<CCUIContainerDebugUiMode*>* noteModes = [NSMutableArray array];
    
    for (int i = 0; i < dbm.count; i++) {
        
        CCUIContainerUiMode *cLm = dbm[i];
        
        CCUIContainerDebugUiMode *dm = [CCUIContainerDebugUiMode getElementViewDesc:cLm];
        dm.linkCLM = cLm;
        NSArray *segs = [dm.desc componentsSeparatedByString:@"\n"];
        
        for (NSString *object in segs) {
            
            CGSize size = [CCSpeedyTool cc_calculateTextSizeWithText:object
                                                        WithTextFont:CCUIContainer_FONT_PFSC_Regular_(12)
                                                            WithMaxW:w];
            CGFloat h = size.height;
            
            dm.height += h;
        }
        dm.height += 10;
        [noteModes addObject:dm];
    }
    
    return noteModes;
}

+ (CCUIContainerDebugUiMode*) getElementViewDesc:(CCUIContainerUiMode*)mode
{
    CCUIContainerDebugUiMode *um = [CCUIContainerDebugUiMode new];
    
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
