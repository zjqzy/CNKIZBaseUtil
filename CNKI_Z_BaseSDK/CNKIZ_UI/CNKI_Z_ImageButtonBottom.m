//
//  CNKI_Z_ImageButtonBottom.m
//


#import "CNKI_Z_ImageButtonBottom.h"

@interface CNKI_Z_ImageButtonBottom()

@property (nonatomic,strong) UIView *contentView;

-(void)customViewInit:(CGRect)viewRect;     //创建
-(void)resizeViews:(CGRect)viewRect;        //布局
-(void)dataPrepare;                         //数据
-(void)initAfter;                           //线程初始化
-(void)refresh;                             //刷新

@end

@implementation CNKI_Z_ImageButtonBottom

-(void)dealloc
{
    //析构
    
//#ifdef DEBUG
//    NSLog(@"析构 %@", NSStringFromClass([self class]));
//#endif
    
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
        _bottomImageView=[[UIImageView alloc] init];
        _bottomImageView.backgroundColor=[UIColor clearColor];
        [_contentView addSubview:_bottomImageView];
        _bottomImageView.contentMode=UIViewContentModeScaleAspectFit;
        
        //
        _activityIndicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.backgroundColor=[UIColor clearColor];
        _activityIndicatorView.hidesWhenStopped=YES;
        [_contentView addSubview:_activityIndicatorView];
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
        rect1.size.height=viewRect.size.height * 0.5f;
        _lbTitle.frame=rect1;
        _activityIndicatorView.frame=rect1;
        
        
        CGRect rect2=rectContentBound;
        rect2.origin.y=rect1.origin.y+rect1.size.height+_spacing;
        rect2.size.height=rectContentBound.size.height-rect2.origin.y;
        _bottomImageView.frame=rect2;
        
    }
    
}
//viewWillLayoutSubviews 属于 view controller
-(void)layoutSubviews
{
    [super layoutSubviews];
    //[self resizeViews:self.bounds];
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self resizeViews:self.bounds];
}
-(void)dataPrepare
{
    //数据
    _spacing=0;
}
-(void)initAfter
{
    //后续初始化
}
-(void)refresh
{
    //刷新
    
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

@end
