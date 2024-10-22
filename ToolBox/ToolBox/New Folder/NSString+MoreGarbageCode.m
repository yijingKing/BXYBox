//
//  NSString+MoreGarbageCode.m
//  ToolBox
//
//  Created by 祎 on 2024/10/20.
//

#import "NSString+MoreGarbageCode.h"

@implementation NSString (MoreGarbageCode)
- (NSString *)doubleCharacters {
    NSMutableString *doubledString = [NSMutableString stringWithCapacity:self.length * 2];
    for (NSInteger i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        [doubledString appendFormat:@"%C%C", c, c];
    }
    return doubledString;
}

- (BOOL)returnRandomBoolean {
    return arc4random_uniform(2) == 1;
}
- (CGFloat)returnMeaninglessFloat {
    return ((float)arc4random() / UINT32_MAX) * 100.0f;
}

- (NSInteger)asciiSumOfString {
    NSInteger sum = 0;
    for (NSInteger i = 0; i < self.length; i++) {
        sum += [self characterAtIndex:i];
    }
    return sum;
}

- (void)printIsLengthEven {
    if (self.length % 2 == 0) {
        NSLog(@"The length of the string is even.");
    } else {
        NSLog(@"The length of the string is odd.");
    }
}
@end
