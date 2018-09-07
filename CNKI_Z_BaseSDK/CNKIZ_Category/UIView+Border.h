//
//  UIView+ZXExt.h
//  ZXViewBorder
//
//  Created by Xiang Zhang on 2015/9/26.
//  Copyright © 2015年 Xiang Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Border)

/// MARK: Top Border

- (void)addTopBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;
- (void)addViewBackedTopBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;

/// MARK: Top Border + Offsets

- (void)addTopBorderWithHeight:(CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset;
- (void)addViewBackedTopBorderWithHeight:(CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset;

/// MARK: Right Border

- (void)addRightBorderWithWidth:(CGFloat)width andColor:(UIColor*)color;
- (void)addViewBackedRightBorderWithWidth:(CGFloat)width andColor:(UIColor*)color;

/// MARK: Right Border + Offsets

- (void)addRightBorderWithWidth:(CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
- (void)addViewBackedRightBorderWithWidth:(CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;

/// MARK: Bottom Border

- (void)addBottomBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;
- (void)addViewBackedBottomBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;

/// MARK: Bottom Border + Offsets

- (void)addBottomBorderWithHeight:(CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset;
- (void)addViewBackedBottomBorderWithHeight:(CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset;

/// MARK: Left Border

- (void)addLeftBorderWithWidth:(CGFloat)width andColor:(UIColor*)color;
- (void)addViewBackedLeftBorderWithWidth:(CGFloat)width andColor:(UIColor*)color;

/// MARK: Left Border + Offsets

- (void)addLeftBorderWithWidth:(CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;
- (void)addViewBackedLeftBorderWithWidth:(CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;

@end
