//
//  UIView+CNKIZ.m
//

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#import "UIView+CNKIZ.h"

#define kCameraEffectOpen  @"cameraIrisHollowOpen"
#define kCameraEffectClose @"cameraIrisHollowClose"
#define kTransitionTime 0.55
#define kFlipTime       0.85

#define DEGREES_TO_RADIANS(d)   (d * M_PI / 180)


//////////////////////////////
////////   badge   //////////
//////////////////////////////
static char badgeLabelKey;
static char badgeImageViewKey;
static char badgeBgColorKey;
static char badgeFontKey;
static char badgeTextColorKey;
static char badgeFrameKey;
static char badgeCenterOffsetKey;
static char badgeMaximumBadgeNumberKey;

#define kNLCBadgeDefaultFont ([UIFont boldSystemFontOfSize:9])
static NSInteger const kNLCBadgeDefaultMaximumBadgeNumber = 99;

//////////////////////////////
//////////////////////////////

@implementation UIView (CNKIZ)

////////////////////////////////////////////////
///////////    属性     /////////////
////////////////////////////////////////////////
#pragma mark - 属性
- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize )size{
    CGRect frame =self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (CGPoint)orgin{
    return self.frame.origin;
}
- (void)setOrgin:(CGPoint)orgin{
    CGRect frame = self.frame;
    frame.origin = orgin;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

////////////////////////////////////////////////
///////////    动画     /////////////
////////////////////////////////////////////////
#pragma mark - 动画
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
////////////////////////////////////////////////
///////////    层     /////////////
////////////////////////////////////////////////
#pragma mark - 层
+ (UIView *)reflectImage:(UIImage *)image withFrame:(CGRect)frame opacity:(CGFloat)opacity atView:(UIView *)view
{
    // Image Layer
    CALayer *imageLayer = [CALayer layer];
    imageLayer.contents = (id)image.CGImage;
    imageLayer.frame = frame;
    //    imageLayer.borderColor = [UIColor darkGrayColor].CGColor;
    //    imageLayer.borderWidth = 6.0;
    [view.layer addSublayer:imageLayer];
    
    // Reflection Layer
    CALayer *reflectionLayer = [CALayer layer];
    reflectionLayer.contents = imageLayer.contents;
    reflectionLayer.frame = CGRectMake(imageLayer.frame.origin.x, imageLayer.frame.origin.y + imageLayer.frame.size.height, imageLayer.frame.size.width, imageLayer.frame.size.height);
    //    reflectionLayer.borderColor = imageLayer.borderColor;
    //    reflectionLayer.borderWidth = imageLayer.borderWidth;
    reflectionLayer.opacity = opacity;
    // Transform X by 180 degrees
    [reflectionLayer setValue:[NSNumber numberWithFloat:DEGREES_TO_RADIANS(180)] forKeyPath:@"transform.rotation.x"];
    
    // Gradient Layer - Use as mask
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = reflectionLayer.bounds;
    gradientLayer.position = CGPointMake(reflectionLayer.bounds.size.width / 2, reflectionLayer.bounds.size.height * 0.5);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor],(id)[[UIColor whiteColor] CGColor], nil];
    gradientLayer.startPoint = CGPointMake(0.5, 0.6);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    
    // Add gradient layer as a mask
    reflectionLayer.mask = gradientLayer;
    [view.layer addSublayer:reflectionLayer];
    
    return view;
}

/* simple setting using the layer */
- (void) setCornerRadius : (CGFloat) radius {
    self.layer.cornerRadius = radius;
}

- (void) setBorder : (UIColor *) color width : (CGFloat) width  {
    self.layer.borderColor = [color CGColor];
    self.layer.borderWidth = width;
}

