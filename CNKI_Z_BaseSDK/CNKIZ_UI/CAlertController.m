//
//  CAlertController.m
//


#import "CAlertController.h"
#import "CAlertCell.h"

#define iSIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1125, 2436), [UIScreen mainScreen].currentMode.size):NO)


typedef NS_ENUM(NSInteger, ButtonTag) {
    CAlert_Button_Mask = 1001,//遮罩层
    CAlert_Button_Cancel,//取消
    CAlert_Button_Confirm,//确认
};

@interface CAlertController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (strong, nonatomic) UIButton *btnMask;//遮罩层

@property (strong, nonatomic) UIView *content1;//内容
@property (strong, nonatomic) UIImageView *imgEdge1;
@property (strong, nonatomic) UILabel *lbTitle1;//标题
@property (strong, nonatomic) UITextView *txtMessage1;//提示内容
@property (strong, nonatomic) UIButton *btnConfirm1;//确认

@property (strong, nonatomic) UIView *content2;//内容
@property (strong, nonatomic) UITableView *tableView2;
@property (strong, nonatomic) NSMutableArray *msg2;

@property (strong, nonatomic) UIView *content3;//内容
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView3;//转子
@property (strong, nonatomic) UILabel *lbMessage3;//提示内容
@property (assign, nonatomic) CGFloat content3_w;
@property (assign, nonatomic) CGFloat content3_h;
@property (assign, nonatomic) BOOL activity3;//是否有转子
@property (assign, nonatomic) BOOL center3;//是否居中

@property (strong, nonatomic) UIView *content4;//内容
@property (strong, nonatomic) UIButton *btnCancel4;//取消
@property (strong, nonatomic) UILabel *lbTitle4;//标题
@property (strong, nonatomic) UIButton *btnConfirm4;//确认
@property (strong, nonatomic) UIDatePicker *datePicker4;

@property (strong) int (^blockBack)(NSMutableDictionary *para);//回调

@end

@implementation CAlertController

+ (void)alert:(UIViewController *)vc title:(NSString *)title message:(NSString *)msg handlerClose:(void (^)(UIAlertAction *action))handlerClose {
    //系统提示框 关闭
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(title, @"") message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Close", @"") style:UIAlertActionStyleDefault handler:handlerClose]];
    [vc presentViewController:alert animated:YES completion:nil];
}

+ (void)alert:(UIViewController *)vc title:(NSString *)title message:(NSString *)msg confirm:(NSString *)confirm handler:(void (^)(UIAlertAction *action))handler {
    //系统提示框 一个Action
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(title, @"") message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:confirm?confirm:NSLocalizedString(@"Confirm", @"") style:UIAlertActionStyleDefault handler:handler]];
    [vc presentViewController:alert animated:YES completion:nil];
}

+ (void)alert:(UIViewController *)vc title:(NSString *)title message:(NSString *)msg cancel:(NSString *)cancel confirm:(NSString *)confirm handlerCancel:(void (^)(UIAlertAction *action))handlerCancel handlerConfirm:(void (^)(UIAlertAction *action))handlerConfirm {
    //系统提示框 两个Action
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(title, @"") message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:cancel?cancel:NSLocalizedString(@"Cancel", @"") style:UIAlertActionStyleDefault handler:handlerCancel]];
    [alert addAction:[UIAlertAction actionWithTitle:confirm?confirm:NSLocalizedString(@"Confirm", @"") style:UIAlertActionStyleDefault handler:handlerConfirm]];
    [vc presentViewController:alert animated:YES completion:nil];
}

+ (void)alertSheet:(UIViewController *)vc title:(NSString *)title message:(NSMutableArray *)msg cancel:(NSString *)cancel handler:(int (^)(NSMutableDictionary *para))handler {
    //系统提示框 Sheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSInteger i = 0; i<msg.count; i++) {
        NSString *msg1 = msg[i][@"msg"];
        [alert addAction:[UIAlertAction actionWithTitle:msg1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (handler) {
                NSMutableDictionary *para1 = [NSMutableDictionary dictionary];
                para1[@"index"] = @(i);
                para1[@"msg"] = msg1;
                handler(para1);
            }
        }]];
    }
    if (cancel) {
        [alert addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:nil]];
    }
    [vc presentViewController:alert animated:YES completion:nil];
}

