//
//  MsgForwardManager.m
//  MessageForward
//
//  Created by MiaoChao on 15/12/20.
//  Copyright © 2015年 MiaoChao. All rights reserved.
//

#import "MsgDynamicForward.h"
#import <objc/runtime.h>

@implementation MsgDynamicForward

// ------------------------动态方法解析------------------------
//全局函数
void dynamicMethodIMP(id self, SEL _cmd){
    // implementation ....
    NSLog(@"%s",__func__);
}

// 在这里可以给类添加方法，当它返回YES时，那么runtime会再去类里寻找方法实现
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(resolveMethodDynamically))
    {
        class_addMethod([self class], sel, (IMP) dynamicMethodIMP, "v@:");
        return NO;//苹果官方说返回YES时才会寻找实现，但是经测试，返回NO时也会寻找实现函数
    }
    return [super resolveInstanceMethod:sel];
}

// 如果是调用的类方法，则在这里添加
+ (BOOL)resolveClassMethod:(SEL)sel{
    if (sel == @selector(resolveMethodDynamically))
    {
        class_addMethod([self class], sel, (IMP) dynamicMethodIMP, "v@:");
        return NO;//苹果官方说返回YES时才会寻找实现，但是经测试，返回NO时也会寻找实现函数
    }
    return [super resolveInstanceMethod:sel];
}

@end
