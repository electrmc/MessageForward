//
//  ForwardMethodObject.m
//  MessageForward
//
//  Created by MiaoChao on 15/12/23.
//  Copyright © 2015年 MiaoChao. All rights reserved.
//

#import "ForwardMethodObject.h"

@implementation ForwardMethodObject

// 实现了动态转发消息后，需要重载此函数让对外接口查找动态实现函数的时候返回YES，保证对外接口的行为统一
// 在这里把要三种形式进行转发的消息都写上
- (BOOL)respondsToSelector:(SEL)aSelector{
    if (@selector(setTitle:) == aSelector ||
        @selector(title) == aSelector ||
        @selector(setAuthor:) == aSelector ||
        @selector(author) == aSelector ||
        @selector(resolveMethodDynamically) == aSelector ||
        @selector(methodInHelper) == aSelector)
    {
        return YES;
    }
    
    return [super respondsToSelector: aSelector];
}

@end