- (void) setShadow : (UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset blurRadius:(CGFloat)blurRadius {
    CALayer *l = self.layer;
    l.shadowColor = [color CGColor];
    l.shadowOpacity = opacity;
    l.shadowOffset = offset;
    l.shadowRadius = blurRadius;
}

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size
{
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    
    CAShapeLayer* maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    
    self.layer.mask = maskLayer;
    
}

////////////////////////////////////////////////
///////////    border     /////////////
////////////////////////////////////////////////
#pragma mark - border

- (void)addTopBorderWithHeight:(CGFloat)height andColor:(UIColor*)color
{
    [self addTopBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andTopOffset:0];
}

- (void)addViewBackedTopBorderWithHeight:(CGFloat)height andColor:(UIColor*)color
{
    [self addViewBackedTopBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andTopOffset:0];
}
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
- (void)addRightBorderWithWidth:(CGFloat)width andColor:(UIColor*)color
{
    [self addRightBorderWithWidth:width color:color rightOffset:0 topOffset:0 andBottomOffset:0];
}

- (void)addViewBackedRightBorderWithWidth:(CGFloat)width andColor:(UIColor*)color
{
    [self addViewBackedRightBorderWithWidth:width color:color rightOffset:0 topOffset:0 andBottomOffset:0];
}
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
- (void)addBottomBorderWithHeight:(CGFloat)height andColor:(UIColor*)color
{
    [self addBottomBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andBottomOffset:0];
}

- (void)addViewBackedBottomBorderWithHeight:(CGFloat)height andColor:(UIColor*)color
{
    [self addViewBackedBottomBorderWithHeight:height color:color leftOffset:0 rightOffset:0 andBottomOffset:0];
}
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
- (void)addLeftBorderWithWidth:(CGFloat)width andColor:(UIColor*)color
{
    [self addLeftBorderWithWidth:width color:color leftOffset:0 topOffset:0 andBottomOffset:0];
}

- (void)addViewBackedLeftBorderWithWidth:(CGFloat)width andColor:(UIColor*)color
{
    [self addViewBackedLeftBorderWithWidth:width color:color leftOffset:0 topOffset:0 andBottomOffset:0];
}
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

/////////////////////////////////////////
///////////  Badge  ///////////////
/////////////////////////////////////////
#pragma mark - Badge

- (void)showBadge
{
    [self showBadgeWithStyle:NLCBadgeStyleRedDot value:0];
}

- (void)showBadgeWithStyle:(NLCBadgeStyle)style value:(NSInteger)value
{
    switch (style) {
        case NLCBadgeStyleRedDot:
            [self showRedDotBadge];
            break;
        case NLCBadgeStyleNumber:
            [self showNumberBadgeWithValue:value];
            break;
        case NLCBadgeStyleIcon:
            [self showIconBadge];
        default:
            break;
    }
}

- (void)clearBadge
{
    self.badge.hidden = YES;
}

- (void)resumeBadge
{
    if (self.badge && self.badge.hidden == YES) {
        self.badge.hidden = NO;
    }
}

- (void)clearIconBadge
{
    self.iconBadge.hidden = YES;
}

- (void)showRedDotBadge
{
    [self badgeInit];
    if (self.badge.tag != NLCBadgeStyleRedDot) {
        self.badge.text = @"";
        self.badge.tag = NLCBadgeStyleRedDot;
        self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame) / 2;
    }
    self.badge.hidden = NO;
}

- (void)showNumberBadgeWithValue:(NSInteger)value
{
    if (value < 0) {
        return;
    }
    
    [self badgeInit];
    self.badge.hidden = (value == 0);
    self.badge.tag = NLCBadgeStyleNumber;
    self.badge.font = self.badgeFont;
    self.badge.text = (value > self.badgeMaximumBadgeNumber ?
                       [NSString stringWithFormat:@"%@+", @(self.badgeMaximumBadgeNumber)] :
                       [NSString stringWithFormat:@"%@", @(value)]);
    [self adjustLabelWidth:self.badge];
    CGRect frame = self.badge.frame;
    frame.size.width += 4;
    frame.size.height += 4;
    if(CGRectGetWidth(frame) < CGRectGetHeight(frame)) {
        frame.size.width = CGRectGetHeight(frame);
    }
    self.badge.frame = frame;
    self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
    self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 2;
}

- (void)showIconBadge
{
    if (!self.iconBadge) {
        CGFloat redDotWidth = 8;
        CGRect frm = CGRectMake(CGRectGetWidth(self.frame), -redDotWidth + 3.5, redDotWidth, redDotWidth);
        self.iconBadge = [[UIImageView alloc] initWithFrame:frm];
        self.iconBadge.image = [UIImage imageNamed:@"home_tip_badge"];
        self.iconBadge.tag = NLCBadgeStyleIcon;
        [self addSubview:self.iconBadge];
        [self bringSubviewToFront:self.iconBadge];
    }
    self.iconBadge.hidden = NO;
}

- (void)badgeInit
{
    if (self.badgeBgColor == nil) {
        self.badgeBgColor = [UIColor redColor];
    }
    if (self.badgeTextColor == nil) {
        self.badgeTextColor = [UIColor whiteColor];
    }
    
    if (nil == self.badge) {
        CGFloat redDotWidth = 8;
        CGRect frm = CGRectMake(CGRectGetWidth(self.frame), -redDotWidth, redDotWidth, redDotWidth);
        self.badge = [[UILabel alloc] initWithFrame:frm];
        self.badge.textAlignment = NSTextAlignmentCenter;
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
        self.badge.backgroundColor = self.badgeBgColor;
        self.badge.textColor = self.badgeTextColor;
        self.badge.text = @"";
        self.badge.tag = NLCBadgeStyleRedDot;
        self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame) / 2;
        self.badge.layer.masksToBounds = YES;
        self.badge.hidden = NO;
        [self addSubview:self.badge];
        [self bringSubviewToFront:self.badge];
    }
}

