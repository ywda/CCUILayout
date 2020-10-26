//
//  NSObject+AutoKvo.m
//  CCUIContainer
//
//  Created by Admin on 2020/5/17.
//  Copyright © 2020 Admin. All rights reserved.
//

#import "NSObject+AutoKvo.h"
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface __CCKVOAutoremove: NSObject {
@public
    char _key;
}
@property (nonatomic, unsafe_unretained, nullable) id target;
@property (nonatomic, unsafe_unretained, nullable) id observer;
@property (nonatomic, weak, nullable) __CCKVOAutoremove *factor;
@property (nonatomic, copy, nullable) NSString *keyPath;
@end

@implementation __CCKVOAutoremove
- (void)dealloc {
    if ( _factor ) {
        [_target removeObserver:_observer forKeyPath:_keyPath];
        _factor = nil;
    }
}
@end

@implementation NSObject (AutoKvo)
- (void)cc_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    [self cc_addObserver:observer forKeyPath:keyPath context:NULL];
}

- (void)cc_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context {
    [self cc_addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:context];
}

- (void)cc_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    NSParameterAssert(observer);
    NSParameterAssert(keyPath);
    
    if ( !observer || !keyPath ) return;
    
    NSString *hashstr = [NSString stringWithFormat:@"%lu-%@", (unsigned long)[observer hash], keyPath];
    
    @synchronized (self) {
        if ( [[self cc_observerhashSet] containsObject:hashstr] ) return;
        else [[self cc_observerhashSet] addObject:hashstr];
    }
    
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
    
    __CCKVOAutoremove *helper = [__CCKVOAutoremove new];
    __CCKVOAutoremove *sub = [__CCKVOAutoremove new];
    
    sub.target = helper.target = self;
    sub.observer = helper.observer = observer;
    sub.keyPath = helper.keyPath = keyPath;
    
    helper.factor = sub;
    sub.factor = helper;
    
    __weak typeof(self) _self = self;
    [observer cc_addDeallocCallbackTask:^(id  _Nonnull obj) {
        __strong typeof(_self) self = _self;
        if ( !self ) return;
        @synchronized (self) {
            [[self cc_observerhashSet] removeObject:hashstr];
        }
    }];
    
    objc_setAssociatedObject(self, &helper->_key, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(observer, &sub->_key, sub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableSet<NSString *> *)cc_observerhashSet {
    NSMutableSet<NSString *> *set = objc_getAssociatedObject(self, _cmd);
    if ( set ) return set;
    set = [NSMutableSet set];
    objc_setAssociatedObject(self, _cmd, set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return set;
}

@end


#pragma mark - Notification
@implementation NSObject (CCNotificationHelper)
- (void)cc_observeWithNotification:(NSNotificationName)notification target:(id _Nullable)target usingBlock:(void(^)(id self, NSNotification *note))block {
    [self cc_observeWithNotification:notification target:target queue:NSOperationQueue.mainQueue usingBlock:block];
}
- (void)cc_observeWithNotification:(NSNotificationName)notification target:(id _Nullable)target queue:(NSOperationQueue *_Nullable)queue usingBlock:(void(^)(id self, NSNotification *note))block {
    __weak typeof(self) _self = self;
    id token = [NSNotificationCenter.defaultCenter addObserverForName:notification object:target queue:queue usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(_self) self = _self;
        if ( !self ) return;
        if ( block ) block(self, note);
    }];
    
    [self cc_addDeallocCallbackTask:^(id  _Nonnull obj) {
        [NSNotificationCenter.defaultCenter removeObserver:token];
    }];
}
@end


#pragma mark - CCDeallocCallback
@interface __CCDeallockCallback : NSObject {
@public
    char _key;
}
@property (nonatomic, unsafe_unretained, nullable) id target;
@property (nonatomic, copy, nullable) CCDeallockCallbackTask task;
@end

@implementation __CCDeallockCallback
- (void)dealloc {
    if ( _task ) _task(_target);
}
@end

@implementation NSObject (CCDeallocCallback)
- (void)cc_addDeallocCallbackTask:(CCDeallockCallbackTask)block {
    __CCDeallockCallback *callback = [__CCDeallockCallback new];
    callback.target = self;
    callback.task = block;
    objc_setAssociatedObject(self, &callback->_key, callback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@interface __CCKVOObserver : NSObject {
@public
    char _key;
}
@property (nonatomic, unsafe_unretained, readonly) id target;
@property (nonatomic, copy, readonly) NSString *keyPath;
@property (nonatomic, readonly) NSKeyValueObservingOptions options;
@property (nonatomic, copy, readonly) CCKVOObservedChangeHandler hanlder;
@end
@implementation __CCKVOObserver
- (instancetype)initWithTarget:(__unsafe_unretained id)target
                    forKeyPath:(NSString *)keyPath
                       options:(NSKeyValueObservingOptions)options
                        change:(CCKVOObservedChangeHandler)hanlder {
    self = [super init];
    if ( !self ) return nil;
    _target = target;
    _keyPath = [keyPath copy];
    _hanlder = hanlder;
    [_target addObserver:self forKeyPath:keyPath options:options context:NULL];
    return self;
}
- (void)dealloc {
    @try {
        [_target removeObserver:self forKeyPath:_keyPath];
    } @catch (NSException *__unused exception) { }
}
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey,id> *)change context:(nullable void *)context {
    if ( _hanlder ) _hanlder(object, change);
}
@end

CCKVOObserverToken
cckvo_observe(id target, NSString *keyPath, CCKVOObservedChangeHandler handler) {
    return cckvo_observe(target, keyPath, NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld, handler);
}

CCKVOObserverToken __attribute__((overloadable))
cckvo_observe(id target, NSString *keyPath, NSKeyValueObservingOptions options, CCKVOObservedChangeHandler handler) {
    if ( !target )
        return 0;
    __CCKVOObserver *observer = [[__CCKVOObserver alloc] initWithTarget:target forKeyPath:keyPath options:options change:handler];
    objc_setAssociatedObject(target, &observer->_key, observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return (CCKVOObserverToken)&observer->_key;
}

void
cckvo_remove(id target, CCKVOObserverToken token) {
    objc_setAssociatedObject(target, (void *)token, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

NS_ASSUME_NONNULL_END
