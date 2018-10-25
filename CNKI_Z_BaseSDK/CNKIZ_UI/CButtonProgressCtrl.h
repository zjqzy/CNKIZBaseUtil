//
//  CButtonProgressCtrl.h
//  CAJViewer
//
//  Created by zhu on 14-5-14.
//  Copyright (c) 2014年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CButtonProgressLayer;

@interface CButtonProgressCtrl : UIControl

@property (nonatomic,strong) CButtonProgressLayer *percentLayer;
@property (nonatomic) CGFloat percent;
@property (nonatomic,strong) UIImageView *imgCenter;

-(void)customViewInit:(CGRect)viewRect;     //创建
-(void)resizeViews:(CGRect)viewRect;        //布局
-(void)dataPrepare;                         //数据
-(void)initAfter;                           //线程初始化
-(void)refresh;                             //刷新

-(void)addSomeObserver;     //监听
-(void)removeSomeObserver;  //监听

-(void)setPercent:(CGFloat)percent animated:(BOOL)animated;

@end