+ (instancetype)alertCustom:(UIViewController *)vc title:(NSString *)title message:(NSString *)msg center:(BOOL)center confirm:(NSString *)confirm handler:(int (^)(NSMutableDictionary *para))handler {
    //自定义提示框 一个Action
    CAlertController *alert = [CAlertController alloc].init;
    alert.content1.hidden = NO;
    //遮罩层
    alert.btnMask.frame = alert.view.bounds;
    //标题
    NSMutableParagraphStyle *paragraphStyle1 = [NSMutableParagraphStyle alloc].init;
    paragraphStyle1.alignment = NSTextAlignmentCenter;
    NSDictionary *dict1 = @{NSKernAttributeName:@(2.0f),
                            NSForegroundColorAttributeName:[alert R:33 G:33 B:33 A:1.0f],
                            NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:21.0f],
                            NSParagraphStyleAttributeName:paragraphStyle1};
    alert.lbTitle1.attributedText = [[NSAttributedString alloc] initWithString:NSLocalizedString(title, @"") attributes:dict1];
    //提示内容
    NSMutableParagraphStyle *paragraphStyle2 = [NSMutableParagraphStyle alloc].init;
    paragraphStyle2.lineSpacing = 2.0f;
    paragraphStyle2.alignment = center?NSTextAlignmentCenter:NSTextAlignmentLeft;
    NSDictionary *dict2 = @{NSForegroundColorAttributeName:[alert R:33 G:33 B:33 A:1.0f],
                            NSFontAttributeName:[UIFont systemFontOfSize:15.0f],
                            NSParagraphStyleAttributeName:paragraphStyle2};
    alert.txtMessage1.attributedText = [[NSAttributedString alloc] initWithString:msg attributes:dict2];
    //确认
    [alert.btnConfirm1 setTitle:confirm?confirm:NSLocalizedString(@"Confirm", @"") forState:UIControlStateNormal];
    //回调
    if (handler) {
        alert.blockBack = handler;
    } else {
        __weak typeof(vc) _weakvc = vc;
        alert.blockBack = ^(NSMutableDictionary *para) {
            if ([para[@"index"] integerValue] == 1) {
                //确认
                [_weakvc dismissViewControllerAnimated:NO completion:nil];
            }
            return 1;
        };
    }
    alert.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [vc presentViewController:alert animated:NO completion:nil];
    return alert;
}

+ (instancetype)alertCustomSheet:(UIViewController *)vc message:(NSMutableArray *)msg handler:(int (^)(NSMutableDictionary *para))handler {
    //自定义提示框 Sheet
    CAlertController *alert = [CAlertController alloc].init;
    alert.content2.hidden = NO;
    //遮罩层
    alert.btnMask.frame = alert.view.bounds;
    //提示内容
    alert.msg2 = msg;
    //回调
    if (handler) {
        alert.blockBack = handler;
    }
    alert.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [vc presentViewController:alert animated:NO completion:nil];
    return alert;
}

+ (instancetype)alertHUD:(UIViewController *)vc message:(NSString *)msg activity:(BOOL)activity center:(BOOL)center hideAfter:(NSTimeInterval)delay {
    //自定义提示框 HUD
    CAlertController *alert = [CAlertController alloc].init;
    alert.content3.hidden = NO;
    alert.content3_w = MAX(100, [alert rectString:msg maxWidth:alert.view.bounds.size.width-30-24 font:[UIFont systemFontOfSize:16.0f]].size.width+24);
    alert.content3_h = activity?30+44+20:30+20;
    //遮罩层
    alert.btnMask.frame = CGRectMake(0, 0, alert.content3_w, alert.content3_h);
    alert.btnMask.center = CGPointMake(alert.view.bounds.size.width*0.5f, center?alert.view.bounds.size.height*0.5f:alert.view.bounds.size.height-100);
    alert.btnMask.backgroundColor = [alert R:0 G:0 B:0 A:0.7f];
    alert.btnMask.layer.cornerRadius = 15.0f;
    alert.btnMask.layer.masksToBounds = YES;
    //提示内容
    alert.lbMessage3.text = msg;
    //转子
    alert.activity3 = activity;
    if (activity) {
        [alert.activityIndicatorView3 startAnimating];
        UIApplication.sharedApplication.networkActivityIndicatorVisible = YES;
    }
    //居中
    alert.center3 = center;
    //隐藏
    if (delay>0.0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
            [vc dismissViewControllerAnimated:NO completion:nil];
        });
    }
    alert.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [vc presentViewController:alert animated:NO completion:nil];
    return alert;
}

