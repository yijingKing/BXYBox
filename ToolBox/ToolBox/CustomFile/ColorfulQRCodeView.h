//
//  ColorfulQRCodeView.h
//  QRCode
//
//  Created by iOS on 2017/9/8.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorfulQRCodeView : UIView
@property (strong, nonatomic) CALayer *maskLayer;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
- (void)syncFrame;
- (void)setQRCodeImage:(UIImage *)qrcodeImage;

@end
