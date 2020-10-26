//
//  CCUIContainerCell.m
//  CCUIContainer
//  MARK: 基础 CELL 类
//  Created by Admin on 2020/4/29.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "CCUIContainerCell.h"

@implementation CCUIContainerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self commonInitMethod];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self commonInitMethod];
    }
    return self;
}

// MARK: 通用初始化方法
- (void) commonInitMethod {
    
    // 方法调用
    if([self respondsToSelector:@selector(setUpDataAndUi)]){
         [self setUpDataAndUi];
    }
    
    // 标记 cell
    if(IS_OPEN_CCUIContainer_DEBUG_COLOR){
        self.backgroundColor = CCUIContainer_RANDOM_COLOR_LIGHT;
    }
}

-(void)setUpDataAndUi{}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
