//
//  UIView+CNKIZ.h
//
//  Created by zhu jianqi on 2018/9/20.
//  Copyright © 2018年 zhu jianqi. All rights reserved.
//  Email : zhu.jian.qi@163.com

/*

 uiview 动画  比 #import "UIView+Animation.h" 好
 
 
 */


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NLCBadgeStyle) {
    NLCBadgeStyleRedDot, // 圆点
    NLCBadgeStyleNumber, // 数字
    NLCBadgeStyleIcon,   // 图标
};

@interface UIView (CNKIZ)


/**
 *  返回UIView及其子类的位置和尺寸。分别为左、右边界在X轴方向上的距离，上、下边界在Y轴上的距离，View的宽和高。
 */

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@property(nonatomic) CGSize  size;
@property(nonatomic) CGPoint orgin;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/////////////////////////////////////////
///////////  动画  //////////////////////
/////////////////////////////////////////

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

- (UIImage*)imageByRenderingView;


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

/////////////////////////////////////////
///////////  层  //////////////////////
/////////////////////////////////////////

/**
 *  产生一个Image的倒影，并把这个倒影图片加在一个View上面。
 *  @param  image 被倒影的原图。
 *  @param  frame 盖在上面的图。
 *  @param  opacity 倒影的透明度，0为完全透明，即倒影不可见;1为完全不透明。
 *  @param  view 倒影加载在上面。
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

/////////////////////////////////////////
///////////  border  ///////////////
/////////////////////////////////////////

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

/////////////////////////////////////////
///////////  Badge  ///////////////
/////////////////////////////////////////

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