- (void)adjustLabelWidth:(UILabel *)label
{
    [label setNumberOfLines:0];
    NSString *s = label.text;
    UIFont *font = [label font];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize;
    
    if (![s respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
        
    } else {
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setLineBreakMode:NSLineBreakByWordWrapping];
        
        labelsize = [s boundingRectWithSize:size
                                    options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                 attributes:@{ NSFontAttributeName:font, NSParagraphStyleAttributeName : style}
                                    context:nil].size;
    }
    CGRect frame = label.frame;
    frame.size = CGSizeMake(ceilf(labelsize.width), ceilf(labelsize.height));
    [label setFrame:frame];
}
- (UILabel *)badge
{
    return objc_getAssociatedObject(self, &badgeLabelKey);
}

- (void)setBadge:(UILabel *)label
{
    objc_setAssociatedObject(self, &badgeLabelKey, label, OBJC_ASSOCIATION_RETAIN);
}

- (UIFont *)badgeFont
{
    id font = objc_getAssociatedObject(self, &badgeFontKey);
    return font == nil ? kNLCBadgeDefaultFont : font;
}

- (void)setBadgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.font = badgeFont;
    }
}

- (UIColor *)badgeBgColor
{
    return objc_getAssociatedObject(self, &badgeBgColorKey);
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor
{
    objc_setAssociatedObject(self, &badgeBgColorKey, badgeBgColor, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.backgroundColor = badgeBgColor;
    }
}

- (UIColor *)badgeTextColor
{
    return objc_getAssociatedObject(self, &badgeTextColorKey);
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.textColor = badgeTextColor;
    }
}

- (CGRect)badgeFrame
{
    id obj = objc_getAssociatedObject(self, &badgeFrameKey);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 4) {
        CGFloat x = [obj[@"x"] floatValue];
        CGFloat y = [obj[@"y"] floatValue];
        CGFloat width = [obj[@"width"] floatValue];
        CGFloat height = [obj[@"height"] floatValue];
        return  CGRectMake(x, y, width, height);
    } else
        return CGRectZero;
}

- (void)setBadgeFrame:(CGRect)badgeFrame
{
    NSDictionary *frameInfo = @{@"x" : @(badgeFrame.origin.x), @"y" : @(badgeFrame.origin.y),
                                @"width" : @(badgeFrame.size.width), @"height" : @(badgeFrame.size.height)};
    objc_setAssociatedObject(self, &badgeFrameKey, frameInfo, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.frame = badgeFrame;
    }
}

- (CGPoint)badgeCenterOffset
{
    id obj = objc_getAssociatedObject(self, &badgeCenterOffsetKey);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 2) {
        CGFloat x = [obj[@"x"] floatValue];
        CGFloat y = [obj[@"y"] floatValue];
        return CGPointMake(x, y);
    } else
        return CGPointZero;
}

- (void)setBadgeCenterOffset:(CGPoint)badgeCenterOff
{
    NSDictionary *cenerInfo = @{@"x" : @(badgeCenterOff.x), @"y" : @(badgeCenterOff.y)};
    objc_setAssociatedObject(self, &badgeCenterOffsetKey, cenerInfo, OBJC_ASSOCIATION_RETAIN);
    if (self.badge) {
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + badgeCenterOff.x, badgeCenterOff.y);
    }
}

- (NSInteger)badgeMaximumBadgeNumber
{
    id obj = objc_getAssociatedObject(self, &badgeMaximumBadgeNumberKey);
    if(obj != nil && [obj isKindOfClass:[NSNumber class]])
    {
        return [obj integerValue];
    }
    else
        return kNLCBadgeDefaultMaximumBadgeNumber;
}

- (void)setBadgeMaximumBadgeNumber:(NSInteger)badgeMaximumBadgeNumber
{
    NSNumber *numObj = @(badgeMaximumBadgeNumber);
    objc_setAssociatedObject(self, &badgeMaximumBadgeNumberKey, numObj, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)iconBadge
{
    return objc_getAssociatedObject(self, &badgeImageViewKey);
}

- (void)setIconBadge:(UIImageView *)iconBadge
{
    objc_setAssociatedObject(self, &badgeImageViewKey, iconBadge, OBJC_ASSOCIATION_RETAIN);
}


@end
