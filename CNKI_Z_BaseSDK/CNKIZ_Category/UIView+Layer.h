//
//  UIView+Layer.h
//
//  Created by zhujianqi  2013年
//  Copyright (c) 2013年以后 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layer)

/**
 *  产生一个Image的倒影，并把这个倒影图片加在一个View上面。
 *  @param  image:被倒影的原图。
 *  @param  frame:盖在上面的图。
 *  @param  opacity:倒影的透明度，0为完全透明，即倒影不可见;1为完全不透明。
 *  @param  view:倒影加载在上面。
 *  return  产生倒影后的View。
 */
+ (UIView *)reflectImage:(UIImage *)image withFrame:(CGRect)frame opacity:(CGFloat)opacity atView:(UIView *)view;


// set round corner
- (void) setCornerRadius : (CGFloat) radius;
// set inner border
- (void) setBorder : (UIColor *) color width : (CGFloat) width;
// set the shadow
// Example: [view setShadow:[UIColor blackColor] opacity:0.5 offset:CGSizeMake(1.0, 1.0) blueRadius:3.0];
- (void) setShadow : (UIColor *)color opacity:(CGFloat)opacity offset:(CGSize) offset blurRadius:(CGFloat)blurRadius;

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size;

@end
