//
//  NSString+CNKIZ.m
//


#import "NSString+CNKIZ.h"
#import "CNKIZ_GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#define gIv             @"0123456789012345" //自行修改16位 -->偏移量

@implementation NSString (CNKIZ)

- (NSNumber*)stringToNSNumber
{
	NSNumberFormatter* tmpFormatter = [[NSNumberFormatter alloc] init];
	[tmpFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber* theNumber = [tmpFormatter numberFromString:self];
    
#if !__has_feature(objc_arc)
    [tmpFormatter release];
#endif
	return theNumber;
}

- (BOOL)isEmpty
{
    if ([self length] <= 0 || self == (id)[NSNull null] || self == nil) {
        return YES;
    }
    return NO;
}

- (unsigned long)wordsCount
{
    NSUInteger i,n = [self length], l = 0, a = 0, b = 0;
    unichar c;
    for(i = 0;i < n; i++)
    {
        c = [self characterAtIndex:i];
        if(isblank(c))
        {
            b++;
        }else if(isascii(c))
        {
            a++;
        }else{
            l++;
        }
    }
    if(a == 0 && l == 0) return 0;
    return l + (int)ceilf((float)(a + b) / 2.0);
}

- (NSString *)URLEncodedString
{
    //NSString 的 stringByAddingPercentEscapesUsingEncoding 可以对 url 参数进行编码，但是有点小问题，不会对所有需要编码的字符都编码。我们可以通过  CFStringRef 的
    
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self,NULL,CFSTR("!*'();:@&=+$,/?%#[]"),kCFStringEncodingUTF8));
    return result;
}

- (NSString *)URLDecodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)self,CFSTR(""),kCFStringEncodingUTF8));
    return result;
}

- (NSString *)encodeStringWithUTF8
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    const char *c =  [self cStringUsingEncoding:encoding];
    NSString *str = [NSString stringWithCString:c encoding:NSUTF8StringEncoding];
    
    return str;
}

- (NSUInteger)byteLengthWithEncoding:(NSStringEncoding)encoding
{
    if (!self)
    {
        return 0;
    }
    
    const char *byte = [self cStringUsingEncoding:encoding];
    return strlen(byte);
}

////////////////////////////////////////////////////////////////////////////////
//////////////////    encrypt  ///////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- (NSString *)stringFromMD5
{
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

-(NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSString*)stringToSha1:(NSString*)str
{
    const char *s = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    // This is the destination
    uint8_t digest[CC_SHA1_DIGEST_LENGTH] = {0};
    // This one function does an unkeyed SHA1 hash of your hash data
    CC_SHA1(keyData.bytes, (CC_LONG)keyData.length, digest);
	
    // Now convert to NSData structure to make it usable again
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [out description];
	
	NSCharacterSet *doNotWants = [NSCharacterSet characterSetWithCharactersInString:@"<> "];
	hash = [[hash componentsSeparatedByCharactersInSet:doNotWants] componentsJoinedByString:@""];
	
    return hash;
}
-(NSString*)sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    // This is the destination
    uint8_t digest[CC_SHA1_DIGEST_LENGTH] = {0};
    //uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    // This one function does an unkeyed SHA1 hash of your hash data
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


- (NSString *)sha1_base64
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    base64 = [CNKIZ_GTMBase64 encodeData:base64];
    
    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    return output ;
}

- (NSString *)md5_base64
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    base64 = [CNKIZ_GTMBase64 encodeData:base64];
    
    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    return output;
}

- (NSString *)base64
{
    //NSData *data = [self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [CNKIZ_GTMBase64 encodeData:data];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return output;
}

- (NSString *)decode_base64 {
    //NSData *data = [self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [CNKIZ_GTMBase64 decodeData:data];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return output;
}

