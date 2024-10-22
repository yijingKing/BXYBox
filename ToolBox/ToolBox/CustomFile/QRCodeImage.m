//
//  QRCodeImage.m
//  QRCode
//
//  Created by iOS on 2017/9/7.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "QRCodeImage.h"

@implementation QRCodeImage


#pragma mark - 生成二维码

/**
 生成颜色二维码

 @param content 二维码数据
 @param size 二维码大小
 @param logo 二维码中心logo
 @param logoFrame logo大小
 @param red 0 ~ 1.0
 @param green 0 ~ 1.0
 @param blue 0 ~ 1.0
 @return 生成颜色二维码图片
 */
+ (UIImage *)qrCodeImageWithContent:(NSString *)content
                      codeImageSize:(CGFloat)size
                               logo:(UIImage *)logo
                          logoFrame:(CGRect)logoFrame
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(CGFloat)blue{
    
    UIImage * image = [self qrCodeImageWithContent:content codeImageSize:size red:red green:green blue:blue];
    
    if (logo != nil) {
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        [logo drawInRect:logoFrame];
        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resultImage;
    }else{
        return image;
    }
    
}

/**
 改变二维码颜色

 @param content 二维码数据
 @param size 二维码大小
 @param red 0 ~ 1.0
 @param green 0 ~ 1.0
 @param blue 0 ~ 1.0
 @return 二维码图片
 */
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    UIImage *image = [self qrCodeImageWithContent:content codeImageSize:size];
    int imageWidth = image.size.width;
    int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little|kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    //遍历像素, 改变像素点颜色
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i<pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red*255;
            ptr[2] = green*255;
            ptr[1] = blue*255;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    //取出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpaceRef);
    
    return resultImage;
}
/**
 改变二维码尺寸大小
 
 @param content 原始二维码数据
 @param size 二维码大小
 @return 二维码图片
 */
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size logoImage:(UIImage *)logo {
    // Generate the basic QR code
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *output = filter.outputImage;
    CGAffineTransform transform = CGAffineTransformMakeScale(3, 3); // Adjust scale
    output = [output imageByApplyingTransform:transform];
    
    // Create gradient background
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [self drawGradientBackgroundWithContext:contextRef size:size];
    
    // Draw the original QRCode image with clear areas
    CGRect qrCodeRect = CGRectMake(size * 0.1, size * 0.1, size * 0.8, size * 0.8);
    [self drawQRCodeImage:output inRect:qrCodeRect];
    
    // Clear the specified rounded rectangles
    CGRect clearRect1 = CGRectMake(0, 0, 40, 40);
    [self clearAreaWithRoundedSquare:clearRect1 inContext:contextRef];
    
    CGRect clearRect2 = CGRectMake(size - 40, 0, 40, 40);
    [self clearAreaWithRoundedSquare:clearRect2 inContext:contextRef];
    
    CGRect clearRect3 = CGRectMake(0, size - 40, 40, 40);
    [self clearAreaWithRoundedSquare:clearRect3 inContext:contextRef];
    
    // Add logo to the center
    CGFloat logoSize = size * 0.2; // Adjust the size of the logo
    CGRect logoRect = CGRectMake((size - logoSize) / 2, (size - logoSize) / 2, logoSize, logoSize);
    [logo drawInRect:logoRect];
    
    // Get the final image
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}

