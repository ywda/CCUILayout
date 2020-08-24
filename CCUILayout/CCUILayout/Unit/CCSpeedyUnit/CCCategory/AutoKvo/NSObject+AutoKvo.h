//
//  NSObject+AutoKvo.h
//  CCUILayout
//
//  Created by Admin on 2020/5/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CCDeallockCallbackTask)(id obj);
typedef void(^CCKVOObservedChangeHandler)(id target, NSDictionary<NSKeyValueChangeKey,id> *_Nullable change);
typedef NSInteger CCKVOObserverToken;

/// - KVO -
/// Add Observer (autoremove) [target, keyPath, change]
extern CCKVOObserverToken
cckvo_observe(id target, NSString *keyPath, CCKVOObservedChangeHandler handler);

/// Add Observer (autoremove) [target, keyPath, options, change]
extern CCKVOObserverToken __attribute__((overloadable))
cckvo_observe(id target, NSString *keyPath, NSKeyValueObservingOptions options, CCKVOObservedChangeHandler handler);

/// Remove Observer
extern void
cckvo_remove(id target, CCKVOObserverToken token);


/// - KVO -
@interface NSObject (AutoKvo)
/// Add an observer, you don't need to remove observer (autoremove)
/// 添加观察者, 无需移除 (将会自动移除)
- (void)cc_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

/// Add an observer, you don't need to remove observer (autoremove)
/// 添加观察者, 无需移除 (将会自动移除)
- (void)cc_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context;

/// Add an observer, you don't need to remove observer (autoremove)
/// 添加观察者, 无需移除 (将会自动移除)
- (void)cc_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end

/// - Notification -
@interface NSObject (CCNotificationHelper)
/// Autoremove
- (void)cc_observeWithNotification:(NSNotificationName)notification target:(id _Nullable)sender usingBlock:(void(^)(id self, NSNotification *note))block;

/// Autoremove
- (void)cc_observeWithNotification:(NSNotificationName)notification target:(id _Nullable)sender queue:(NSOperationQueue *_Nullable)queue usingBlock:(void(^)(id self, NSNotification *note))block;
@end

/// - DeallocCallback -
@interface NSObject (CCDeallocCallback)
/// Add a task that will be executed when the object is destroyed
/// 添加一个任务, 当对象销毁时将会执行这些任务
- (void)cc_addDeallocCallbackTask:(CCDeallockCallbackTask)callback;

@end

NS_ASSUME_NONNULL_END