+ (void)closeHUD:(UIViewController *)vc {
    //自定义提示框 HUD关闭
    UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
    [vc dismissViewControllerAnimated:NO completion:nil];
}

+ (instancetype)alertCustomDatePicker:(UIViewController *)vc title:(NSString *)title time:(NSString *)time cancel:(NSString *)cancel confirm:(NSString *)confirm handler:(int (^)(NSMutableDictionary *para))handler {
    //自定义提示框 DatePicker
    CAlertController *alert = [CAlertController alloc].init;
    alert.content4.hidden = NO;
    //遮罩层
    alert.btnMask.frame = alert.view.bounds;
    alert.btnMask.backgroundColor = [UIColor clearColor];
    //取消
    [alert.btnCancel4 setTitle:cancel?cancel:NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];
    //标题
    alert.lbTitle4.text = NSLocalizedString(title, @"");
    //确认
    [alert.btnConfirm4 setTitle:confirm?confirm:NSLocalizedString(@"Confirm", @"") forState:UIControlStateNormal];
    //time
    NSDateFormatter *dateFormatter = [NSDateFormatter alloc].init;
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    alert.datePicker4.minimumDate = [dateFormatter dateFromString:@"1900-01-01"];
    alert.datePicker4.date = [dateFormatter dateFromString:time.length?time:@"1990-01-01"];
    alert.datePicker4.maximumDate = [NSDate date];
    //回调
    if (handler) {
        alert.blockBack = handler;
    } else {
        __weak typeof(vc) _weakvc = vc;
        alert.blockBack = ^(NSMutableDictionary *para) {
            if ([para[@"index"] integerValue] == 0) {
                //取消
                [_weakvc dismissViewControllerAnimated:YES completion:nil];
            } else if ([para[@"index"] integerValue] == 1) {
                //确认
                [_weakvc dismissViewControllerAnimated:YES completion:nil];
            }
            return 1;
        };
    }
    alert.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [vc presentViewController:alert animated:YES completion:nil];
    return alert;
}

- (void)dealloc {
    //析构
#ifdef DEBUG
    NSLog(@"析构 %@", NSStringFromClass([self class]));
#endif
    
    self.blockBack = nil;
    
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self dataPrepare];
        [self customViewInit:self.view.bounds];
    }
    return self;
}

