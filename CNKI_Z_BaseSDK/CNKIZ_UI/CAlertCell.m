//
//  CAlertCell.m
//


#import "CAlertCell.h"

@implementation CAlertCell

- (void)dealloc {
    //析构
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self dataPrepare];
        [self customViewInit:self.bounds];
    }
    return self;
}

- (void)dataPrepare {
    
}

- (void)initAfter {
    
}

- (void)refresh {
    
}

- (void)customViewInit:(CGRect)viewRect {
    //创建
    
    //内容
    _content = [UIView alloc].init;
    _content.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_content];
    if (_content) {
        //
        _lbMessage = [UILabel alloc].init;
        _lbMessage.backgroundColor = [UIColor clearColor];
        [_content addSubview:_lbMessage];
        
        //线
        _lineView = [UIView alloc].init;
        _lineView.backgroundColor = [self color:@"e1e2e5"];
        [_content addSubview:_lineView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self resizeViews:self.bounds];
}

//- (void)setFrame:(CGRect)frame {
//    [super setFrame:frame];
//    [self resizeViews:self.bounds];
//}

- (void)resizeViews:(CGRect)viewRect {
    //布局
    if (viewRect.size.width<1 || viewRect.size.height<1) {
        return;
    }
    
    //内容 简约(推荐)
    _content.frame = viewRect;
    if (_content) {
        CGRect rectContentBound = _content.bounds;
        
        //
        CGRect rectTitle = rectContentBound;
        _lbMessage.frame = CGRectInset(rectTitle, 12.0f, 1.0f);
        
        //线
        CGRect rectLine = rectContentBound;
        rectLine.origin.y = rectContentBound.size.height-1.0f;
        rectLine.size.height = 1.0f;
        _lineView.frame = rectLine;
    }
}

#pragma mark - Other
- (UIColor *)R:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue {
    //RGB
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
}

- (UIColor *)R:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    //RGB
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

- (UIColor *)color:(NSString *)color {
    //十六进制颜色码
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    if (cString.length != 6) {
        return [UIColor blackColor];
    }
    
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [self R:r G:g B:b];
}

- (UIColor *)color:(NSString *)color alpha:(CGFloat)alpha {
    //十六进制颜色码
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    if (cString.length != 6) {
        return [UIColor blackColor];
    }
    
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [self R:r G:g B:b A:alpha];
}

@end
