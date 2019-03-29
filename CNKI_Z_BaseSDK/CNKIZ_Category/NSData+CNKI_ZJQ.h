//
//  NSData+CNKI_ZJQ.h
//
//  Created by zhu jianqi.
//  Email : zhu.jian.qi@163.com

#import <Foundation/Foundation.h>


@interface NSData (CNKI_ZJQ)


/*
 对象序列 转换
 */
- (NSData *)dataWithObject:(id)object;
- (id)convertDataToObject;


/*
 zip 压缩
 */
- (NSData *)gzippedDataWithCompressionLevel:(float)level;
- (NSData *)gzippedData;
- (NSData *)gunzippedData;

/*
 base64 原生
 */
-(NSData*)base64_encode:(NSUInteger)option1;
-(NSData*)base64_decode:(NSUInteger)option1;

/*
 安全散列算法
 */
-(NSString*)md5String;

-(NSString*)sha1String;
-(NSString*)sha224String;
-(NSString*)sha256String;
-(NSString*)sha384String;
-(NSString*)sha512String;

-(NSString*)hmacMD5StringWithKey:(NSString*)key;
-(NSString*)hmacSHA1StringWithKey:(NSString *)key;
-(NSString*)hmacSHA224StringWithKey:(NSString *)key;
-(NSString*)hmacSHA256StringWithKey:(NSString *)key;
-(NSString*)hmacSHA384StringWithKey:(NSString *)key;
-(NSString*)hmacSHA512StringWithKey:(NSString *)key;


/*
 对称加密
 */
-(NSData*)AES256EncryptWithKey:(NSData *)key iv:(NSData *)iv;
-(NSData*)AES256DecryptWithKey:(NSData *)key iv:(NSData *)iv;

-(NSData*)rc4WithKey:(NSString *)key;




@end
