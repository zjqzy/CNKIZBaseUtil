//
//  CImageButtonRight.h
//

#import <UIKit/UIKit.h>
@interface CImageButtonRight : UIControl

@property (strong) int (^blockBack)(NSMutableDictionary *para);

@property (nonatomic,strong) NSMutableDictionary *info;
@property (nonatomic,strong) UILabel *lbTitle;          //名称
@property (nonatomic,strong) UIImageView *rightImageView;//右图
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@property NSInteger isImageViewOverlap; //图片是否重叠覆盖
@property NSInteger spacing;            //间距
@property NSInteger imgWidth;           //图片容器宽度, 不是title宽度
@property NSInteger imgViewHeight;      //图片容器高度, 不是图片高度

/**
 图片宽度 整体缩进，默认为0
 */
@property NSInteger contentEdge_image_width;

/**
 图片宽度 整体缩进，默认为0
 */
@property NSInteger contentEdge_image_height;

-(void)customViewInit:(CGRect)viewRect;     //创建
-(void)resizeViews:(CGRect)viewRect;        //布局
-(void)dataPrepare;                         //数据
-(void)initAfter;                           //线程初始化
-(void)refresh;                             //刷新

-(void)addClickBlock:(int (^)(NSMutableDictionary *))block1;     //
-(void)optimalLayout;       //优化布局 
@end
