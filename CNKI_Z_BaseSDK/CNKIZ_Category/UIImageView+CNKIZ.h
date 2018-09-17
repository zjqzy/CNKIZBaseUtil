//
//  UIImageView+CNKIZ.h
//
//  Created by zhu jianqi on 2018/9/20.
//  Copyright © 2018年 zhu jianqi. All rights reserved.
//  Email : zhu.jian.qi@163.com

#import <UIKit/UIKit.h>

@interface UIImageView (CNKIZ)

//Ask the image to perform an "Aspect Fill" but centering the image to the detected faces
//Not the simple center of the image
- (void) faceAwareFill;

@end


/*
 举例
 [faceImageView faceAwareFill];
 
 */
