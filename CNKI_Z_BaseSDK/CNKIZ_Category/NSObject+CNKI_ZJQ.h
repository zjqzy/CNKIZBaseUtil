//
//  NSObject+CNKI_ZJQ.h
//
//  Created by zhu jianqi.
//  Email : zhu.jian.qi@163.com

#import <Foundation/Foundation.h>

@interface NSObject (CNKI_ZJQ)

/**
 关联对象 - 读取

 @param key 字符串 ， key 不能为nil 或 空
 @return 返回对象
 */
- (id)associatedObjectForKey:(NSString*)key;


/**
 关联对象 - 写入

 @param object 对象obj ， 如果传 nil， 相当于 清除
 @param key 字符串 ， key 不能为nil 或 空
 
 */
- (void)setAssociatedObject:(id)object forKey:(NSString*)key;

@end
