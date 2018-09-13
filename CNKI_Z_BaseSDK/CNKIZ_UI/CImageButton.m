//
//  CImageButton.m
//  CNKIMobile
//
//  Created by zhujianqi on 15/12/3.
//  Copyright (c) 2015年 CNKI. All rights reserved.
//

#import "CImageButton.h"


@interface CImageButton()

@property (nonatomic,strong) UIView *contentView;


@end

@implementation CImageButton

-(void)dealloc
{
    //析构
    
#ifdef DEBUG
    //NSLog(@"析构 CImageButton");
#endif
    
    self.blockBack=nil;
    
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
        
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)customViewInit:(CGRect)viewRect
{
    //创建
    _contentView=[[UIView alloc] init];
    _contentView.userInteractionEnabled=NO;
    _contentView.backgroundColor=[UIColor clearColor];
    //    _contentView.layer.borderColor =[UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1].CGColor;
    //    _contentView.layer.borderWidth = 1.0f;
    //    _contentView.layer.masksToBounds = YES;
    
    [self addSubview:_contentView];
    
    if (_contentView) {
        
        //
        _lbTitle=[[UILabel alloc] init];
        _lbTitle.backgroundColor=[UIColor clearColor];
        _lbTitle.textAlignment=NSTextAlignmentCenter;
        [_contentView addSubview:_lbTitle];
        
        //
        _imageView=[[UIImageView alloc] init];
        _imageView.backgroundColor=[UIColor clearColor];
        [_contentView addSubview:_imageView];
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = _lineBjColor;
        [_contentView addSubview:_lineView];
        
        //
        _activityIndicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.backgroundColor=[UIColor clearColor];
        _activityIndicatorView.hidesWhenStopped=YES;
        [_contentView addSubview:_activityIndicatorView];
        //[_activityIndicatorView startAnimating];
    }
}

-(void)resizeViews:(CGRect)viewRect
{
    //布局
    if (viewRect.size.height<1 || viewRect.size.width<1) {
        return;
    }
    
    _contentView.frame=viewRect;
    
    if (_contentView)
    {
        CGRect rectContentBound=_contentView.bounds;
        
        CGRect rect1=rectContentBound;
        
        _lbTitle.frame=CGRectInset(rect1, _titleEdge, 2);
        _imageView.frame=CGRectInset(rect1, _imageEdge,_imageEdgeHeight);
        _activityIndicatorView.frame=rect1;
        
        CGRect rectLine = rectContentBound;
        rectLine.size.width = 1;
        rectLine.origin.x = rect1.size.width - rectLine.size.width;
        _lineView.frame = rectLine;
    }
    
}
//viewWillLayoutSubviews 属于 view controller
-(void)layoutSubviews
{
    [super layoutSubviews];
//    [self resizeViews:self.bounds];
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self resizeViews:self.bounds];
}
-(void)dataPrepare
{
    //数据
    _imageEdge=10;
    _imageEdgeHeight=2;
    _titleEdge = 10;
}
-(void)initAfter
{
    //后续初始化
}
-(void)refresh
{
    //刷新
   
}

- (void)setLineBjColor:(UIColor *)lineBjColor{
    _lineBjColor = lineBjColor;
    _lineView.backgroundColor = _lineBjColor;
}

//-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
//{
////可以监视到 用户单击
//    if (self.state) {
//        self.lbName.textColor=[UIColor blueColor];
//        self.lbRecord.textColor=[UIColor blueColor];
//    }
//    else
//    {
//        self.lbName.textColor=[UIColor blackColor];
//        self.lbRecord.textColor=[UIColor blackColor];
//    }
//    NSLog(@"%@",@(self.state));
//
//    [super endTrackingWithTouch:touch withEvent:event];
//}

-(void)doClick:(id)sender
{
    if (self.blockBack) {
        self.blockBack(self.info);
    }
}

-(void)addClickBlock:(int (^)(NSMutableDictionary*))block1
{
    self.blockBack=block1;
    [self addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
}

@end
