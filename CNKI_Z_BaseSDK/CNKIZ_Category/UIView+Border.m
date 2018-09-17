//
//  UIView+ZXExt.h
//  ZXViewBorder
//
//  Created by Xiang Zhang on 2015/9/26.
//  Copyright © 2015年 Xiang Zhang. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

#pragma mark - Top

- (void)addTopBorderWithHeight:(CGFloat)height andColor:(UIColor*)color
{
    [self addTopBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andTopOffset:0];
}

- (void)addViewBackedTopBorderWithHeight:(CGFloat)height andColor:(UIColor*)color
{
    [self addViewBackedTopBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andTopOffset:0];
}

#pragma mark - Top + Offset

- (UIView*)createViewBackedTopBorderWithHeight:(CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset
{
    UIView *border = [self getViewBackedOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, 0 + topOffset, self.frame.size.width - leftOffset - rightOffset, height) andColor:color];
    border.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    return border;
}

- (void)addTopBorderWithHeight:(CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset
{
    [self addOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, 0 + topOffset, self.frame.size.width - leftOffset - rightOffset, height) andColor:color];
}

- (void)addViewBackedTopBorderWithHeight:(CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset
{
    UIView *border = [self createViewBackedTopBorderWithHeight:height color:color leftOffset:leftOffset rightOffset:rightOffset andTopOffset:topOffset];
    [self addSubview:border];
}

#pragma mark - Right

- (void)addRightBorderWithWidth:(CGFloat)width andColor:(UIColor*)color
{
    [self addRightBorderWithWidth:width color:color rightOffset:0 topOffset:0 andBottomOffset:0];
}

- (void)addViewBackedRightBorderWithWidth:(CGFloat)width andColor:(UIColor*)color
{
    [self addViewBackedRightBorderWithWidth:width color:color rightOffset:0 topOffset:0 andBottomOffset:0];
}

#pragma mark - Right + Offset

- (UIView*)createViewBackedRightBorderWithWidth:(CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset
{
    UIView *border = [self getViewBackedOneSidedBorderWithFrame:CGRectMake(self.frame.size.width - width - rightOffset, 0 + topOffset, width, self.frame.size.height - topOffset - bottomOffset) andColor:color];
    border.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    return border;
}

- (void)addRightBorderWithWidth:(CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset
{
    [self addOneSidedBorderWithFrame:CGRectMake(self.frame.size.width - width - rightOffset, 0 + topOffset, width, self.frame.size.height - topOffset - bottomOffset) andColor:color];
}

- (void)addViewBackedRightBorderWithWidth:(CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset
{
    UIView *border = [self createViewBackedRightBorderWithWidth:width color:color rightOffset:rightOffset topOffset:topOffset andBottomOffset:bottomOffset];
    [self addSubview:border];
}

#pragma mark - Bottom

- (void)addBottomBorderWithHeight:(CGFloat)height andColor:(UIColor*)color
{
    [self addBottomBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andBottomOffset:0];
}

- (void)addViewBackedBottomBorderWithHeight:(CGFloat)height andColor:(UIColor*)color
{
    [self addViewBackedBottomBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andBottomOffset:0];
}

#pragma mark - Bottom + Offset

- (UIView*)createViewBackedBottomBorderWithHeight:(CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset
{
    UIView *border = [self getViewBackedOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, self.frame.size.height - height - bottomOffset, self.frame.size.width - leftOffset - rightOffset, height) andColor:color];
    border.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    return border;
}

- (void)addBottomBorderWithHeight:(CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset
{
    [self addOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, self.frame.size.height - height - bottomOffset, self.frame.size.width - leftOffset - rightOffset, height) andColor:color];
}

- (void)addViewBackedBottomBorderWithHeight:(CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset
{
    UIView *border = [self createViewBackedBottomBorderWithHeight:height color:color leftOffset:leftOffset rightOffset:rightOffset andBottomOffset:bottomOffset];
    [self addSubview:border];
}

#pragma mark - Left

- (void)addLeftBorderWithWidth:(CGFloat)width andColor:(UIColor*)color
{
    [self addLeftBorderWithWidth:width color:color leftOffset:0 topOffset:0 andBottomOffset:0];
}

- (void)addViewBackedLeftBorderWithWidth:(CGFloat)width andColor:(UIColor*)color
{
    [self addViewBackedLeftBorderWithWidth:width color:color leftOffset:0 topOffset:0 andBottomOffset:0];
}

#pragma mark - Left + Offset

- (UIView*)createViewBackedLeftBorderWithWidth:(CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset
{
    UIView *border = [self getViewBackedOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, 0 + topOffset, width, self.frame.size.height - topOffset - bottomOffset) andColor:color];
    border.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return border;
}

- (void)addLeftBorderWithWidth:(CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset
{
    [self addOneSidedBorderWithFrame:CGRectMake(0 + leftOffset, 0 + topOffset, width, self.frame.size.height - topOffset - bottomOffset) andColor:color];
}

- (void)addViewBackedLeftBorderWithWidth:(CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset
{
    UIView *border = [self createViewBackedLeftBorderWithWidth:width color:color leftOffset:leftOffset topOffset:topOffset andBottomOffset:bottomOffset];
    [self addSubview:border];
}

#pragma mark - Private Mtd

- (void)addOneSidedBorderWithFrame:(CGRect)frame andColor:(UIColor*)color
{
    CALayer *border = [CALayer layer];
    border.frame = frame;
    border.backgroundColor = color.CGColor;
    [self.layer addSublayer:border];
}

- (UIView*)getViewBackedOneSidedBorderWithFrame:(CGRect)frame andColor:(UIColor*)color
{
    UIView *border = [[UIView alloc]initWithFrame:frame];
    border.backgroundColor = color;
    return border;
}

@end
