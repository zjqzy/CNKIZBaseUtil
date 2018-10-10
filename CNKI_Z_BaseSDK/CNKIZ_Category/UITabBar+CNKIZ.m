//
//  UITabBar+badge.m
//


#import "UITabBar+CNKIZ.h"

@implementation UITabBar (CNKIZ)


- (void)showBadgeOnItemIndex:(int)index{
    
    //显示红点
    if (index<0) {
        return;
    }
    NSInteger itmeCount=self.items.count;
    if (itmeCount <= index) {
        return;
    }
    
    //必须清除，因为是累计创建 UIView
    [self removeBadgeOnItemIndex:index];

    //新建小红点
    UIView *bview = [UIView new];
    bview.tag = 2018+index;
    bview.layer.cornerRadius = 5;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
    CGRect tabFram = self.frame;
    
    float percentX = (index+0.6)/itmeCount;
    CGFloat x = ceilf(percentX*tabFram.size.width);
    CGFloat y = ceilf(0.1*tabFram.size.height);
    bview.frame = CGRectMake(x, y, 10, 10);
    
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}

-(void)hideBadgeOnItemIndex:(int)index{
    //隐藏红点
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index{
    
    //移除 “红点UIView”
    for (UIView *subView in self.subviews) {
        if (subView.tag == 2018+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
