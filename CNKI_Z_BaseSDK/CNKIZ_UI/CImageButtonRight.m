//
//  CImageButtonRight.m
//  CNKIMobile
//
//  Created by cnki on 15/11/30.
//  Copyright (c) 2015年 CNKI. All rights reserved.
//

#import "CImageButtonRight.h"

@interface CImageButtonRight ()

@property(nonatomic,strong)UIView *contentView;

@end

@implementation CImageButtonRight

-(void)dealloc
{
    //析构
    
#ifdef DEBUG
    //NSLog(@"析构 CImageButtonRight");
#endif
    
    self.blockBack=nil;
    
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self dataPrepare];
        
        CGRect rectView=frame;
        rectView.origin=CGPointZero;
        [self customViewInit:rectView];
    }
    return self;
}

-(void)customViewInit:(CGRect)viewRect
{
    _contentView=[[UIView alloc]init];
    _contentView.backgroundColor=[UIColor clearColor];
    _contentView.userInteractionEnabled=NO;
    [self addSubview:_contentView];
    
    if (_contentView) {
        _lbTitle=[[UILabel alloc]init];
        _lbTitle.backgroundColor=[UIColor clearColor];
        _lbTitle.textAlignment=NSTextAlignmentCenter;
        [_contentView addSubview:_lbTitle];
        
        //
        _rightImageView=[[UIImageView alloc]init];
        _rightImageView.backgroundColor=[UIColor clearColor];
        [_contentView addSubview:_rightImageView];
        _rightImageView.contentMode=UIViewContentModeScaleAspectFit;
        
        //
        _activityIndicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.backgroundColor=[UIColor clearColor];
        _activityIndicatorView.hidesWhenStopped=YES;
        [_contentView addSubview:_activityIndicatorView];
    }
}

-(void)resizeViews:(CGRect)viewRect
{
    //布局
    if(viewRect.size.height<1||viewRect.size.width<1)
    {
        return;
    }
    
    _contentView.frame=viewRect;
    
    if (_contentView) {
        
        CGRect rectContentBound=_contentView.frame;
        
        //self.frame.size.width-32
        CGRect rectTitle=rectContentBound;
        if (_isImageViewOverlap) {
            //图片重叠文字
            rectTitle.size.width=rectContentBound.size.width;
        }
        else
        {
            rectTitle.size.width=rectContentBound.size.width -_imgWidth-_spacing;
        }
        _lbTitle.frame=rectTitle;
        //
        CGRect rectImageView=rectContentBound;
        rectImageView.size.width=_imgWidth;
        if (_isImageViewOverlap) {
            //图片重叠文字
            rectImageView.origin.x=rectContentBound.size.width-rectImageView.size.width;
        }
        else
        {
            rectImageView.origin.x=rectTitle.origin.x+rectTitle.size.width + _spacing;
        }
        if (_imgViewHeight>2&&_imgViewHeight<rectContentBound.size.height) {
            rectImageView.size.height=_imgViewHeight;
            rectImageView.origin.y=(rectContentBound.size.height-_imgViewHeight)*0.5f;
        }
        _rightImageView.frame=rectImageView;
        
        //
        _activityIndicatorView.frame=rectContentBound;
        
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self resizeViews:self.bounds];
}

-(void)dataPrepare
{
    _spacing=0;
    
    _imgWidth=32;
    _imgViewHeight=0;
}

-(void)initAfter
{
    
}

-(void)refresh
{
    
}

-(void)doClick:(id)sender
{
    if (self.blockBack) {
        self.blockBack(self.info);
    }
}
-(void)addClickBlock:(int (^)(NSMutableDictionary *))block1
{
    self.blockBack=block1;
    [self addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)optimalLayout
{
    //优化布局
    if (_contentView) {
        
        CGRect rectContentBound=_contentView.bounds;
        
        NSInteger totalWidth=rectContentBound.size.width;
        NSInteger textWidth=0;
        NSString *text1=_lbTitle.text;
        if ([text1 length]>0) {
            
            NSDictionary *dictAttr1 = @{NSFontAttributeName:_lbTitle.font};
            CGSize txtSize=[text1 boundingRectWithSize:CGSizeMake(MAX(120, MIN(300, rectContentBound.size.width)), 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dictAttr1 context:nil].size;
            textWidth=txtSize.width+1;
        }
        NSInteger imageWidth=0;
        UIImage *image1=_rightImageView.image;
        if (image1) {
            CGSize sizeImage=image1.size;
            imageWidth=MIN(sizeImage.width,_imgWidth);
        }
        
        NSInteger redundancy=10;    //冗余量
        if (totalWidth - redundancy >= textWidth + imageWidth + _spacing ) {
            //
            CGRect rectTitle=rectContentBound;
            rectTitle.size.width=textWidth;
            rectTitle.origin.x=(rectContentBound.size.width-textWidth-imageWidth-_spacing)*0.5f;
            _lbTitle.frame=rectTitle;
            
            //
            CGRect rectImageView=rectContentBound;
            rectImageView.size.width=imageWidth;
            rectImageView.origin.x=CGRectGetMaxX(rectTitle)+_spacing;
            _rightImageView.frame=CGRectInset(rectImageView, _contentEdge_image_width, _contentEdge_image_height);
        }
        else
        {
            CGRect rectContentBoundEdit=rectContentBound;
            rectContentBoundEdit.size.width=textWidth + imageWidth + _spacing+redundancy;
            
            CGRect rectTitle=rectContentBoundEdit;
            rectTitle.size.width=textWidth;
            rectTitle.origin.x=(rectContentBoundEdit.size.width-textWidth-imageWidth-_spacing)*0.5f;
            _lbTitle.frame=rectTitle;
            
            //
            CGRect rectImageView=rectContentBoundEdit;
            rectImageView.size.width=imageWidth;
            rectImageView.origin.x=CGRectGetMaxX(rectTitle)+_spacing;
            _rightImageView.frame=CGRectInset(rectImageView, _contentEdge_image_width, _contentEdge_image_height);
            
            CGRect frameContent=_contentView.frame;
            frameContent.size.width=rectContentBoundEdit.size.width;
            self.contentView.frame=frameContent;
            
            CGRect frameEdit=self.frame;
            frameEdit.size.width=rectContentBoundEdit.size.width;
            self.frame=frameEdit;
            
        }
    }
}
@end
