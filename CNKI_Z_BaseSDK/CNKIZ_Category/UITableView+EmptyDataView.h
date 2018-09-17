//
//  UITableView+EmptyDataView.h
//  ZX-UITableViewEmptyDataView-Test
//
//  Created by cnki on 2018/5/3.
//  Copyright © 2018年 Shawn. All rights reserved.
//  无数据时展示提示，只针对tableView，未实现数据源方法则会使用默认UI

#import <UIKit/UIKit.h>

@protocol CNKITableViewEmptyDataViewSource <NSObject>

@optional

/**
 自定义图像视图的大小
 
 @param tableView tableView
 @return 图像视图的大小 CGSize
 */
- (CGSize)imageSizeForEmptyDataView:(UITableView *)tableView;

/**
 自定义图像
 
 @param tableView tableView
 @return 自定义 UIImage
 */
- (nullable UIImage *)imageForEmptyDataView:(UITableView *)tableView;

/**
 自定义提醒文本，富文本。
 
 @param tableView tableView
 @return 自定义提醒文本
 */
- (nullable NSAttributedString *)descriptionForEmptyDataView:(UITableView *)tableView;

/**
 自定义背景颜色，UIColor

 @param tableView tableView
 @return 自定义背景颜色
 */
- (nullable UIColor *)backgroundColorForEmptyDataView:(UITableView *)tableView;

@end

/**
 1.该类实现不会替换系统 reload 方法！不影响SDK内 reload，因此需要手动调用 displayEmptyDataViewIfNeeded 来刷新状态
 2.如果需要设置 tableView.backgroundView，在 backgroundView 上添加子视图即可。不可以直接设置 tb.backgroundView
 */
@interface UITableView (EmptyDataView)

/// 数据源对象
@property (nonatomic, weak) id <CNKITableViewEmptyDataViewSource> emptyDataViewSource;

/// 无数据提醒视图显示状态，YES 显示，NO 未显示
@property (nonatomic, assign, readonly, getter=isEmptyDataViewVisible) BOOL emptyDataViewVisible;

/// 在数据源修改后调用此方法刷新，例如 删除、添加，更改reload等时刷新
/// 依赖于table dataSource数据源方法，不可以在数据方法中嵌套使用。
- (void)displayEmptyDataViewIfNeeded;

@end
