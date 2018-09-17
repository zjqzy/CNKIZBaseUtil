//
//  NSInvocation+SimpleCreation.h
//
//  Created by zhu jianqi on 2018/9/20.
//  Copyright © 2018年 zhu jianqi. All rights reserved.
//  Email : zhu.jian.qi@163.com

#import <Foundation/Foundation.h>

@interface NSInvocation (CNKIZ)

+ (NSInvocation*)invocationWithTarget:(id)target andSelector:(SEL)selector;
+ (NSInvocation*)invocationWithTarget:(id)target selector:(SEL)selector andArguments:(NSArray*)arguments;

@end
