//
//  UITableView+EmptyDataView.m
//  ZX-UITableViewEmptyDataView-Test
//
//  Created by cnki on 2018/5/3.
//  Copyright © 2018年 Shawn. All rights reserved.
//

#import "UITableView+EmptyDataView.h"
#import <objc/runtime.h>

@interface CNKIWeakAssociatedObject : NSObject

@property (nonatomic, readonly, weak) id value;

- (instancetype)initWithValue:(id)obj;

@end

@implementation UITableView (EmptyDataView)

- (void)displayEmptyDataViewIfNeeded
{
    if (![self respondsToSelector:@selector(dataSource)]) {
        return;
    }
    
    NSInteger rows = 0;
    NSInteger sections = 1;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [self.dataSource numberOfSectionsInTableView:self];
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        for (NSInteger section = 0; section < sections; section++) {
            rows += [self.dataSource tableView:self numberOfRowsInSection:sections];
        }
    }
    
    if (rows == 0) {
        [self.backgroundView bringSubviewToFront:self.emptyBackgroundView];
        self.emptyBackgroundView.hidden = NO;
    } else {
        [self.backgroundView sendSubviewToBack:self.emptyBackgroundView];
        self.emptyBackgroundView.hidden = YES;
    }
}

#pragma mark - Private

- (void)zxp_addEmptyDataViewToBackground
{
    self.backgroundView = [UIView new];
    
    UIView *emptyBackgroundView = [UIView new];
    emptyBackgroundView.backgroundColor = [self zxp_backgroundColor];
    self.emptyBackgroundView = emptyBackgroundView;
    [self.backgroundView addSubview:emptyBackgroundView];
    [self displayEmptyDataViewIfNeeded];
    
    UIImage *image = [self zxp_image];
    // default image cache
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image ? image : [UIImage imageNamed:[[[NSBundle mainBundle] pathForResource:@"global" ofType:@"bundle"] stringByAppendingPathComponent:@"empty_Replace"]]];
    [emptyBackgroundView addSubview:imageView];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.lineBreakMode = NSLineBreakByCharWrapping;
    descLabel.numberOfLines = 0;
    descLabel.font = [UIFont systemFontOfSize:16.0];
    descLabel.textAlignment = NSTextAlignmentCenter;
    [emptyBackgroundView addSubview:descLabel];
    
    emptyBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[emptyBackgroundView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(emptyBackgroundView)]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[emptyBackgroundView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(emptyBackgroundView)]];
    
    CGFloat imageWidth  = [self zxp_imageSize].width;
    CGFloat imageHeight = [self zxp_imageSize].height;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [emptyBackgroundView addConstraints:@[[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:emptyBackgroundView attribute:NSLayoutAttributeTop multiplier:1. constant:[self zxp_topMargin]], [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:emptyBackgroundView attribute:NSLayoutAttributeCenterX multiplier:1. constant:0], [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1. constant:imageWidth], [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1. constant:imageHeight]]];
    
    descLabel.attributedText = [self zxp_descriptionLabelString];
    descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *metrics = @{@"padding" : @(15.0), @"spacing" : @(35.0)};
    [emptyBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[descLabel]-padding-|" options:NSLayoutFormatAlignAllCenterX metrics:metrics views:NSDictionaryOfVariableBindings(descLabel)]];
    [emptyBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView]-spacing-[descLabel]->=0-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:metrics views:NSDictionaryOfVariableBindings(imageView, descLabel)]];
}

- (NSAttributedString *)zxp_descriptionLabelString
{
    if (self.emptyDataViewSource && [self.emptyDataViewSource respondsToSelector:@selector(descriptionForEmptyDataView:)]) {
        NSAttributedString *descStr = [self.emptyDataViewSource descriptionForEmptyDataView:self];
        if (descStr) NSAssert([descStr isKindOfClass:[NSAttributedString class]], @"You must return a valid NSAttributedString object for -descriptionForEmptyDataView:");
        return descStr;
    }
    return nil;
}

- (UIImage *)zxp_image
{
    if (self.emptyDataViewSource && [self.emptyDataViewSource respondsToSelector:@selector(imageForEmptyDataView:)]) {
        UIImage *image = [self.emptyDataViewSource imageForEmptyDataView:self];
        if (image) NSAssert([image isKindOfClass:[UIImage class]], @"You must return a valid UIImage object for -imageForEmptyDataView:");
        return image;
    }
    return nil;
}

- (CGSize)zxp_imageSize
{
    if (self.emptyDataViewSource && [self.emptyDataViewSource respondsToSelector:@selector(imageSizeForEmptyDataView:)]) {
        return [self.emptyDataViewSource imageSizeForEmptyDataView:self];
    }
    
    CGFloat minWidth = [UIScreen mainScreen].bounds.size.width;
    if (minWidth > [UIScreen mainScreen].bounds.size.height) {
        minWidth = [UIScreen mainScreen].bounds.size.height;
    }
    return CGSizeMake(minWidth * 0.4, minWidth * 0.4);
}

- (UIColor *)zxp_backgroundColor
{
    UIColor *backgroundColor = nil;
    if (self.emptyDataViewSource && [self.emptyDataViewSource respondsToSelector:@selector(backgroundColorForEmptyDataView:)]) {
        backgroundColor = [self.emptyDataViewSource backgroundColorForEmptyDataView:self];
    }
    
    if (!backgroundColor) {
        backgroundColor = [UIColor colorWithRed:240 / 255.0 green:241 / 255.0 blue:245 / 255.0 alpha:1.0];
    }
    
    return backgroundColor;
}

- (CGFloat)zxp_topMargin
{
    CGFloat maxHeight = [UIScreen mainScreen].bounds.size.height;
    if (maxHeight < [UIScreen mainScreen].bounds.size.width) {
        maxHeight = [UIScreen mainScreen].bounds.size.width;
    }
    
    return maxHeight * 0.2; // 现在用的固定 20% 屏幕高度
}

#pragma mark - Getters and Setters

- (BOOL)isEmptyDataViewVisible
{
    UIView *view = objc_getAssociatedObject(self, @selector(emptyBackgroundView));
    return view ? !view.hidden : NO;
}

- (void)setEmptyBackgroundView:(UIView *)emptyBackgroundView
{
    objc_setAssociatedObject(self, @selector(emptyBackgroundView), emptyBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)emptyBackgroundView
{
    return objc_getAssociatedObject(self, @selector(emptyBackgroundView));
}

- (void)setEmptyDataViewSource:(id<CNKITableViewEmptyDataViewSource>)emptyDataViewSource
{
    objc_setAssociatedObject(self, @selector(emptyDataViewSource), [[CNKIWeakAssociatedObject alloc] initWithValue:emptyDataViewSource], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (emptyDataViewSource) {
        [self zxp_addEmptyDataViewToBackground];
    }
}

- (id<CNKITableViewEmptyDataViewSource>)emptyDataViewSource
{
    CNKIWeakAssociatedObject *weakObject = objc_getAssociatedObject(self, @selector(emptyDataViewSource));
    return weakObject.value;
}

@end

@implementation CNKIWeakAssociatedObject

- (instancetype)initWithValue:(id)obj
{
    self = [super init];
    if (self) {
        _value = obj;
    }
    return self;
}

@end
