//
//  NSString+MdStr.m
//  File Hash
//
//  Created by iOS on 2024/7/12.
//
#import <CoreFoundation/CoreFoundation.h>
#import "NSString+MdStr.h"

@implementation NSString (MdStr)


- (NSString *)stringToMD5{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}



// 摩斯电码映射（示例）
static NSDictionary<NSString *, NSString *> *morseCodeMap = nil;

static NSDictionary<NSString *, NSString *> *morseCodeTable = nil;






+ (void)initialize {
    if (self == [NSString class]) {
        morseCodeMap = @{
            @"A": @".-", @"B": @"-...", @"C": @"-.-.", @"D": @"-..",
            @"E": @".", @"F": @"..-.", @"G": @"--.", @"H": @"....",
            @"I": @"..", @"J": @".---", @"K": @"-.-", @"L": @".-..",
            @"M": @"--", @"N": @"-.", @"O": @"---", @"P": @".--.",
            @"Q": @"--.-", @"R": @".-.", @"S": @"...", @"T": @"-",
            @"U": @"..-", @"V": @"...-", @"W": @".--", @"X": @"-..-",
            @"Y": @"-.--", @"Z": @"--..",
            @"0": @"-----", @"1": @".----", @"2": @"..---", @"3": @"...--",
            @"4": @"....-", @"5": @".....", @"6": @"-....", @"7": @"--...",
            @"8": @"---..", @"9": @"----.",
            @" ": @"/" // 通常用斜杠("/")或空格来表示单词间隔
        };
        
        morseCodeTable = @{
            @".-"   : @"A",
            @"-..." : @"B",
            @"-.-." : @"C",
            @"-.."  : @"D",
            @"."    : @"E",
            @"..-." : @"F",
            @"--."  : @"G",
            @"...." : @"H",
            @".."   : @"I",
            @".---" : @"J",
            @"-.-"  : @"K",
            @".-.." : @"L",
            @"--"   : @"M",
            @"-."   : @"N",
            @"---"  : @"O",
            @".--." : @"P",
            @"--.-" : @"Q",
            @".-."  : @"R",
            @"..."  : @"S",
            @"-"    : @"T",
            @"..-"  : @"U",
            @"..."  : @"V", // 注意：V 和 S 在摩斯电码中都是 "..."
            @".--"  : @"W",
            @"-.-"  : @"X", // 注意：X 和 K 在摩斯电码中非常相似，但最后一个点不同
            @"-.."  : @"Y", // 注意：Y 和 D 在摩斯电码中非常相似，但 Y 前面没有点
            @"--.." : @"Z",
            @".----": @"1",
            @"..---": @"2",
            @"...--": @"3",
            @"....-": @"4",
            @".....": @"5",
            @"-....": @"6",
            @"--...": @"7",
            @"---..": @"8",
            @"----.": @"9",
            @".-.-.-": @".", // 句点
            @"--..--": @",", // 逗号
            @"..--..": @"?", // 问号
            @"-.-.--": @"!", // 感叹号
            @"-....-": @"/", // 斜杠
            @"(.-.)": @"(", // 左括号（通常不是标准摩斯电码，但可以用国际电信联盟建议的方式表示）
        };
        
    }
}

- (NSString *)morseCodeRepresentation {
    NSMutableString *morseCode = [NSMutableString string];
    
    // 将字符串转换为大写（可选，因为映射不区分大小写）
    NSString *upperString = [self uppercaseString];
    
    for (NSUInteger i = 0; i < [upperString length]; i++) {
        unichar character = [upperString characterAtIndex:i];
        NSString *characterString = [NSString stringWithFormat:@"%C", character];
        
        // 查找字符的摩斯电码
        NSString *morse = morseCodeMap[characterString];
        if (morse) {
            [morseCode appendString:morse];
            // 如果不是最后一个字符，并且不是空格（即单词分隔符），则添加空格分隔
            if (i < [upperString length] - 1 && [characterString isEqualToString:@" "]) {
                // 这里通常不需要添加分隔符，因为空格已经是分隔符
            } else {
                [morseCode appendString:@" "];
            }
        }
    }
    
    // 移除最后一个多余的空格（如果存在）
    if ([morseCode length] > 0 && [[morseCode substringFromIndex:[morseCode length] - 1] isEqualToString:@" "]) {
        [morseCode deleteCharactersInRange:NSMakeRange([morseCode length] - 1, 1)];
    }
    
    return morseCode;
}





+ (NSString *)decodeMorseCode:(NSString *)morseCodeString {
    // 标准化摩斯电码字符串（如果有必要的话）
    NSString *normalizedMorseCode = [self normalizeMorseCode:morseCodeString];
    
    // 分割摩斯电码字符串为单个电码单元
    // 这里假设空格用作分隔符，可能需要根据实际情况调整
    NSArray<NSString *> *morseUnits = [normalizedMorseCode componentsSeparatedByString:@" "];
    
    NSMutableString *decodedString = [NSMutableString string];
    
    for (NSString *unit in morseUnits) {
        // 查找并添加对应的字符
        NSString *decodedChar = morseCodeTable[unit];
        if (decodedChar) {
            [decodedString appendString:decodedChar];
        } else {
            // 如果找不到对应的电码，可以添加错误字符或跳过
            [decodedString appendString:@"?"];
        }
    }
    
    return decodedString;
}

// 用于将摩斯电码中的空格（或其他分隔符）替换为字典查找时所需的分隔符
// 这里假设使用单个空格作为摩斯电码中的分隔符
+ (NSString *)normalizeMorseCode:(NSString *)morseCode {
    // 根据实际情况替换分隔符，这里只是简单去除多余的空格
    return [morseCode stringByReplacingOccurrencesOfString:@"  " withString:@" "];
}





@end