- (void)dataPrepare {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)customViewInit:(CGRect)viewRect {
    //创建
    
    //遮罩层
    _btnMask = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnMask.backgroundColor = [self R:0 G:0 B:0 A:0.4f];
    _btnMask.tag = CAlert_Button_Mask;
    [_btnMask addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnMask];
    
    //内容
    _content1 = [UIView alloc].init;
    _content1.backgroundColor = [UIColor whiteColor];
    _content1.layer.cornerRadius = 10;
    _content1.layer.masksToBounds = YES;
    _content1.hidden = YES;
    [self.view addSubview:_content1];
    if (_content1) {
        //图片
        _imgEdge1 = [UIImageView alloc].init;
        _imgEdge1.backgroundColor = [UIColor clearColor];
        _imgEdge1.image = [[self imgName:@"dialog_line@2x"] stretchableImageWithLeftCapWidth:14 topCapHeight:14];
        [_content1 addSubview:_imgEdge1];
        
        //标题
        _lbTitle1 = [UILabel alloc].init;
        _lbTitle1.backgroundColor = [UIColor clearColor];
        [_content1 addSubview:_lbTitle1];
        
        //提示内容
        _txtMessage1 = [UITextView alloc].init;
        _txtMessage1.backgroundColor = [UIColor clearColor];
        _txtMessage1.showsVerticalScrollIndicator = NO;
        _txtMessage1.showsHorizontalScrollIndicator = NO;
        _txtMessage1.bounces = NO;
        _txtMessage1.delegate = self;
        [_content1 addSubview:_txtMessage1];
        
        //确认
        _btnConfirm1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnConfirm1.backgroundColor = [UIColor clearColor];
        _btnConfirm1.tag = CAlert_Button_Confirm;
        _btnConfirm1.layer.cornerRadius = 39*0.5f;
        _btnConfirm1.layer.borderWidth = 1.0f;
        _btnConfirm1.layer.borderColor = [self R:42 G:131 B:211].CGColor;
        _btnConfirm1.layer.masksToBounds = YES;
        _btnConfirm1.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_btnConfirm1 setTitleColor:[self R:42 G:131 B:211] forState:UIControlStateNormal];
        [_btnConfirm1 setTitleColor:[self R:42 G:131 B:211] forState:UIControlStateHighlighted];
        [_btnConfirm1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_content1 addSubview:_btnConfirm1];
    }
    
    //内容
    _content2 = [UIView alloc].init;
    _content2.backgroundColor = [UIColor whiteColor];
    _content2.hidden = YES;
    [self.view addSubview:_content2];
    if (_content2) {
        //tableView
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView2.backgroundColor = [UIColor clearColor];
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        _tableView2.estimatedRowHeight = 0;
        _tableView2.estimatedSectionHeaderHeight = 0;
        _tableView2.estimatedSectionFooterHeight = 0;
        _tableView2.scrollEnabled = NO;
        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_content2 addSubview:_tableView2];
        [_tableView2 registerClass:[CAlertCell class] forCellReuseIdentifier:@"cellAlert"];
    }
    
    //内容
    _content3 = [UIView alloc].init;
    _content3.backgroundColor = [UIColor whiteColor];
    _content3.hidden = YES;
    [self.view addSubview:_content3];
    if (_content3) {
        //转子
        _activityIndicatorView3 = [UIActivityIndicatorView alloc].init;
        _activityIndicatorView3.backgroundColor = [UIColor redColor];
        _activityIndicatorView3.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        _activityIndicatorView3.hidesWhenStopped = YES;
        [_content3 addSubview:_activityIndicatorView3];
        
        //提示内容
        _lbMessage3 = [UILabel alloc].init;
        _lbMessage3.backgroundColor = [UIColor blueColor];
        _lbMessage3.font = [UIFont systemFontOfSize:16.0f];
        _lbMessage3.textColor = [UIColor whiteColor];
        _lbMessage3.textAlignment = NSTextAlignmentCenter;
        [_content3 addSubview:_lbMessage3];
    }
    
    //内容
    _content4 = [UIView alloc].init;
    _content4.backgroundColor = [self R:245 G:245 B:245];
    _content4.hidden = YES;
    [self.view addSubview:_content4];
    if (_content4) {
        //取消
        _btnCancel4 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCancel4.backgroundColor = [UIColor clearColor];
        _btnCancel4.tag = CAlert_Button_Cancel;
        _btnCancel4.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_btnCancel4 setTitleColor:[self R:42 G:131 B:211] forState:UIControlStateNormal];
        [_btnCancel4 setTitleColor:[self R:42 G:131 B:211] forState:UIControlStateHighlighted];
        [_btnCancel4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_content4 addSubview:_btnCancel4];
        
        //标题
        _lbTitle4 = [UILabel alloc].init;
        _lbTitle4.backgroundColor = [UIColor clearColor];
        _lbTitle4.font = [UIFont systemFontOfSize:16.0f];
        _lbTitle4.textColor = [UIColor darkGrayColor];
        _lbTitle4.textAlignment = NSTextAlignmentCenter;
        [_content4 addSubview:_lbTitle4];
        
        //确认
        _btnConfirm4 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnConfirm4.backgroundColor = [UIColor clearColor];
        _btnConfirm4.tag = CAlert_Button_Confirm;
        _btnConfirm4.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_btnConfirm4 setTitleColor:[self R:42 G:131 B:211] forState:UIControlStateNormal];
        [_btnConfirm4 setTitleColor:[self R:42 G:131 B:211] forState:UIControlStateHighlighted];
        [_btnConfirm4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_content4 addSubview:_btnConfirm4];
        
        //DatePicker
        _datePicker4 = [UIDatePicker alloc].init;
        _datePicker4.backgroundColor = [self R:209 G:213 B:219];
        _datePicker4.datePickerMode = UIDatePickerModeDate;//设置模式 这里是 年月日 没有上下午
        _datePicker4.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];//设置地区
        [_content4 addSubview:_datePicker4];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self resizeViews:self.view.bounds];
}

