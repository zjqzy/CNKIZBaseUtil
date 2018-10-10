//
//  UITabBar+badge.h
//
/*
 
 TabBarItem 设置红点
 
 */

#import <UIKit/UIKit.h>

@interface UITabBar (CNKIZ)


/**
 显示红点

 @param index barItem索引
 */
- (void)showBadgeOnItemIndex:(int)index;


/**
 隐藏红点

 @param index barItem索引
 */
- (void)hideBadgeOnItemIndex:(int)index;

@end
