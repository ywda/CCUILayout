//
//  CCUILayout_Block.h
//  CCUILayout
//
//  Created by Admin on 2020/4/30.
//  Copyright © 2020 Admin. All rights reserved.
//

#ifndef CCUILayout_Block_h
#define CCUILayout_Block_h

// MARK: 定义了APP中常用的 block
/** 前缀 cc_tab_cell  较长，在具体的模块中使用更换前缀即可 eg: OAPlain 中 cc_tab_cell 更换为 OAP */
// ————————————————————————————————————————————
typedef void(^CCUILayout_block_click)(void);
typedef void(^CCUILayout_block_bool)(BOOL);
typedef void(^CCUILayout_block_str)(NSString*);
typedef void(^CCUILayout_block_int)(NSInteger);
typedef void(^CCUILayout_block_array)(NSArray*);
typedef void(^CCUILayout_block_dic)(NSDictionary*);


#endif /* CCUILayout_Block_h */
