//
//  CButtonProgressLayer.m
//  CAJViewer
//
//  Created by zhu on 14-5-14.
//  Copyright (c) 2014年 zhu. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "CButtonProgressLayer.h"

#define toRadians(x) ((x)*M_PI / 180.0)
#define toDegrees(x) ((x)*180.0 / M_PI)

@implementation CButtonProgressLayer

+ (BOOL) needsDisplayForKey:(NSString *)key
{
    if([key isEqualToString:@"percent"])
        return YES;
    else
        return [super needsDisplayForKey:key];
}

- (void)dealloc
{
    self.tintColor = nil;
    self.trackColor = nil;
    
#if !__has_feature(objc_arc)
    
    [super dealloc];
    
#endif

}
-(id)init
{
    self=[super init];
    if (self)
    {
        self.innerOuterSpace = 10;
        self.tintColor = [UIColor greenColor];
        self.trackColor = [UIColor grayColor];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _outerRadius = MIN(self.frame.size.width, self.frame.size.height)/2.0;
    _innerRadius=_outerRadius-_innerOuterSpace;
    if (_innerRadius<2)
    {
        _innerRadius=2;
    }
}

-(void)drawInContext:(CGContextRef)context
{
    [self DrawLeft:context];
    [self DrawRight:context];
    
}
-(void)DrawRight:(CGContextRef)ctx {
    CGPoint center = CGPointMake(self.frame.size.width / (2), self.frame.size.height / (2));
    
    CGFloat delta = -toRadians(360 * (1-_percent));
    
    
    CGContextSetFillColorWithColor(ctx, _trackColor.CGColor);
    
    CGContextSetLineWidth(ctx, 1);
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRelativeArc(path, NULL, center.x, center.y, _innerRadius, -(M_PI / 2), delta);
    CGPathAddRelativeArc(path, NULL, center.x, center.y, _outerRadius, delta - (M_PI / 2), -delta);
    CGPathAddLineToPoint(path, NULL, center.x, center.y-_innerRadius);
    
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    
    CFRelease(path);
}

-(void)DrawLeft:(CGContextRef)ctx {
    CGPoint center = CGPointMake(self.frame.size.width / (2), self.frame.size.height / (2));
    
    CGFloat delta = toRadians(360 * _percent);
    
    
    CGContextSetFillColorWithColor(ctx, _tintColor.CGColor);
    
    CGContextSetLineWidth(ctx, 1);
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRelativeArc(path, NULL, center.x, center.y, _innerRadius, -(M_PI / 2), delta);
    CGPathAddRelativeArc(path, NULL, center.x, center.y, _outerRadius, delta - (M_PI / 2), -delta);
    CGPathAddLineToPoint(path, NULL, center.x, center.y-_innerRadius);
    
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    
    CFRelease(path);
}

-(void)DrawArc:(CGContextRef)context
{
    //画扇形
    CGPoint center = {self.bounds.size.width/2.0, self.bounds.size.height/2.0};
    
    // Background circle 外围的圆
    CGRect circleRect = {center.x-_innerRadius, center.y-_innerRadius, _innerRadius*2.0, _innerRadius*2.0};
    CGContextAddEllipseInRect(context, circleRect);    
    CGContextSetFillColorWithColor(context, _trackColor.CGColor);
    CGContextFillPath(context);
    
    // Elapsed arc
    CGContextAddArc(context, center.x, center.y, _innerRadius, _startAngle, _startAngle + _percent*2.0*M_PI, 0);
    CGContextAddLineToPoint(context, center.x, center.y);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, _tintColor.CGColor);
    CGContextFillPath(context);
}



@end
