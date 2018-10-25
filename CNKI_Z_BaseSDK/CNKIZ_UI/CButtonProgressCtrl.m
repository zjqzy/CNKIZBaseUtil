//
//  CButtonProgressCtrl.m
//  CAJViewer
//
//  Created by zhu on 14-5-14.
//  Copyright (c) 2014年 zhu. All rights reserved.
//

#import "CButtonProgressCtrl.h"
#import "CButtonProgressLayer.h"

@implementation CButtonProgressCtrl
- (void) dealloc
{
    [self removeSomeObserver];
    self.percentLayer=nil;
    self.imgCenter=nil;
    
#if !__has_feature(objc_arc)
    
    [super dealloc];
    
#endif
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self dataPrepare];
        
        CGRect rectView=frame;
        rectView.origin=CGPointZero;
        [self customViewInit:rectView];
        
        [self addSomeObserver];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)customViewInit:(CGRect)viewRect
{
    //创建
    //
    _imgCenter=[[UIImageView alloc] init];
    _imgCenter.backgroundColor=[UIColor clearColor];
    [self addSubview:_imgCenter];
    
    //
    self.percentLayer = [CButtonProgressLayer layer];
    self.percentLayer.contentsScale = [UIScreen mainScreen].scale;
    self.percentLayer.percent =_percent;  // [0 , 1]
    self.percentLayer.masksToBounds = NO;     
    [self.layer addSublayer:self.percentLayer];
    [self.percentLayer setNeedsDisplay];
}

-(void)resizeViews:(CGRect)viewRect
{
    //布局
    _percentLayer.frame = viewRect;
    
    CGRect rect1=CGRectMake(0, 0, _percentLayer.outerRadius, _percentLayer.outerRadius);
    rect1.origin.x=(viewRect.size.width - rect1.size.width) *0.5f;
    rect1.origin.y=(viewRect.size.height - rect1.size.height) *0.5f;
    _imgCenter.frame=rect1;
}
//viewWillLayoutSubviews 属于 view controller
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self resizeViews:self.bounds];
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self resizeViews:self.bounds];
}
-(void)dataPrepare
{
    //数据
    _percent=0;
}
-(void)initAfter
{
    //后续初始化
}
-(void)refresh
{
    //刷新    
    [self setNeedsLayout];
    _percentLayer.percent=_percent;
    [_percentLayer setNeedsDisplay];
}
-(void)addSomeObserver
{
    //
    [self addObserver:self forKeyPath:@"percent" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}
-(void)removeSomeObserver
{
    [self removeObserver:self forKeyPath:@"percent"];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if([keyPath isEqualToString:@"percent"])
    {
        float old=[[change objectForKey:@"old"] floatValue];
        float new=[[change objectForKey:@"new"] floatValue];
        if (old!=new)
        {
            //NSLog(@"Observer old=%f,new=%f",old,new);
            //[self resizeViews];    //ok
        }
    }
}

-(void)setPercent:(CGFloat)percent animated:(BOOL)animated
{
    // Coerce the value
    float fPercent=MIN(1.0f, percent);
    fPercent=MAX(0.0f, fPercent);

    // Apply to the layer
    if(animated)
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"percent"];
        animation.duration = 1.0f;
        animation.fromValue = [NSNumber numberWithFloat:_percent];
        animation.toValue = [NSNumber numberWithFloat:fPercent];
        [self.layer addAnimation:animation forKey:@"percent1"];
        
        NSLog(@"percentAnimation old=%f,new=%f",_percent,fPercent);//不起作用
    }    

    self.percent=fPercent;
    [self refresh];
}

@end
