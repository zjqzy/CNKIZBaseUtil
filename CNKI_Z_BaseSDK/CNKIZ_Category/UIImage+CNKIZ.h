//
//  UIImage+CNKIZ.h
//
//  Created by zhu jianqi on 2018/9/20.
//  Copyright © 2018年 zhu jianqi. All rights reserved.
//  Email : zhu.jian.qi@163.com

#import <UIKit/UIKit.h>

@interface UIImage (CNKIZ)

typedef enum {
    MGImageResizeCrop,	// analogous to UIViewContentModeScaleAspectFill, i.e. "best fit" with no space around.
    MGImageResizeCropStart,
    MGImageResizeCropEnd,
    MGImageResizeScale	// analogous to UIViewContentModeScaleAspectFit, i.e. scale down to fit, leaving space around if necessary.
} MGImageResizingMethod;

//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

- (UIImage *)imageTintedWithColor:(UIColor *)color;     //一个黑心圆， 如果传 red，则效果为 红心圆，是填充整个圆
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

- (UIImage *)imageToFitSize:(CGSize)size method:(MGImageResizingMethod)resizeMethod;
- (UIImage *)imageCroppedToFitSize:(CGSize)size; // uses MGImageResizeCrop
- (UIImage *)imageScaledToFitSize:(CGSize)size; // uses MGImageResizeScale


//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////


//反射
- (UIImage *)reflectionWithHeight:(int)height;
- (UIImage *)reflectionWithAlpha:(float)pcnt;
- (UIImage *)reflectionRotatedWithAlpha:(float)pcnt;

//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

/**
 *  抓取屏幕。
 *  @param  scale 屏幕放大倍数，1为原尺寸。
 *  return  屏幕后的Image。
 */
+ (UIImage *)grabScreenWithScale:(CGFloat)scale;

/**
 *  抓取UIView及其子类。
 *  @param  view UIView及其子类。
 *  @param  scale 屏幕放大倍数，1为原尺寸。
 *  return  抓取图片后的Image。
 */
+ (UIImage *)grabImageWithView:(UIView *)view scale:(CGFloat)scale;

/**
 *  合并两个Image。
 *  @param  image1 图片1。
 *  @param  image2 图片2。
 *  @param  frame1 位置1。
 *  @param  frame2 位置2。
 *  @param  size 返回图片的尺寸。
 *  return  合并后的两个图片的Image。
 */
+ (UIImage *)mergeWithImage1:(UIImage *)image1 image2:(UIImage *)image2 frame1:(CGRect)frame1 frame2:(CGRect)frame2 size:(CGSize)size;

/**
 *  把一个Image盖在另一个Image上面。
 *  @param  image  底图。
 *  @param  mask 盖在上面的图。
 *  return  Image。
 */
+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)mask;

/**
 *  把一个Image尺寸缩放到另一个尺寸。
 *  @param  image  原图。
 *  @param  size  目标尺寸。
 *  return  尺寸更改后的Image。
 */
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size;



/**
 *  改变一个Image的色彩。
 *  @param  image 被改变的Image。
 *  @param  color  要改变的目标色彩。
 *  return  色彩更改后的Image。
 */
+(UIImage *)colorizeImage:(UIImage *)image withColor:(UIColor *)color;

//按frame裁减图片
+ (UIImage *)captureView:(UIView *)view frame:(CGRect)frame;

/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////

//截取
- (UIImage *)imageAtRect:(CGRect)rect; 

//缩放
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

//旋转
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

//反面
- (UIImage *)imageOpposite;

//分2份
+(NSArray*)splitImageIntoTwoParts:(UIImage*)image;
/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
//颜色图
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level;

+ (UIImage *)z_imageWithColor:(UIColor *)color;
+ (UIImage *)z_imageWithColor:(UIColor *)color size:(CGSize)size;

@end
