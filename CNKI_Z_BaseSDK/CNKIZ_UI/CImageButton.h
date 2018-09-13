//
//  CImageButton.h
//

/*
 
 只用于 显示 纯文本 和 纯图片 用
 
 */

#import <UIKit/UIKit.h>

@interface CImageButton : UIControl

@property (strong) int (^blockBack)(NSMutableDictionary *para);

@property (nonatomic,strong) NSMutableDictionary *info; //辅助参数
@property (nonatomic,strong) UILabel *lbTitle;          //文本
@property (nonatomic,strong) UIImageView *imageView;    //图
@property (nonatomic,strong) UIView *lineView;          //线条
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@property NSInteger imageEdge;  //图片容器（非图片）整体缩进，默认为10
@property NSInteger imageEdgeHeight;//图片容器（非图片）整体缩进，默认为2
@property NSInteger titleEdge;  //标签容器整体缩进，默认为10
@property NSInteger titleWidth; //文字宽度，和容器无关
@property NSInteger titleHeight;//文字高度，和容器无关
@property (nonatomic,strong) UIColor *lineBjColor;//线条背景色

-(void)customViewInit:(CGRect)viewRect;     //创建
-(void)resizeViews:(CGRect)viewRect;        //布局
-(void)dataPrepare;                         //数据
-(void)initAfter;                           //线程初始化
-(void)refresh;                             //刷新

-(void)addClickBlock:(int (^)(NSMutableDictionary*))block1;     //

@end
