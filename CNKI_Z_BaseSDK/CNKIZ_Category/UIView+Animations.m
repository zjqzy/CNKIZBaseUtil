//
//  UIView+Animations.m
//  TwoTask
//
//  Created by M B. Bitar on 12/21/12.
//  Copyright (c) 2012 progenius, inc. All rights reserved.
//

#import "UIView+Animations.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Animations)

-(void)addPulsingAnimation;
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(1.0, 1.0, 1.0);
    CATransform3D scale2 = CATransform3DMakeScale(1.15, 1.15, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.8, 0.8, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    animation.autoreverses = YES;
    animation.repeatCount = MAXFLOAT;
    animation.duration = 0.6;
    
    [self.layer addAnimation:animation forKey:@"pulse"];
}

-(BOOL)hasPulseAnimation
{
    if([self.layer.animationKeys containsObject:@"pulse"])
        return YES;
    return NO;
}

-(void)removePulseAnimation
{
    [self.layer removeAnimationForKey:@"pulse"];
}

-(void)addShakeAnimation
{
    CGFloat rotation = 0.05;
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.13;
    shake.autoreverses = YES;
    shake.repeatCount  = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
    
    [self.layer addAnimation:shake forKey:@"shake"];
}
-(BOOL)hasShakeAnimation
{
    if([self.layer.animationKeys containsObject:@"shake"])
        return YES;
    return NO;
}
-(void)removeShakeAnimation
{
    [self.layer removeAnimationForKey:@"shake"];
}

-(void)animationPop;
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(1.0, 1.0, 1.0);
    CATransform3D scale2 = CATransform3DMakeScale(1.35, 1.35, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.8, 0.8, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    animation.duration = 0.4;
    
    [self.layer addAnimation:animation forKey:@"popup"];
}

-(void)addRippleEffectAnimationWithDuration:(CGFloat)duration
{
    //水波纹效果
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"rippleEffect"];
    [animation setSubtype:kCATransitionFromRight];
    
    [self.layer addAnimation:animation forKey:nil];
}

-(void)addFadingAnimation
{
    [self addFadingAnimationWithDuration:0.5];
}
-(void)addFadingAnimationWithDuration:(CGFloat)duration
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromBottom;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fillMode = @"extended";
    animation.removedOnCompletion = YES;
    [self.layer addAnimation:animation forKey:@"reloadAnimation"];
}

-(void)addDefaultBorderAndShadow
{
    //加默认边框和阴影
    //Shadow is all Over with a white frame
    CALayer *layer = self.layer;
    [layer setBorderColor: [[UIColor whiteColor] CGColor]]; //Frame Color
    [layer setBorderWidth:5.0f]; //Frame Border
    [layer setShadowColor: [[UIColor blackColor] CGColor]]; //Shadow Color
    [layer setShadowOpacity:0.80f];
    [layer setShadowOffset: CGSizeMake(1, 3)];
    [layer setShadowRadius:5.0];
    [self setClipsToBounds:NO];
}
-(void)addRoundedCorners:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

-(void)shadowOnViewWithShadowType:(NSString *)shadowType
{
    CGSize size = self.bounds.size;
    
    if ([shadowType isEqualToString:@"NoShadow"]){
        self.layer.shadowColor = [UIColor clearColor].CGColor;
    }
    else{
        self.layer.shadowColor = [UIColor blackColor].CGColor;
    }
    
    self.layer.shadowOpacity = 0.7f;
    self.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
    self.layer.shadowRadius = 5.0f;
    self.layer.masksToBounds = NO;
    
    if ([shadowType isEqualToString:@"Trapezoidal"])
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(size.width * 0.33f, size.height * 0.66f)];
        [path addLineToPoint:CGPointMake(size.width * 0.66f, size.height * 0.66f)];
        [path addLineToPoint:CGPointMake(size.width * 1.15f, size.height * 1.15f)];
        [path addLineToPoint:CGPointMake(size.width * -0.15f, size.height * 1.15f)];
        self.layer.shadowPath = path.CGPath;
        
    }
    else if ([shadowType isEqualToString:@"Elliptical"])
    {
        CGRect ovalRect = CGRectMake(0.0f, size.height + 5, size.width - 10, 15);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
        self.layer.shadowPath = path.CGPath;
    }
    //Curl is not working !!
    else if ([shadowType isEqualToString:@"Curl"])
    {
        CGFloat offset = 10.0;
        CGFloat curve = 5.0;
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGRect rect = self.bounds;
        CGPoint topLeft		 = rect.origin;
        CGPoint bottomLeft	 = CGPointMake(0.0, CGRectGetHeight(rect)+offset);
        CGPoint bottomMiddle = CGPointMake(CGRectGetWidth(rect)/2, CGRectGetHeight(rect)-curve);
        CGPoint bottomRight	 = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect)+offset);
        CGPoint topRight	 = CGPointMake(CGRectGetWidth(rect), 0.0);
        
        [path moveToPoint:topLeft];
        [path addLineToPoint:bottomLeft];
        [path addQuadCurveToPoint:bottomRight
                     controlPoint:bottomMiddle];
        [path addLineToPoint:topRight];
        [path addLineToPoint:topLeft];
        [path closePath];
        self.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
        self.layer.borderWidth = 5.0;
        self.layer.shadowOffset = CGSizeMake(0, 3);
        self.layer.shadowOpacity = 0.7;
        self.layer.shouldRasterize = YES;
        self.layer.shadowPath = path.CGPath;
        
    }

}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#pragma mark --
#pragma mark Other

/* centers the views in the array with respect to self and given offset */
/* views is an array of dictionarys with keys "view" "offset" */
-(void)centerViewsVerticallyWithin:(NSArray*)views
{
    /* calculate y origin of first view */
    float heightOfAllViews = 0;
    
    for(NSDictionary *dic in views) {
        UIView *view = [dic objectForKey:@"view"];
        
        heightOfAllViews += view.bounds.size.height;
    }
    
    float yOriginOfFirstView = self.bounds.size.height/2.0 - heightOfAllViews/2.0 + self.frame.origin.y;
    float currentYOrigin = yOriginOfFirstView;
    
    for(NSDictionary *dic in views) {
        UIView *view = [dic objectForKey:@"view"];
        float offset = [[dic objectForKey:@"offset"] floatValue];
        CGRect rect = view.frame;
        rect.origin = CGPointMake(rect.origin.x, currentYOrigin + offset);
        view.frame = rect;
        currentYOrigin += rect.size.height + offset;
    }
}

// wrapper
-(void)resignFirstRespondersForSubviews
{
    [self resignFirstRespondersForView:self];
}

// helper
-(void)resignFirstRespondersForView:(UIView*)view
{
    for (UIView *subview in [view subviews])
    {
        if ([subview isKindOfClass:[UITextField class]] || [subview isKindOfClass:[UITextView class]]) {
            [(id)subview resignFirstResponder];
        }
        [self resignFirstRespondersForView:subview];
    }
}

@end
