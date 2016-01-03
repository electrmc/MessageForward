//
//  MsgFastForward.m
//  MessageForward
//
//  Created by MiaoChao on 15/12/20.
//  Copyright © 2015年 MiaoChao. All rights reserved.
//

#import "MsgFastForward.h"
#import <objc/runtime.h>

@interface Helper : NSObject @end

@implementation Helper

- (void)methodInHelper{
    NSLog(@"%s",__func__);
}
@end

@implementation MsgFastForward

// 将消息转出某对象
// 由该对象进行处理方法
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"%s",__func__);
    
    Helper *helper = [[Helper alloc] init];
    if ([helper respondsToSelector: aSelector]) {
        // 能进入此处也说明，既是是私有方法，也能响应
        return helper;
    }
    
    return [super forwardingTargetForSelector: aSelector];
}
@end
