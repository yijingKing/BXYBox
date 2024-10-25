//
//  QRCodeImage.h
//  QRCode
//
//  Created by iOS on 2017/9/7.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QRCodeImage : NSObject
+ (UIImage *)qrCodeImageWithContent:(NSString *)content
                      codeImageSize:(CGFloat)size
                               logo:(UIImage *)logo
                          logoFrame:(CGRect)logoFrame
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(CGFloat)blue;
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size;

+ (UIImage *)barcodeImageWithContent:(NSString *)content codeImageSize:(CGSize)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+ (UIImage *)barcodeImageWithContent:(NSString *)content codeImageSize:(CGSize)size;
+ (void)drawCircularImage:(UIImage *)image inRect:(CGRect)rect ;



+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size logoImage:(UIImage *)logo;
@end
