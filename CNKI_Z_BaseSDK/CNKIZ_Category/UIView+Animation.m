//
//  UIView+Animation.h
//
//  Created by zhujianqi  2013年
//  Copyright (c) 2013年以后 All rights reserved.
//

#import "UIView+Animation.h"


#define kTransitionTime 0.55
#define kFlipTime       0.85


@implementation UIView (Animation)

+ (void)animationReveal:(UIView *)view direction:(NSString *)direction
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:direction];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationFade:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRotateAndScaleDownUp:(UIView *)view
{
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 2];
	rotationAnimation.duration = 0.750f;
	rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
	scaleAnimation.duration = 0.75f;
	scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.duration = 0.75f;
	animationGroup.autoreverses = YES;
	animationGroup.repeatCount = 1;//HUGE_VALF;
	[animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil]];
    
	[view.layer addAnimation:animationGroup forKey:@"animationGroup"];
}


+ (void)animationFlip:(UIView *)view direction:(NSString *)direction
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kFlipTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:direction];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationPush:(UIView *)view direction:(NSString *)direction
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:direction];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCurl:(UIView *)view direction:(NSString *)direction
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"pageCurl"];
    [animation setSubtype:direction];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationUnCurl:(UIView *)view direction:(NSString *)direction
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"pageUnCurl"];
    [animation setSubtype:direction];
    
    [view.layer addAnimation:animation forKey:nil];
}

+(void)animationRotateAndScaleEffects:(UIView *)view
{
    [UIView animateWithDuration:0.75
                     animations:^
     {
         view.transform = CGAffineTransformMakeScale(0.001, 0.001);
         
         CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
         animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.70, 0.40, 0.80) ];//旋转形成一道闪电。
         //animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0) ];//y轴居中对折番。
         //animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 1.0, 0.0, 0.0) ];//沿X轴对折翻转。
         //animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.50, -0.50, 0.50) ];
         //animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.1, 0.2, 0.2) ];
         
         animation.duration = 0.45;
         animation.repeatCount = 1;
         [view.layer addAnimation:animation forKey:nil];
         
     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.75 animations:^
          {
              view.transform = CGAffineTransformMakeScale(1.0, 1.0);
          }
          ];
         
     }
     ];
}


+ (void)animationMove:(UIView *)view direction:(NSString *)direction
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:direction];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCube:(UIView *)view direction:(NSString *)direction
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:direction];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRippleEffect:(UIView *)view WithDuration:(CGFloat)duration
{
    CATransition *animation = [CATransition animation];
    //[animation setDuration:kTransitionTime];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"rippleEffect"];
    [animation setSubtype:kCATransitionFromRight];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCameraEffect:(UIView *)view type:(NSString *)type
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:type];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationSuckEffect:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];//kCAFillModeForwards,kCAFillModeRemoved
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"suckEffect"];
    [animation setSubtype:kCATransitionFromBottom];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationBounceIn:(UIView *)view
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.0001];
    [view setAlpha:0.8];
	[view setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)];
	[UIView commitAnimations];
}

+ (void)animationBounceOut:(UIView *)view
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.73];
//    [UIView setAnimationDelay:0.2];
    [view setAlpha:1.0];
	[view setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)];
	[UIView commitAnimations];
}

+ (void)animationBounce:(UIView *)view
{
    CGRect rect = view.bounds;
    CGPoint center = view.center;
    [view setCenter:CGPointMake(160, 240)];
    [view setFrame:CGRectZero];
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
    [view setAlpha:1.0];
    [view setBounds:rect];
    [view setCenter:center];
	[UIView commitAnimations];
}

+ (void)zoomIn: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait{
    __block BOOL done = wait; //wait =  YES wait to finish animation
    view.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformIdentity;
        //view.transform = CGAffineTransformMakeScale(0, 0);
        //view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        done = NO;
    }];
    // wait for animation to finish
    while (done == YES)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}
+ (void)buttonPressAnimate: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait{
    //Usually Changes the position
    __block BOOL done = wait; //wait =  YES wait to finish animation
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformMakeScale(1.05, 1.05);
        view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        done = NO;
    }];
    // wait for animation to finish
    while (done == YES)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}

+ (void)fadeIn: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait{
    __block BOOL done = wait; //wait =  YES wait to finish animation
    [view setAlpha:0.0];
    [UIView animateWithDuration:duration animations:^{
        [view setAlpha:1.0];
    } completion:^(BOOL finished) {
        done = NO;
    }];
    // wait for animation to finish
    while (done == YES)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}
+ (void)fadeOut: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait{
    __block BOOL done = wait; //wait =  YES wait to finish animation
    [view setAlpha:1.0];
    [UIView animateWithDuration:duration animations:^{
        [view setAlpha:0.0];
    } completion:^(BOOL finished) {
        done = NO;
    }];
    // wait for animation to finish
    while (done == YES)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}
+ (void) moveLeft: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length{
    __block BOOL done = wait; //wait =  YES wait to finish animation
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x - length, view.center.y);
        
    } completion:^(BOOL finished) {
        done = NO;
    }];
    // wait for animation to finish
    while (done == YES)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}

+ (void) moveRight: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length{
    __block BOOL done = wait; //wait =  YES wait to finish animation
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x + length, view.center.y);
        
    } completion:^(BOOL finished) {
        done = NO;
    }];
    // wait for animation to finish
    while (done == YES)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}

+ (void) moveUp: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length{
    __block BOOL done = wait; //wait =  YES wait to finish animation
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x, view.center.y-length);
        
    } completion:^(BOOL finished) {
        done = NO;
    }];
    // wait for animation to finish
    while (done == YES)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}

+ (void) moveDown: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length{
    __block BOOL done = wait; //wait =  YES wait to finish animation
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x, view.center.y + length);
        
    } completion:^(BOOL finished) {
        done = NO;
    }];
    // wait for animation to finish
    while (done == YES)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}

+ (void) rotate: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andAngle:(int) angle{
    __block BOOL done = wait; //wait =  YES wait to finish animation
    [UIView animateWithDuration:duration animations:^{
       
        view.transform = CGAffineTransformMakeRotation(1.0 * angle * M_PI / 180.0f);
    } completion:^(BOOL finished) {
        done = NO;
    }];
    // wait for animation to finish
    while (done == YES)
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}
@end
