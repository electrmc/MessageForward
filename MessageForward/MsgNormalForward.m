//
//  MsgNormalForward.m
//  MessageForward
//
//  Created by MiaoChao on 15/12/21.
//  Copyright © 2015年 MiaoChao. All rights reserved.
//

#import "MsgNormalForward.h"
#import <objc/runtime.h>

@implementation Book
@dynamic title, author; // 不自动生成实现，也就没有该变量

- (instancetype)init{
    if ((self = [super init])) {
        _data = [[NSMutableDictionary alloc] init];
        [_data setObject:@"Tom Sawyer" forKey:@"title"];
        [_data setObject:@"Mark Twain" forKey:@"author"];
    }
    return self;
}

// 想要完成标准消息转发就必须实现下面两个方法
// 根据该方法返回的NSMethodSignature来生成NSInvocation
// 因为invocationWithMethodSignature:NSMethodSignature就这么一个方法，苹果应该不会再私自搞一套
// 生成invocation后，runtime会根据原始方法设置好invocation，其target,selector,argument都是原始方法的
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector{
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (signature) {
        return signature;
    }
    
    NSString *sel = NSStringFromSelector(selector);
    if ([sel rangeOfString:@"set"].location == 0) {
        signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    } else {
        signature = [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
    return signature;
}


- (void)forwardInvocation:(NSInvocation *)invocation{
    id target = invocation.target;
    NSLog(@"target : %@",target);
    SEL sel = invocation.selector;
    NSLog(@"selector : %@",NSStringFromSelector(sel));
    if (!invocation.argumentsRetained) {
        NSLog(@"argument is not retained");
    }
    
    NSString *key = NSStringFromSelector([invocation selector]);
    if ([key rangeOfString:@"set"].location == 0) {
        key = [[key substringWithRange:NSMakeRange(3, [key length]-4)] lowercaseString];
        NSString *obj;
        [invocation getArgument:&obj atIndex:2];
        [_data setObject:obj forKey:key];
    } else {
        NSString *obj = [_data objectForKey:key];
        [invocation setReturnValue:&obj];
    }
}

@end
