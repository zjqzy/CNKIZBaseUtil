//
//  CButtonProgressLayer.h
//  CAJViewer
//
//  Created by zhu on 14-5-14.
//  Copyright (c) 2014年 zhu. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface CButtonProgressLayer : CALayer

@property (nonatomic) CGFloat percent;
@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat outerRadius;
@property (nonatomic) CGFloat innerRadius;
@property (nonatomic) CGFloat innerOuterSpace;

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *trackColor;


@end
