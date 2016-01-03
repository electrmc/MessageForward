//
//  main.m
//  MessageForward
//
//  Created by MiaoChao on 15/12/20.
//  Copyright © 2015年 MiaoChao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgDynamicForward.h"
#import "MsgFastForward.h"
#import "MsgNormalForward.h"

// 当问题遇到困难时，首先尝试自己内部解决，之后尝试借助外力解决，最后，把这件事交给外部解决。
// messageForward也是遵循这三步：动态方法解析，快速消息转发，标准消息转发
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 动态方法解析
        id msgForward = [[MsgDynamicForward alloc]init];
        [msgForward performSelector:@selector(resolveMethodDynamically)];
        
        // 快速消息转发
        id msgFastForward = [[MsgFastForward alloc]init];
        [msgFastForward performSelector:@selector(methodInHelper)];
        
        // 标准消息转发
        Book *book = [[Book alloc] init];
        printf("%s is written by %s\n", [book.title UTF8String], [book.author UTF8String]);
        book.title = @"1984";
        book.author = @"George Orwell";
        printf("%s is written by %s\n", [book.title UTF8String], [book.author UTF8String]);
        
    }
    return 0;
}
