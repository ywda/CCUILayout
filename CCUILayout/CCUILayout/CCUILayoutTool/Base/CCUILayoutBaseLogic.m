//
//  CCUILayoutBaseLogic.m
//  CCUILayout
//  MARK: 一些基础逻辑的抽取
//  Created by Admin on 2020/5/15.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUILayoutBaseLogic.h"

@implementation CCUILayoutBaseLogic

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isCheckOk = NO;
        self.warEr = @"";
        self.uims = [NSMutableArray array];
    }
    return self;
}

// MARK: 在通过实例数组创建页面的时候校验模型
+ (CCUILayoutBaseLogic*) checkPropertyWithUIControls:(NSArray<UIResponder *> *)subUis
                                              layout:(NSArray<CCUILayoutUiMode*> *)subLModes
{
    CCUILayoutBaseLogic *result= [CCUILayoutBaseLogic new];
    
    BOOL isSecurity = ((subUis && subLModes) &&
                       (subUis.count == subLModes.count)) ? YES : NO;
    
    if (!isSecurity) {
        
        result.warEr = [NSString stringWithFormat:@"(subUis、subLModes个数不匹配) 终止执行：\n %s \n",__func__];
        
        return result;
    }
    
    // MARK: 安全检查
    NSMutableArray<CCUILayoutUiMode*> * tmpAry = [NSMutableArray array];
    NSMutableSet *tmpBinds = [NSMutableSet set];
    
    for (int i = 0; i < subUis.count; i++) {
        
        CCUILayoutUiMode *clm = subLModes[i];
        
        // MARK:——> 步骤1、 height 校验
        clm.height = (clm.height < 0) ? 0 : clm.height;

        // MARK:——> 步骤2、 bind 值唯一校验
        [tmpBinds addObject:clm.bind];
        if ((i+1) == subUis.count) {
            if (tmpBinds.count != subUis.count) {
                result.warEr = [NSString stringWithFormat:@"(bind值必须唯一) 终止执行：%s",__func__];
                return result;
            }
        }

        // MARK:——> 步骤3、 name 类名校验
        if (!clm.name ||
            [clm.name isEqualToString:@""]) {
            
            clm.name = NSStringFromClass([subUis[i] class]);
        }
        
        // MARK:——> 步骤4、 desc 描述值<校验补全>
        if (clm.desc.length == 0) {
            clm.desc = [NSString stringWithFormat:@"%@ 类对象实例，bind = %d",clm.name,[clm.bind intValue]];
        }
        [tmpAry addObject:clm];
    }
    
    result.isCheckOk = YES;
    result.uims = tmpAry;
    
    return result;
}

@end
