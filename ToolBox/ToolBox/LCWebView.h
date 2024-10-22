//
//  LCWebView.h
//  LCProduct
//
//  Created by 1 on 2022/10/18.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCWebView : WKWebView

- (instancetype)initWithFrame:(CGRect)frame block:(void (^)(CGFloat height))block;

@property (nonatomic, copy) void (^block) (CGFloat height);

@property (nonatomic, copy) NSString * html;

@property (nonatomic, copy) NSString * url;

@end

NS_ASSUME_NONNULL_END
