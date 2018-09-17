//
//  CNKI_Z_ImageButtonBottom.h
//


#import <UIKit/UIKit.h>

@interface CNKI_Z_ImageButtonBottom : UIControl

@property (strong) int (^blockBack)(NSMutableDictionary* para);

@property (nonatomic,strong) NSMutableDictionary *info; //辅助参数

@property (nonatomic,strong) UILabel *lbTitle;          //名称
@property (nonatomic,strong) UIImageView *bottomImageView; //下图
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@property NSInteger spacing;            //间距

-(void)addClickBlock:(int (^)(NSMutableDictionary *))block1; //

@end