- (void)resizeViews:(CGRect)viewRect {
    //布局
    if (viewRect.size.width<1 || viewRect.size.height<1) {
        return;
    }
    
    //内容
    CGFloat message1_h = MIN(self.view.bounds.size.height*0.35f, [self rectString:_txtMessage1.text maxWidth:self.view.bounds.size.width-114.0f font:[UIFont systemFontOfSize:15.0f] lineSpacing:2.0f].size.height+16.0f);
    CGRect rect1 = viewRect;
    rect1.size.height = message1_h+68+91-8;
    rect1.origin.y = (viewRect.size.height-rect1.size.height)*0.5f;
    _content1.frame = CGRectInset(rect1, 35, 0);
    if (_content1) {
        CGRect rectContentBound = _content1.bounds;
        
        //图片
        CGRect rectEdge = rectContentBound;
        _imgEdge1.frame = CGRectInset(rectEdge, 3, 10);
        
        //标题
        CGRect rectTitle = rectContentBound;
        rectTitle.origin.y = 31.0f;
        rectTitle.size.height = 21.0f;
        _lbTitle1.frame = CGRectInset(rectTitle, 22, 0);
        
        //提示内容
        CGRect rectMessage = rectContentBound;
        rectMessage.origin.y = rectTitle.origin.y+rectTitle.size.height+8.0f;
        rectMessage.size.height = message1_h+1.0f;
        _txtMessage1.frame = CGRectInset(rectMessage, 14, 0);
        
        //确认
        CGRect rectConfirm = rectContentBound;
        rectConfirm.origin.y = rectMessage.origin.y+rectMessage.size.height+21.0f;
        rectConfirm.size.height = 39.0f;
        _btnConfirm1.frame = CGRectInset(rectConfirm, 22, 0);
    }
    
    //内容
    CGRect rect2 = viewRect;
    rect2.size.height = _msg2.count*50;
    rect2.size.height += _msg2.firstObject[@"tip"]?66.0f:0.0f;
    rect2.size.height += _msg2.firstObject[@"can"]?50.0f:0.0f;
    rect2.size.height += iSIPhoneX?34.0f:0.0f;
    rect2.origin.y = viewRect.size.height-rect2.size.height;
    _content2.frame = rect2;
    if (_content2) {
        CGRect rectContentBound = _content2.bounds;
        
        //tableView
        CGRect rectTableView = rectContentBound;
        rectTableView.size.height = rectContentBound.size.height-(iSIPhoneX?34.0f:0.0f);
        _tableView2.frame = rectTableView;
    }
    
    //内容
    _content3.frame = CGRectMake(0, 0, _content3_w, _content3_h);
    _content3.center = CGPointMake(viewRect.size.width*0.5f, _center3?viewRect.size.height*0.5f:viewRect.size.height-100.0f);
    if (_content3) {
        CGRect rectContentBound = _content3.bounds;
        
        //转子
        _activityIndicatorView3.frame = _activity3?CGRectMake(0, 0, 44, 44):CGRectZero;
        _activityIndicatorView3.center = CGPointMake(rectContentBound.size.width*0.5f, rectContentBound.origin.y+15+22);
        
        //提示内容
        CGRect rectMessage = rectContentBound;
        rectMessage.origin.y = _activity3?15+44.0f:15;
        rectMessage.size.height = 20.0f;
        _lbMessage3.frame = CGRectInset(rectMessage, 12, 0);
    }
    
    //内容
    _content4.frame = CGRectMake(0, viewRect.size.height-240.0f, viewRect.size.width, 240.0f);
    if (_content4) {
        CGRect rectContentBound = _content4.bounds;
        
        //取消
        CGRect rectCancel = rectContentBound;
        rectCancel.origin.x = 10.0f;
        rectCancel.size.width = 60.0f;
        rectCancel.size.height = 40.0f;
        _btnCancel4.frame = rectCancel;
        
        //标题
        CGRect rectTitle = rectContentBound;
        rectTitle.origin.x = rectCancel.origin.x+rectCancel.size.width;
        rectTitle.size.width = rectContentBound.size.width-rectTitle.origin.x*2.0f;
        rectTitle.size.height = 40.0f;
        _lbTitle4.frame = rectTitle;
        
        //确认
        CGRect rectConfirm = rectContentBound;
        rectConfirm.origin.x = rectTitle.origin.x+rectTitle.size.width;
        rectConfirm.size.width = rectCancel.size.width;
        rectConfirm.size.height = 40.0f;
        _btnConfirm4.frame = rectConfirm;
        
        //DatePicker
        CGRect rectDatepicker = rectContentBound;
        rectDatepicker.origin.y = 40.0f;
        rectDatepicker.size.height = rectContentBound.size.height-rectDatepicker.origin.y;
        _datePicker4.frame = rectDatepicker;
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _msg2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CAlertCell *cell = [_tableView2 dequeueReusableCellWithIdentifier:@"cellAlert" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    NSMutableDictionary *dictRow = _msg2[indexPath.row];
    NSString *msg1 = dictRow[@"msg"];
    NSString *submsg1 = dictRow[@"submsg"];
    
    //textLabel
    if (submsg1.length) {
        NSMutableAttributedString *attributedStr = [NSMutableAttributedString alloc].init;
        NSDictionary *dict1 = @{NSForegroundColorAttributeName:[self color:@"212121"],
                                NSFontAttributeName:[UIFont systemFontOfSize:16.0f]};
        NSDictionary *dict2 = @{NSForegroundColorAttributeName:[self color:@"999999"],
                                NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
        NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc] initWithString:msg1 attributes:dict1];
        [attributedStr appendAttributedString:attributedStr1];
        NSMutableAttributedString *attributedStr2 = [[NSMutableAttributedString alloc] initWithString:submsg1 attributes:dict2];
        [attributedStr appendAttributedString:attributedStr2];
        cell.lbMessage.attributedText = attributedStr;
        cell.lbMessage.textAlignment = NSTextAlignmentCenter;
    } else {
        cell.lbMessage.text = msg1;
        cell.lbMessage.textColor = [self color:@"212121"];
        cell.lbMessage.textAlignment = NSTextAlignmentCenter;
        cell.lbMessage.font = [UIFont systemFontOfSize:16.0f];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _msg2.firstObject[@"tip"]?66.0f:CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return _msg2.firstObject[@"can"]?50.0f:CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!_msg2.count || !_msg2.firstObject[@"tip"]) {
        return nil;
    }
    
    //headerView
    UIView *headerView = [UIView alloc].init;
    headerView.backgroundColor = [UIColor clearColor];
    headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 66.0f);
    
    //Tip
    UILabel *lbTip = [UILabel alloc].init;
    lbTip.backgroundColor = [UIColor clearColor];
    lbTip.frame = CGRectMake(0, 0, self.view.bounds.size.width, 66.0f);
    NSString *tip1 = _msg2.firstObject[@"tip"];
    NSString *subtip1 = _msg2.firstObject[@"subtip"];
    NSMutableAttributedString *attributedStr = [NSMutableAttributedString alloc].init;
    NSMutableParagraphStyle *paragraphStyle1 = [NSMutableParagraphStyle alloc].init;
    paragraphStyle1.lineSpacing = 5;
    paragraphStyle1.alignment = NSTextAlignmentCenter;
    NSDictionary *dict1 = @{NSForegroundColorAttributeName:[self color:@"67727e"],
                            NSFontAttributeName:[UIFont systemFontOfSize:16.0f],
                            NSParagraphStyleAttributeName:paragraphStyle1};
    NSMutableParagraphStyle *paragraphStyle2 = [NSMutableParagraphStyle alloc].init;
    paragraphStyle2.alignment = NSTextAlignmentCenter;
    NSDictionary *dict2 = @{NSForegroundColorAttributeName:[self color:@"a1a9b3"],
                            NSFontAttributeName:[UIFont systemFontOfSize:12.0f],
                            NSParagraphStyleAttributeName:paragraphStyle2};
    NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc] initWithString:tip1 attributes:dict1];
    [attributedStr appendAttributedString:attributedStr1];
    if (subtip1.length) {
        NSMutableAttributedString *attributedStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", subtip1] attributes:dict2];
        [attributedStr appendAttributedString:attributedStr2];
    }
    lbTip.attributedText = attributedStr;
    lbTip.numberOfLines = 0;
    [headerView addSubview:lbTip];
    
    //线
    UIView *lineView = [UIView alloc].init;
    lineView.backgroundColor = [self color:@"e1e2e5"];
    lineView.frame = CGRectMake(0, 66-1, self.view.bounds.size.width, 1);
    [headerView addSubview:lineView];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (!_msg2.count || !_msg2.firstObject[@"can"]) {
        return nil;
    }
    
    //footerView
    UIView *footerView = [UIView alloc].init;
    footerView.backgroundColor = [self color:@"f0f1f5"];
    footerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50.0f);
    
    //Can
    UIButton *btnCan = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCan.backgroundColor = [UIColor clearColor];
    btnCan.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50.0f);
    btnCan.tag = CAlert_Button_Cancel;
    btnCan.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btnCan setTitle:_msg2.firstObject[@"can"] forState:UIControlStateNormal];
    [btnCan setTitleColor:[self color:@"212121"] forState:UIControlStateNormal];
    [btnCan addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btnCan];
    
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dictRow = _msg2[indexPath.row];
    if (_blockBack) {
        _blockBack(dictRow);
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return NO;
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
    return [self color:color alpha:1.0f];
}

