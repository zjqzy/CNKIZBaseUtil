//
//  UIView+Animations.h
//  TwoTask
//
//  Created by M B. Bitar on 12/21/12.
//  Copyright (c) 2012 progenius, inc. All rights reserved.
//

/*

 uiview 动画  比 #import "UIView+Animation.h" 好
 
 
 */


#import <UIKit/UIKit.h>

@interface UIView (Animations)

-(void)addPulsingAnimation;     //不停的 放大缩小
-(BOOL)hasPulseAnimation;
-(void)removePulseAnimation;

-(void)addShakeAnimation;       //不停的 左右晃动
-(BOOL)hasShakeAnimation;
-(void)removeShakeAnimation;

-(void)animationPop;            //放大再缩回， uibutton的效果不错
-(void)addRippleEffectAnimationWithDuration:(CGFloat)duration;  //水波纹效果

-(void)addFadingAnimation;
-(void)addFadingAnimationWithDuration:(CGFloat)duration;

-(void)addDefaultBorderAndShadow;   //加默认边框和阴影
-(void)addRoundedCorners:(CGFloat)radius;   //加圆角
-(void)shadowOnViewWithShadowType:(NSString *)shadowType;   //根据类型添加阴影

// other
-(void)centerViewsVerticallyWithin:(NSArray*)views;
-(void)resignFirstRespondersForSubviews;
@end
