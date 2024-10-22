//
//  NSString+MdStr.h
//  File Hash
//
//  Created by iOS on 2024/7/12.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MdStr)

- (NSString *)stringToMD5;

- (NSString *)morseCodeRepresentation;


+ (NSString *)decodeMorseCode:(NSString *)morseCodeString;


@end

NS_ASSUME_NONNULL_END
