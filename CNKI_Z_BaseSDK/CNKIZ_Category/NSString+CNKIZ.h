//
//  NSString+CNKIZ.h
//
//  Created by zhu jianqi on 2018/9/20.
//  Copyright © 2018年 zhu jianqi. All rights reserved.
//  Email : zhu.jian.qi@163.com

#import <Foundation/Foundation.h>

@interface NSString (CNKIZ)

- (NSNumber*)stringToNSNumber;
- (BOOL)isEmpty;
/**
 *  计算字符串的字数。
 *  return  返回输入字符串的字数。
 */
- (unsigned long)wordsCount;

- (NSString *)URLDecodedString;
- (NSString *)URLEncodedString;
- (NSString *)encodeStringWithUTF8;
- (NSUInteger)byteLengthWithEncoding:(NSStringEncoding)encoding;


///////  encrypt  ///////////////////

- (NSString *)stringFromMD5;
- (NSString *)md5;
+ (NSString *)stringToSha1:(NSString*)str;
- (NSString *)sha1;
- (NSString *)sha1_base64;
- (NSString *)md5_base64;
- (NSString *)base64;
- (NSString *)decode_base64;

- (NSString *)encryptUseDESWithKey:(NSString*)key;
- (NSString *)decryptUseDESWithKey:(NSString*)key;

- (NSString *)encryptUseDESWithRgbKey:(NSString*)rgbKey withRgbIV:(Byte*)rgbIV;
- (NSString *)decryptUseDESWithRgbKey:(NSString*)rgbKey withRgbIV:(Byte*)rgbIV;

- (NSString *)aes128Encrypt:(NSString *)aKey;
- (NSString *)aes128Decrypt:(NSString *)aKey;
//////////////////////////////////////

- (BOOL)isValidEmailAddress; //是否为邮箱格式


/////////////////////////////////////////////
///////////      正则    ////////////
/////////////////////////////////////////////
-(NSString *) stringByReplacingRegexPattern:(NSString *)regex withString:(NSString *) replacement;
-(NSString *) stringByReplacingRegexPattern:(NSString *)regex withString:(NSString *) replacement caseInsensitive:(BOOL) ignoreCase;
-(NSString *) stringByReplacingRegexPattern:(NSString *)regex withString:(NSString *) replacement caseInsensitive:(BOOL) ignoreCase treatAsOneLine:(BOOL) assumeMultiLine;
-(NSArray *) stringsByExtractingGroupsUsingRegexPattern:(NSString *)regex;
-(NSArray *) stringsByExtractingGroupsUsingRegexPattern:(NSString *)regex caseInsensitive:(BOOL) ignoreCase treatAsOneLine:(BOOL) assumeMultiLine;
-(BOOL) matchesPatternRegexPattern:(NSString *)regex;
-(BOOL) matchesPatternRegexPattern:(NSString *)regex caseInsensitive:(BOOL) ignoreCase treatAsOneLine:(BOOL) assumeMultiLine;


@end
