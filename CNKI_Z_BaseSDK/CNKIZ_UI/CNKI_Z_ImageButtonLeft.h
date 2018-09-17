//
//  CNKI_Z_ImageButtonLeft.h
//

#import <UIKit/UIKit.h>

@interface CNKI_Z_ImageButtonLeft : UIControl

@property (strong) int (^blockBack)(NSMutableDictionary *para);
@property (nonatomic,strong) NSMutableDictionary *info;
@property (nonatomic,strong) UILabel *lbTitle;          //名称
@property (nonatomic,strong) UIImageView *leftImageView;//左图
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@property NSInteger spacing;            //间距
@property NSInteger imgViewWidth;       //图片容器宽度, 不是图片宽度
@property NSInteger imgViewHeight;      //图片容器高度, 不是图片高度

-(void)customViewInit:(CGRect)viewRect;     //创建
-(void)resizeViews:(CGRect)viewRect;        //布局
-(void)dataPrepare;                         //数据
-(void)initAfter;                           //线程初始化
-(void)refresh;                             //刷新

-(void)addClickBlock:(int (^)(NSMutableDictionary *))block1;     //

@end
