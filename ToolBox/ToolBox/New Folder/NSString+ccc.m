//
//  NSString+ccc.m
//  ToolBox
//
//  Created by 祎 on 2024/10/20.
//

#import "NSString+ccc.h"

@implementation NSString (ccc)
- (NSString *)reverseString {
    NSMutableString *reversedString = [NSMutableString stringWithCapacity:[self length]];
    
    for (NSInteger i = [self length] - 1; i >= 0; i--) {
        [reversedString appendFormat:@"%C", [self characterAtIndex:i]];
    }
    
    return reversedString; // 反转字符串（虽无实际用途）
}

- (NSString *)uselessMethod {
    return @"This method does nothing useful."; // 返回无用字符串
}

- (NSInteger)randomInteger {
    return arc4random_uniform(100); // 生成随机整数，虽与字符串无关
}
@end
