//
//  NSData+CNKI_ZJQ.m
//

#include <CommonCrypto/CommonCrypto.h>  //算法
#import <zlib.h>    // 压缩

#import "NSData+CNKI_ZJQ.h"

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

#ifndef ZJQ_CX_SWAP // swap two value
#define ZJQ_CX_SWAP(_a_, _b_) do {__typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = (_tmp_); } while(0)
#endif

const NSUInteger CHUNK_SIZE=16384;

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

@implementation NSData (CNKI_ZJQ)

#pragma mark - 对象序列 转换
-(NSData*)dataWithObject:(id)object
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    return data;
}

-(id)convertDataToObject
{
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:self];
    return array;
}

#pragma mark - 压缩
-(NSData*)gzippedDataWithCompressionLevel:(float)level
{
    if ([self length])
    {
        z_stream stream;
        stream.zalloc = Z_NULL;
        stream.zfree = Z_NULL;
        stream.opaque = Z_NULL;
        stream.avail_in = (uint)[self length];
        stream.next_in = (Bytef *)[self bytes];
        stream.total_out = 0;
        stream.avail_out = 0;
        
        int compression = (level < 0.0f)? Z_DEFAULT_COMPRESSION: (int)roundf(level * 9);
        if (deflateInit2(&stream, compression, Z_DEFLATED, 31, 8, Z_DEFAULT_STRATEGY) == Z_OK)
        {
            NSMutableData *data = [NSMutableData dataWithLength:CHUNK_SIZE];
            while (stream.avail_out == 0)
            {
                if (stream.total_out >= [data length])
                {
                    data.length += CHUNK_SIZE;
                }
                stream.next_out = [data mutableBytes] + stream.total_out;
                stream.avail_out = (uint)([data length] - stream.total_out);
                deflate(&stream, Z_FINISH);
            }
            deflateEnd(&stream);
            data.length = stream.total_out;
            return data;
        }
    }
    return nil;
}
-(NSData*)gzippedData
{
    return [self gzippedDataWithCompressionLevel:-1.0f];
}
-(NSData*)gunzippedData
{
    if ([self length])
    {
        z_stream stream;
        stream.zalloc = Z_NULL;
        stream.zfree = Z_NULL;
        stream.avail_in = (uint)[self length];
        stream.next_in = (Bytef *)[self bytes];
        stream.total_out = 0;
        stream.avail_out = 0;
        
        NSMutableData *data = [NSMutableData dataWithLength: [self length] * 1.5];
        if (inflateInit2(&stream, 47) == Z_OK)
        {
            int status = Z_OK;
            while (status == Z_OK)
            {
                if (stream.total_out >= [data length])
                {
                    data.length += [self length] * 0.5;
                }
                stream.next_out = [data mutableBytes] + stream.total_out;
                stream.avail_out = (uint)([data length] - stream.total_out);
                status = inflate (&stream, Z_SYNC_FLUSH);
            }
            if (inflateEnd(&stream) == Z_OK)
            {
                if (status == Z_STREAM_END)
                {
                    data.length = stream.total_out;
                    return data;
                }
            }
        }
    }
    return nil;
}
#pragma mark - 原生base64
-(NSData*)base64_encode:(NSUInteger)option1
{
    return [self base64EncodedDataWithOptions:option1];

    //NSString * base64String = [sampleData base64EncodedStringWithOptions:0];
}
-(NSData*)base64_decode:(NSUInteger)option1
{
    NSString *base64String=[[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    return [[NSData alloc] initWithBase64EncodedString:base64String options:option1];
}

#pragma mark - 安全散列算法
#pragma mark - MD5:全称是 Message-Digest Algorithm 5 (信息-摘要算法，属于哈希算法)，128 位长度，目前 MD5 是一种不可逆算法，具有很高的安全性，它对应任何字符串都可以加密成一段唯一的固定长度的代码。一种被广泛使用的密码散列函数，可以产生出一个128位（16字节）的散列值（hash value）
-(NSString*)md5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

#pragma mark - SHA:全称是 Secure Hash Algorithm (安全哈希算法) ，SHA1 基于 MD5，加密后的数据长度更长，它对长度小于 264 的输入，产生长度为 160bit 的散列值。是一个密码散列函数家族，是FIPS所认证的安全散列算法。能计算出一个数字消息所对应到的，长度固定的字符串（又称消息摘要）的算法。且若输入的消息不同，它们对应到不同字符串的机率很高。SHA家族的算法，由美国国家安全局（NSA）所设计，并由美国国家标准与技术研究院（NIST）发布，是美国的政府标准

-(NSString*)sha1String {
    /*
     SHA-0：1993年发布，当时称做安全散列标准（Secure Hash Standard），发布之后很快就被NSA撤回，是SHA-1的前身。
     
     SHA-1：1995年发布，SHA-1在许多安全协议中广为使用，包括TLS和SSL、PGP、SSH、S/MIME和IPsec，曾被视为是MD5（更早之前被广为使用的散列函数）的后继者。但SHA-1的安全性在2000年以后已经不被大多数的加密场景所接受。
     2017年荷兰密码学研究小组CWI和Google正式宣布攻破了SHA-1
     */

    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

-(NSString*)sha224String {
    
    /*
     SHA-2：2001年发布，包括SHA-224、SHA-256、SHA-384、SHA-512、SHA-512/224、SHA-512/256。
     虽然至今尚未出现对SHA-2有效的攻击，它的算法跟SHA-1基本上仍然相似；因此有些人开始发展其他替代的散列算法。
     */
    unsigned char result[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

-(NSString*)sha256String {
    // SHA-2
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

-(NSString*)sha384String {
    // SHA-2
    unsigned char result[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

-(NSString*)sha512String {
    // SHA-2
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

-(NSString*)sha3String {
    /*
     SHA-3：2015年正式发布，SHA-3并不是要取代SHA-2，因为SHA-2目前并没有出现明显的弱点。
     由于对MD5出现成功的破解，以及对SHA-0和SHA-1出现理论上破解的方法，NIST感觉需要一个与之前算法不同的，可替换的加密散列算法，也就是现在的SHA-3。
     */
    
    return nil;
}
#pragma mark - HMAC:HMAC加密算法是一种安全的基于加密hash函数和共享密钥的消息认证协议． 它可以有效地防止数据在传输过程中被截获和篡改，维护了数据的完整性、可靠性和安全性. HMAC加密算法是一种基于密钥的报文完整性的验证方法，其安全性是建立在Hash加密算法基础上的
-(NSString*)hmacStringUsingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    unsigned char result[size];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(alg, cKey, strlen(cKey), self.bytes, self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:size * 2];
    for (int i = 0; i < size; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

-(NSString*)hmacMD5StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgMD5 withKey:key];
}

-(NSString*)hmacSHA1StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

-(NSString*)hmacSHA224StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

-(NSString*)hmacSHA256StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

-(NSString*)hmacSHA384StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

-(NSString*)hmacSHA512StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA512 withKey:key];
}

#pragma mark - 对称加密算法
#pragma mark - AES:AES256是美国NIST在几种加密算法竞赛中选出来的对称加密算法，是用于取代DES的，原名为Rijndael加密法，破解的报道相对少些。如果单纯从密码学上讲，要实现与AES256相当的加密强度，RSA加密算法长度要达到16384位，另外RSA1024目前已经不被认为是安全的加密算法了。
- (NSData*)AES256EncryptWithKey:(NSData *)key iv:(NSData *)iv {
    if (key.length != 16 && key.length != 24 && key.length != 32) return nil;
    if (iv.length != 16 && iv.length != 0) return nil;
    
    NSData *result = nil;
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) return nil;
    
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          iv.bytes,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc] initWithBytes:buffer length:(NSUInteger)encryptedSize];
        free(buffer);
        return result;
    } else {
        free(buffer);
        return nil;
    }
}

-(NSData*)AES256DecryptWithKey:(NSData *)key iv:(NSData *)iv {
    if (key.length != 16 && key.length != 24 && key.length != 32) return nil;
    if (iv.length != 16 && iv.length != 0) return nil;
    
    NSData *result = nil;
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) return nil;
    
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          iv.bytes,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc] initWithBytes:buffer length:(NSUInteger)encryptedSize];
        free(buffer);
        return result;
    } else {
        free(buffer);
        return nil;
    }
}
#pragma mark - RC4:是一种流加密算法，密钥长度可变。它加解密使用相同的密钥，因此也属于对称加密算法。

-(NSData*)rc4WithKey:(NSString *)key {
    int j = 0;
    unichar res[self.length];
    const unichar *buffer = res;
    unsigned char s[256];
    for (int i = 0; i < 256; i++) {
        s[i] = i;
    }
    for (int i = 0; i < 256; i++) {
        j = (j + s[i] + [key characterAtIndex:(i%key.length)])%256;
        ZJQ_CX_SWAP(s[i], s[j]);
    }
    int i = j = 0;
    NSString *strSelf=[[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    for (int y = 0; y < self.length; y++) {
        i = (i + 1) % 256;
        j = (j + 1) % 256;
        ZJQ_CX_SWAP(s[i], s[j]);
        
        unsigned char f = [strSelf characterAtIndex:y] ^ s[ (s[i] + s[j]) % 256 ];
        res[y] = f;
    }
    return [[NSData alloc] initWithBytes:buffer length:self.length];
    //return [NSString stringWithCharacters:buffer length:self.length];
}

@end
