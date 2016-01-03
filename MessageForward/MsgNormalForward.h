//
//  MsgNormalForward.h
//  MessageForward
//
//  Created by MiaoChao on 15/12/21.
//  Copyright © 2015年 MiaoChao. All rights reserved.
//

#import "ForwardMethodObject.h"

@interface Book : ForwardMethodObject
{
    NSMutableDictionary *_data;
}
@property (retain) NSString *title;
@property (retain) NSString *author;
@end