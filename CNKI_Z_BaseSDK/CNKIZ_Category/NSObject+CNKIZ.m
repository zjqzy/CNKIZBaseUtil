//
//  NSObject+Association.m
//

#import <objc/runtime.h>

#import "NSObject+CNKIZ.h"

@implementation NSObject (CNKIZ)

static char associatedObjectsKey;

- (id)associatedObjectForKey:(NSString*)key {
    
    // key 不能为nil 或 空
    if ([key length]<1) {
        return nil;
    }
    
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associatedObjectsKey);
    return [dict objectForKey:key];
}

- (void)setAssociatedObject:(id)object forKey:(NSString*)key
{
    // object 为 nil ，相当于删除
    // key 不能为nil 或 空
    
    
    if ([key length]<1) {
        return;
    }
    
    
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associatedObjectsKey);
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
        
        /*
         key：要保证全局唯一，key与关联的对象是一一对应关系。必须全局唯一。通常用@selector(methodName)作为key。
         value：要关联的对象。
         policy：关联策略。有五种关联策略。
         OBJC_ASSOCIATION_ASSIGN 等价于 @property(assign)。
         OBJC_ASSOCIATION_RETAIN_NONATOMIC等价于 @property(strong, nonatomic)。
         OBJC_ASSOCIATION_COPY_NONATOMIC等价于@property(copy, nonatomic)。
         OBJC_ASSOCIATION_RETAIN等价于@property(strong,atomic)。
         OBJC_ASSOCIATION_COPY等价于@property(copy, atomic)。
         */
        objc_setAssociatedObject(self, &associatedObjectsKey, dict, OBJC_ASSOCIATION_RETAIN);
    }
    
    dict[key]=object;
}

@end
