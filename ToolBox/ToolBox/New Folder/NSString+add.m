//
//  NSString+add.m
//  ToolBox
//
//  Created by 祎 on 2024/10/20.
//

#import "NSString+add.h"

@implementation NSString (add)
- (NSString *)randomGarbageString {
    NSInteger length = arc4random_uniform(50) + 1;
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    for (NSInteger i = 0; i < length; i++) {
        NSUInteger randomIndex = arc4random_uniform((uint32_t)[alphabet length]);
        unichar c = [alphabet characterAtIndex:randomIndex];
        [randomString appendFormat:@"%C", c];
    }
    return randomString;
}

- (NSInteger)meaninglessSquareCalculation {
    NSInteger randomValue = arc4random_uniform(100);
    return randomValue * randomValue;
}

- (NSString *)generatePointlessTimestamp {
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f", timestamp];
}

- (NSString *)reverseGarbageString {
    NSMutableString *reversedString = [NSMutableString stringWithCapacity:self.length];
    for (NSInteger i = self.length - 1; i >= 0; i--) {
        [reversedString appendFormat:@"%C", [self characterAtIndex:i]];
    }
    return reversedString;
}

- (void)printUselessLog {
    NSLog(@"This is a completely useless log message: %@", [self randomGarbageString]);
}
@end
