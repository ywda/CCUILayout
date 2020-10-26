//
//  CCUIContainer_Block.h
//  CCUIContainer
//
//  Created by Admin on 2020/4/30.
//  Copyright © 2020 Admin. All rights reserved.
//

#ifndef CCUIContainer_Block_h
#define CCUIContainer_Block_h

// MARK: 定义了APP中常用的 block
/** 前缀 cc_tab_cell  较长，在具体的模块中使用更换前缀即可 eg: OAPlain 中 cc_tab_cell 更换为 OAP */
// ————————————————————————————————————————————
typedef void(^CCUIContainer_block_click)(void);
typedef void(^CCUIContainer_block_bool)(BOOL);
typedef void(^CCUIContainer_block_str)(NSString*);
typedef void(^CCUIContainer_block_int)(NSInteger);
typedef void(^CCUIContainer_block_array)(NSArray*);
typedef void(^CCUIContainer_block_dic)(NSDictionary*);


#endif /* CCUIContainer_Block_h */
