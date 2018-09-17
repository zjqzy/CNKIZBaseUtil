//
//  UIView+ToImage1.m
//
//  Created by zhujianqi  2013年
//  Copyright (c) 2013年以后 All rights reserved.
//

#import "UIView+ToImage1.h"

@implementation UIView (ToImage1)
- (UIImage *) imageByRenderingView
{
    //uiview 保存图片
    CGFloat oldAlpha = self.alpha;
    self.alpha = 1;
    
    //UIGraphicsBeginImageContext(self.bounds.size);
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 1.0);
    //UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    //UIGraphicsBeginImageContextWithOptions(self.frame.size, self.opaque, [UIScreen mainScreen].scale); //防止模糊 , 导致截图不准
    
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
    
    self.alpha = oldAlpha;
    
	return resultingImage;
    
}
@end