- (UIColor *)color:(NSString *)color alpha:(CGFloat)alpha {
    //十六进制颜色码
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    cString = [cString hasPrefix:@"#"]?[cString substringFromIndex:1]:cString;
    if (cString.length == 6) {
        NSRange range;
        range.length = 2;
        range.location = 0;
        NSString *rString = [cString substringWithRange:range];
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        //
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        return [self R:r G:g B:b A:alpha];
    }
    return [UIColor blackColor];
}

- (UIImage *)imgName:(NSString *)name {
    //获取本地图片
    return [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"C" ofType:@"bundle"]] pathForResource:name ofType:@"png"]];
}

- (CGRect)rectString:(NSString *)str maxWidth:(CGFloat)width font:(UIFont *)font {
    //rect计算
    NSDictionary *dict = @{NSFontAttributeName:font};
    return [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
}

- (CGRect)rectString:(NSString *)str maxWidth:(CGFloat)width font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    //rect计算 + 行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary *dict = @{NSFontAttributeName:font,
                           NSParagraphStyleAttributeName:paragraphStyle};
    return [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
}

- (CGFloat)heightMessage:(NSString *)msg {
    //_txtMessage1高度
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle alloc].init;
    paragraphStyle.lineSpacing = 2.0f;
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],
                 NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = [msg boundingRectWithSize:CGSizeMake(self.view.bounds.size.width-114, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    return MIN(self.view.bounds.size.height*0.35f, size.height+16.0f);
}

- (IBAction)btnClick:(id)sender {
    NSInteger tag = [sender tag];
    if (tag == CAlert_Button_Mask || tag == CAlert_Button_Cancel) {
        //遮罩层 取消
        if (_blockBack) {
            NSMutableDictionary *para = [NSMutableDictionary dictionary];
            para[@"index"] = @(0);
            _blockBack(para);
        }
    } else if (tag == CAlert_Button_Confirm) {
        //确认
        if (_blockBack) {
            NSMutableDictionary *para = [NSMutableDictionary dictionary];
            para[@"index"] = @(1);
            NSDateFormatter *dateFormatter = [NSDateFormatter alloc].init;
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            para[@"time"] = [dateFormatter stringFromDate:[_datePicker4 date]];
            _blockBack(para);
        }
    }
}

@end
