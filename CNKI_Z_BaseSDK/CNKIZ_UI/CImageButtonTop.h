//
//  CImageButtonTop.h
//

#import <UIKit/UIKit.h>
@interface CImageButtonTop : UIControl

@property (strong) int (^blockBack)(NSMutableDictionary *para) ;

@property (nonatomic,strong) NSMutableDictionary *info; //辅助参数

@property (nonatomic,strong) UILabel *lbTitle;          //名称
@property (nonatomic,strong) UIImageView *topImageView; //下图
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@property NSInteger imageEdgeWidth;//图片容器（非图片）整体缩进，默认为0
@property NSInteger imageEdgeHeight;//图片容器（非图片）整体缩进，默认为0

@property NSInteger imgViewHeight;  //图片容器高度, 不是图片高度
@property NSInteger titleHeight;    //文字容器高度

@property NSInteger spacing;            //间距

-(void)addClickBlock:(int (^)(NSMutableDictionary*))block1; //

@end
