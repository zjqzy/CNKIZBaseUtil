//
//  CAlertController.h
//


#import <UIKit/UIKit.h>

@interface CAlertController : UIViewController

/**
 系统提示框 关闭

 @param vc           父窗体
 @param title        标题
 @param msg          提示内容
 @param handlerClose 回调
 */
+ (void)alert:(UIViewController *)vc title:(NSString *)title message:(NSString *)msg handlerClose:(void (^)(UIAlertAction *action))handlerClose;

/**
 系统提示框 一个Action

 @param vc      父窗体
 @param title   标题
 @param msg     提示内容
 @param confirm 确认
 @param handler 回调
 */
+ (void)alert:(UIViewController *)vc title:(NSString *)title message:(NSString *)msg confirm:(NSString *)confirm handler:(void (^)(UIAlertAction *action))handler;

/**
 系统提示框 两个Action

 @param vc             父窗体
 @param title          标题
 @param msg            提示内容
 @param cancel         取消
 @param confirm        确认
 @param handlerCancel  回调
 @param handlerConfirm 回调
 */
+ (void)alert:(UIViewController *)vc title:(NSString *)title message:(NSString *)msg cancel:(NSString *)cancel confirm:(NSString *)confirm handlerCancel:(void (^)(UIAlertAction *action))handlerCancel handlerConfirm:(void (^)(UIAlertAction *action))handlerConfirm;

/**
 系统提示框 Sheet

 @param vc      父窗体
 @param title   标题
 @param msg     提示内容 格式:@[@{@"msg":@"a"}]
 @param cancel  取消
 @param handler 回调
 */
+ (void)alertSheet:(UIViewController *)vc title:(NSString *)title message:(NSMutableArray *)msg cancel:(NSString *)cancel handler:(int (^)(NSMutableDictionary *para))handler;

/**
 自定义提示框 一个Action
 
 @param vc      父窗体
 @param title   标题
 @param msg     提示内容
 @param center  是否居中
 @param confirm 确认
 @param handler 回调
 @return 消息VC
 */
+ (instancetype)alertCustom:(UIViewController *)vc title:(NSString *)title message:(NSString *)msg center:(BOOL)center confirm:(NSString *)confirm handler:(int (^)(NSMutableDictionary *para))handler;

/**
 自定义提示框 Sheet

 @param vc      父窗体
 @param msg     提示内容
 @param handler 回调
 @return 消息VC
 */
+ (instancetype)alertCustomSheet:(UIViewController *)vc message:(NSMutableArray *)msg handler:(int (^)(NSMutableDictionary *para))handler;

/**
 自定义提示框 HUD

 @param vc       父窗体
 @param msg      提示内容
 @param activity 转子
 @param center   居中
 @param delay    隐藏
 @return 消息VC
 */
+ (instancetype)alertHUD:(UIViewController *)vc message:(NSString *)msg activity:(BOOL)activity center:(BOOL)center hideAfter:(NSTimeInterval)delay;
+ (void)closeHUD:(UIViewController *)vc;

/**
 自定义提示框 DatePicker

 @param vc      父窗体
 @param title   标题
 @param time    时间
 @param cancel  取消
 @param confirm 确认
 @param handler 回调
 @return 消息VC
 */
+ (instancetype)alertCustomDatePicker:(UIViewController *)vc title:(NSString *)title time:(NSString *)time cancel:(NSString *)cancel confirm:(NSString *)confirm handler:(int (^)(NSMutableDictionary *para))handler;

@end