-(NSString *)encryptUseDESWithRgbKey:(NSString*)rgbKey withRgbIV:(Byte*)rgbIV
{
    //kCCOptionPKCS7Padding|kCCOptionECBMode, 这块参数，可能导致最终值不一样
    
    NSString *ciphertext = nil;
    const char *textBytes = [self UTF8String];
    NSUInteger dataLength = [self length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    //Byte iv[] = {1,2,3,4,5,6,7,8};
    //Byte iv[] ={ 0x16, 0x34, 0x56, 0x58, 0x88, 0xAB, 0xCD, 0xEF };
    //Byte iv[] ={ 0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF };
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [rgbKey UTF8String], kCCKeySizeDES,
                                          rgbIV,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    
    
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [[NSString alloc] initWithData:[CNKIZ_GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }
    return ciphertext;
}
-(NSString *)decryptUseDESWithRgbKey:(NSString*)rgbKey withRgbIV:(Byte*)rgbIV
{
    //注意和上面的参数一致
    NSData* cipherData = [CNKIZ_GTMBase64 decodeString:self];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [rgbKey UTF8String],
                                          kCCKeySizeDES,
                                          rgbIV,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}
- (NSString *)encryptUseDESWithKey:(NSString*)key
{
    NSString *ciphertext = nil;
    const char *textBytes = [self UTF8String];
    NSUInteger dataLength = [self length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    Byte iv[] = {1,2,3,4,5,6,7,8};
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    
    
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [[NSString alloc] initWithData:[CNKIZ_GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }
    return ciphertext;
}
- (NSString *)decryptUseDESWithKey:(NSString*)key
{
    NSData* cipherData = [CNKIZ_GTMBase64 decodeString:self];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}
- (NSString *)encryptUseDES:(NSString *)plainText key:(NSString*)key
{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    Byte iv[] = {1,2,3,4,5,6,7,8};
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    
    
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [[NSString alloc] initWithData:[CNKIZ_GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }
    return ciphertext;
}

- (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString*)key
{
    NSData* cipherData = [CNKIZ_GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}

- (NSString *)aes128Encrypt:(NSString *)aKey
{
    
    char keyPtr[kCCKeySizeAES128+1];
    
    memset(keyPtr, 0, sizeof(keyPtr));
    
    [aKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    char ivPtr[kCCBlockSizeAES128+1];
    
    memset(ivPtr, 0, sizeof(ivPtr));
    
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    
    int newSize = 0;
    
    
    
    if(diff > 0)
        
    {
        
        newSize = (int)dataLength + diff;
        
    }
    
    char dataPtr[newSize];
    
    memcpy(dataPtr, [data bytes], [data length]);
    
    for(int i = 0; i < diff; i++)
        
    {
        
        dataPtr[i + dataLength] = 0x00;
        
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    memset(buffer, 0, bufferSize);
    
    
    size_t numBytesCrypted = 0;
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,  // 补码方式
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        NSData *result = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        if (result && result.length > 0) {
            
            
            Byte *datas = (Byte*)[result bytes];
            
            NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
            
            for(int i = 0; i < result.length; i++){
                
                [output appendFormat:@"%02x", datas[i]];
                
            }
            
            return output;
            
        }
        
    }
    
    free(buffer);
    
    return nil;
    
}

- (NSString *)aes128Decrypt:(NSString *)aKey
{
    
    char keyPtr[kCCKeySizeAES128 + 1];
    
    memset(keyPtr, 0, sizeof(keyPtr));
    
    [aKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    
    memset(ivPtr, 0, sizeof(ivPtr));
    
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    
    
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    
    unsigned char whole_byte;
    
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    
    for (i=0; i < [self length] / 2; i++) {
        
        byte_chars[0] = [self characterAtIndex:i*2];
        
        byte_chars[1] = [self characterAtIndex:i*2+1];
        
        whole_byte = strtol(byte_chars, NULL, 16);
        
        [data appendBytes:&whole_byte length:1];
        
    }
    
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        
    }
    
    free(buffer);
    
    return nil;
    
}

-(BOOL)isValidEmailAddress
{
    //是否为邮箱格式
    // http://stackoverflow.com/questions/3139619/check-that-an-email-address-is-valid-on-ios
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
/////////////////////////////////////////////
///////////      正则    ////////////
/////////////////////////////////////////////
#pragma mark - 正则
-(NSString *) stringByReplacingRegexPattern:(NSString *)regex withString:(NSString *) replacement caseInsensitive:(BOOL)ignoreCase {
    return [self stringByReplacingRegexPattern:regex withString:replacement caseInsensitive:ignoreCase treatAsOneLine:NO];
}

-(NSString *) stringByReplacingRegexPattern:(NSString *)regex withString:(NSString *) replacement caseInsensitive:(BOOL) ignoreCase treatAsOneLine:(BOOL) assumeMultiLine {
    
    NSUInteger options=0;
    if (ignoreCase) {
        options = options | NSRegularExpressionCaseInsensitive;
    }
    if (assumeMultiLine) {
        options = options | NSRegularExpressionDotMatchesLineSeparators;
    }
    
    NSError *error=nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:&error];
    if (error) {
        NSLog(@"Error creating Regex: %@",[error description]);
        return nil;
    }
    
    NSString *retVal= [pattern stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:replacement];
    return retVal;
}

-(NSString *) stringByReplacingRegexPattern:(NSString *)regex withString:(NSString *) replacement {
    return [self stringByReplacingRegexPattern:regex withString:replacement caseInsensitive:NO treatAsOneLine:NO];
}

-(NSArray *) stringsByExtractingGroupsUsingRegexPattern:(NSString *)regex caseInsensitive:(BOOL) ignoreCase treatAsOneLine:(BOOL) assumeMultiLine {
    NSUInteger options=0;
    if (ignoreCase) {
        options = options | NSRegularExpressionCaseInsensitive;
    }
    if (assumeMultiLine) {
        options = options | NSRegularExpressionDotMatchesLineSeparators;
    }
    
    NSError *error=nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:&error];
    if (error) {
        NSLog(@"Error creating Regex: %@",[error description]);
        return nil;
    }
    
    __block NSMutableArray *retVal = [NSMutableArray array];
    [pattern enumerateMatchesInString:self options:0 range:NSMakeRange(0, [self length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        //Note, we only want to return the things in parens, so we're skipping index 0 intentionally
        for (int i=1; i<[result numberOfRanges]; i++) {
            NSString *matchedString=[self substringWithRange:[result rangeAtIndex:i]];
            [retVal addObject:matchedString];
        }
    }];
    return retVal;
}

-(NSArray *) stringsByExtractingGroupsUsingRegexPattern:(NSString *)regex {
    return [self stringsByExtractingGroupsUsingRegexPattern:regex caseInsensitive:NO treatAsOneLine:NO];
}

-(BOOL) matchesPatternRegexPattern:(NSString *)regex caseInsensitive:(BOOL) ignoreCase treatAsOneLine:(BOOL) assumeMultiLine {
    NSUInteger options=0;
    if (ignoreCase) {
        options = options | NSRegularExpressionCaseInsensitive;
    }
    if (assumeMultiLine) {
        options = options | NSRegularExpressionDotMatchesLineSeparators;
    }
    
    NSError *error=nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:&error];
    if (error) {
        NSLog(@"Error creating Regex: %@",[error description]);
        return NO;  //Can't possibly match an invalid Regex
    }
    
    return ([pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])] > 0);
}

-(BOOL) matchesPatternRegexPattern:(NSString *)regex {
    return [self matchesPatternRegexPattern:regex caseInsensitive:NO treatAsOneLine:NO];
}

@end