+ (void)drawGradientBackgroundWithContext:(CGContextRef)context size:(CGFloat)size {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *colors = @[(id)[UIColor colorWithRed:1 green:0.8 blue:0 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:0.5 green:0 blue:0.5 alpha:1].CGColor];
    CGFloat locations[] = {0.0, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(size, size);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

+ (void)drawQRCodeImage:(CIImage *)qrCodeImage inRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // Convert CIImage to CGImage
    CIContext *ciContext = [CIContext context];
    CGImageRef cgImage = [ciContext createCGImage:qrCodeImage fromRect:[qrCodeImage extent]];
    
    // Draw QRCode on the gradient background with alpha blending
    CGContextSetBlendMode(contextRef, kCGBlendModeNormal);
    CGContextSetAlpha(contextRef, 0.5); // Adjust the alpha value as needed
    CGContextDrawImage(contextRef, rect, cgImage);
    
    CGImageRelease(cgImage);
}

- (void)clearAreaWithRoundedSquare:(CGRect)clearRect inContext:(CGContextRef)contextRef {
    CGFloat cornerRadius = 5.0; // Adjust the corner radius of the square
    
    // Clear the specified rectangle in the CGContext with white color
    CGContextSetFillColorWithColor(contextRef, [UIColor whiteColor].CGColor);
    CGContextFillRect(contextRef, clearRect);
    
    // Add a rounded square inside the cleared area
    CGRect roundedSquareRect = CGRectMake(CGRectGetMinX(clearRect) + 5, CGRectGetMinY(clearRect) + 5, CGRectGetWidth(clearRect) - 10, CGRectGetHeight(clearRect) - 10);
    UIBezierPath *roundedSquarePath = [UIBezierPath bezierPathWithRoundedRect:roundedSquareRect cornerRadius:cornerRadius];
    CGContextSetFillColorWithColor(contextRef, [UIColor blackColor].CGColor);
    CGContextAddPath(contextRef, roundedSquarePath.CGPath);
    CGContextFillPath(contextRef);
    
    // Draw a smaller square inside the rounded square
    CGFloat smallerSquareSize = CGRectGetWidth(roundedSquareRect) - 10; // Adjust the size of the smaller square
    CGRect smallerSquareRect = CGRectMake(CGRectGetMidX(roundedSquareRect) - smallerSquareSize / 2, CGRectGetMidY(roundedSquareRect) - smallerSquareSize / 2, smallerSquareSize, smallerSquareSize);
    CGContextSetFillColorWithColor(contextRef, [UIColor whiteColor].CGColor);
    CGContextFillRect(contextRef, smallerSquareRect);
    
    // Draw a solid circle in the center of the rounded square
    CGFloat circleRadius = 7; // Adjust the radius of the circle
    CGPoint circleCenter = CGPointMake(CGRectGetMidX(roundedSquareRect), CGRectGetMidY(roundedSquareRect));
    CGContextSetFillColorWithColor(contextRef, [UIColor blackColor].CGColor);
    CGContextFillEllipseInRect(contextRef, CGRectMake(circleCenter.x - circleRadius, circleCenter.y - circleRadius, 2 * circleRadius, 2 * circleRadius));
}










+ (UIImage *)qrCodeImageWithContent1:(NSString *)content codeImageSize:(CGFloat)size {
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *output = filter.outputImage;
    CGAffineTransform transform = CGAffineTransformMakeScale(3, 3); // Adjust scale
    output = [output imageByApplyingTransform:transform];
    
    CIContext *context = [CIContext context];
    CGImageRef cgImage = [context createCGImage:output fromRect:output.extent];
    
    UIImage *scaledImage = [UIImage imageWithCGImage:cgImage];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, size, size);
        gradientLayer.colors = @[(id)[UIColor colorWithRed:1 green:0.8 blue:0 alpha:1].CGColor,
                                 (id)[UIColor colorWithRed:0.5 green:0 blue:0.5 alpha:1].CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
        
        // Create an image with the gradient
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), NO, [UIScreen mainScreen].scale);
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        
        // Draw the gradient layer
        [gradientLayer renderInContext:contextRef];
    
    
    // Clear the specified rectangles with a white color and add a rounded square
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), NO, [UIScreen mainScreen].scale);
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // Draw the original QRCode image first
    [scaledImage drawInRect:CGRectMake(0, 0, size, size)];
    
    // Clear the left-top rectangle
    CGRect leftTopClearRect = CGRectMake(0, 0, 40, 40);
    [self clearAreaWithRoundedSquare:leftTopClearRect inContext:contextRef];
    
    // Clear the right-top rectangle
    CGRect rightTopClearRect = CGRectMake(size - 40, 0, 40, 40);
    [self clearAreaWithRoundedSquare:rightTopClearRect inContext:contextRef];
    
    // Clear the left-bottom rectangle
    CGRect leftBottomClearRect = CGRectMake(0, size - 40, 40, 40);
    [self clearAreaWithRoundedSquare:leftBottomClearRect inContext:contextRef];
    // Get the final image
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return finalImage;
}
+ (void)drawCircularImage:(UIImage *)image inRect:(CGRect)rect {
    // Draw a circular image in the specified rectangle
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    [clipPath addClip];
    [image drawInRect:rect];
}

