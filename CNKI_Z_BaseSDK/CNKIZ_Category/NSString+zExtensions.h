//
//  NSString+zExtensions.h
//  CNKIMDL
//
//  Created by zhu on 13-10-30.
//  Copyright (c) 2013年 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
//zExtensions
@interface NSString (zExtensions)

- (NSNumber*)stringToNSNumber;
- (BOOL)isEmpty;
/**
 *  计算字符串的字数。
 *  @param  string:输入字符串。
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

@end
