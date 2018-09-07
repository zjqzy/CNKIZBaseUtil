//
//  UIView+Animation.h
//
//  Created by zhujianqi  2013年
//  Copyright (c) 2013年以后 All rights reserved.
//
/*
 
 uiview 动画  比 #import "UIView+Animatio.h" 不好
 
 
 */

/**
 *  direction取值:kCATransitionFromTop  kCATransitionFromBottom
 *               kCATransitionFromLeft kCATransitionFromRight
 */

#define kCameraEffectOpen  @"cameraIrisHollowOpen"
#define kCameraEffectClose @"cameraIrisHollowClose"


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Animation)

//揭开
+ (void)animationReveal:(UIView *)view direction:(NSString *)direction;

//渐隐渐消
+ (void)animationFade:(UIView *)view;

//翻转
+ (void)animationFlip:(UIView *)view direction:(NSString *)direction;

//旋转缩放
+ (void)animationRotateAndScaleEffects:(UIView *)view;//各种旋转缩放效果。
+ (void)animationRotateAndScaleDownUp:(UIView *)view;//旋转同时缩小放大效果

//push
+ (void)animationPush:(UIView *)view direction:(NSString *)direction;

//Curl UnCurl
+ (void)animationCurl:(UIView *)view direction:(NSString *)direction;
+ (void)animationUnCurl:(UIView *)view direction:(NSString *)direction;

//Move
+ (void)animationMove:(UIView *)view direction:(NSString *)direction;

//立方体
+ (void)animationCube:(UIView *)view direction:(NSString *)direction;

//水波纹
+ (void)animationRippleEffect:(UIView *)view WithDuration:(CGFloat)duration;

//相机开合
+ (void)animationCameraEffect:(UIView *)view type:(NSString *)type;

//吸收
+ (void)animationSuckEffect:(UIView *)view;

+ (void)animationBounceOut:(UIView *)view;
+ (void)animationBounceIn:(UIView *)view;
+ (void)animationBounce:(UIView *)view;

+ (void) moveDown: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length;

@end
