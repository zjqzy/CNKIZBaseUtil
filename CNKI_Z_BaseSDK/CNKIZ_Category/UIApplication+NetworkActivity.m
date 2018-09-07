//
//  UIApplication+NetworkActivity.m
//
//  Created by Maciej Swic on 2013-04-29.
//  Released under the MIT license.
//

#import "UIApplication+NetworkActivity.h"

@implementation UIApplication (NetworkActivity)

static NSInteger networkOperationCount;

+ (void)startNetworkActivity {
    networkOperationCount++;
    [[UIApplication sharedApplication] updateNetworkActivityIndicator];
}

+ (void)finishNetworkActivity {
    networkOperationCount--;
    [[UIApplication sharedApplication] updateNetworkActivityIndicator];
}

- (void)updateNetworkActivityIndicator {
    [self setNetworkActivityIndicatorVisible:(networkOperationCount > 0 ? TRUE : FALSE)];
}

@end
