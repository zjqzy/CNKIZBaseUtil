//
//  UIView+Badge.h
//  CNKInlc
//
//  Created by Xiang Zhang on 2016/11/14.
//  Copyright © 2016年 CNKI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NLCBadgeStyle) {
    NLCBadgeStyleRedDot, // 圆点
    NLCBadgeStyleNumber, // 数字
    NLCBadgeStyleIcon,   // 图标
};

@interface UIView (Badge)

/// badge view
@property (nonatomic, strong, readonly) UILabel *badge;

/// image view
@property (nonatomic, strong, readonly) UIImageView *iconBadge;

/// 字体大小，默认为9个单位size
@property (nonatomic, strong) UIFont *badgeFont;

/// 背景颜色，默认为红色
@property (nonatomic, strong) UIColor *badgeBgColor;

/// 字体颜色，默认为白色
@property (nonatomic, strong) UIColor *badgeTextColor;

/// badge frame
@property (nonatomic, assign) CGRect badgeFrame;

/// 偏移量，默认为{0,0}
@property (nonatomic, assign) CGPoint  badgeCenterOffset;

/// 显示计数，超过最大值，显示"+"号
@property (nonatomic, assign) NSInteger badgeMaximumBadgeNumber;

/// 展示默认圆点badge
- (void)showBadge;

/**
 展示badge
 @param style 样式(数字or圆点)
 @param value 显示计数
 */
- (void)showBadgeWithStyle:(NLCBadgeStyle)style value:(NSInteger)value;

/// 清除badge
- (void)clearBadge;

/// 恢复badge显示
- (void)resumeBadge;

/// 清空图标badge
- (void)clearIconBadge;

/// 显示图标badge
- (void)showIconBadge;

@end
