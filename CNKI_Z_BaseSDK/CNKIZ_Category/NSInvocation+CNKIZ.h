//
//  NSInvocation+SimpleCreation.h
//


#import <Foundation/Foundation.h>

@interface NSInvocation (CNKIZ)

+ (NSInvocation*)invocationWithTarget:(id)target andSelector:(SEL)selector;
+ (NSInvocation*)invocationWithTarget:(id)target selector:(SEL)selector andArguments:(NSArray*)arguments;

@end