+ (void)clearAreaWithRoundedSquare:(CGRect)clearRect inContext:(CGContextRef)contextRef {
    CGFloat cornerRadius = 5.0; // Adjust the corner radius of the square
    
    // Clear the specified rectangle in the CGContext with white color
    CGContextSetFillColorWithColor(contextRef, [UIColor whiteColor].CGColor);
    CGContextFillRect(contextRef, clearRect);
    
    // Add a rounded square inside the cleared area
    CGRect roundedSquareRect = CGRectMake(CGRectGetMinX(clearRect) + 5, CGRectGetMinY(clearRect) + 5, CGRectGetWidth(clearRect) - 10, CGRectGetHeight(clearRect) - 10);
    UIBezierPath *roundedSquarePath = [UIBezierPath bezierPathWithRoundedRect:roundedSquareRect cornerRadius:cornerRadius];
    CGContextSetFillColorWithColor(contextRef, [UIColor blackColor].CGColor);
    CGContextAddPath(contextRef, roundedSquarePath.CGPath);
    CGContextFillPath(contextRef);
    
    // Draw a smaller square inside the rounded square
    CGFloat smallerSquareSize = CGRectGetWidth(roundedSquareRect) - 10; // Adjust the size of the smaller square
    CGRect smallerSquareRect = CGRectMake(CGRectGetMidX(roundedSquareRect) - smallerSquareSize / 2, CGRectGetMidY(roundedSquareRect) - smallerSquareSize / 2, smallerSquareSize, smallerSquareSize);
    CGContextSetFillColorWithColor(contextRef, [UIColor whiteColor].CGColor);
    CGContextFillRect(contextRef, smallerSquareRect);
    
    // Draw a solid circle in the center of the rounded square
    CGFloat circleRadius = 7; // Adjust the radius of the circle
    CGPoint circleCenter = CGPointMake(CGRectGetMidX(roundedSquareRect), CGRectGetMidY(roundedSquareRect));
    CGContextSetFillColorWithColor(contextRef, [UIColor blackColor].CGColor);
    CGContextFillEllipseInRect(contextRef, CGRectMake(circleCenter.x - circleRadius, circleCenter.y - circleRadius, 2 * circleRadius, 2 * circleRadius));
}






//+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size{
//    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
//        
//        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//        [filter setValue:data forKey:@"inputMessage"];
//        
//        CIImage *output = filter.outputImage;
//        CGAffineTransform transform = CGAffineTransformMakeScale(3, 3); // 调整比例
//        output = [output imageByApplyingTransform:transform];
//        
//        CIContext *context = [CIContext context];
//        CGImageRef cgImage = [context createCGImage:output fromRect:output.extent];
//        
//        UIImage *scaledImage = [UIImage imageWithCGImage:cgImage];
//        
//        // 将图像调整到指定尺寸
//        UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), NO, [UIScreen mainScreen].scale);
//        [scaledImage drawInRect:CGRectMake(0, 0, size, size)];
//        UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//        CGImageRelease(cgImage);
//        
//        return finalImage;
//    
//}

/**
 生成原始二维码
 
 @param content 二维码数据
 @return 二维码图片
 */
+ (CIImage *)qrCodeImageWithContent:(NSString *)content{
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:contentData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *image = qrFilter.outputImage;
    return image;
}

void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

#pragma mark - 生成条形码

/**
 生成颜色条形码

 @param content 条形码数据
 @param size 条形码大小
 @param red 0 ~ 1.0
 @param green 0 ~ 1.0
 @param blue 0 ~ 1.0
 @return 条形码图片
 */
+ (UIImage *)barcodeImageWithContent:(NSString *)content codeImageSize:(CGSize)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    UIImage *image = [self barcodeImageWithContent:content codeImageSize:size];
    int imageWidth = image.size.width;
    int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little|kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    //遍历像素, 改变像素点颜色
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i<pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red*255;
            ptr[2] = green*255;
            ptr[1] = blue*255;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    
    //取出图片kCGRenderingIntentDefault,
    /*kCGRenderingIntentAbsoluteColorimetric,
    kCGRenderingIntentRelativeColorimetric,
    kCGRenderingIntentPerceptual,
    kCGRenderingIntentSaturation
    */
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpaceRef);
    
    return resultImage;
}


/**
 改变条形码尺寸大小

 @param content 原始条形码数据
 @param size 条形码大小
 @return 条形码图片
 */
+ (UIImage *)barcodeImageWithContent:(NSString *)content codeImageSize:(CGSize)size{
    CIImage *image = [self barcodeImageWithContent:content];
    CGRect integralRect = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(integralRect), size.height/CGRectGetHeight(integralRect));
    
    size_t width = CGRectGetWidth(integralRect)*scale;
    size_t height = CGRectGetHeight(integralRect)*scale;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:integralRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, integralRect, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    UIImage *imagelast = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    return imagelast;
}


/**
 生成原始条形码

 @param content 条形码数据
 @return 条形码图片
 */
+ (CIImage *)barcodeImageWithContent:(NSString *)content{

    CIFilter *qrFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:contentData forKey:@"inputMessage"];
    [qrFilter setValue:@(0.00) forKey:@"inputQuietSpace"];
    CIImage *image = qrFilter.outputImage;
    return image;
}





@end
