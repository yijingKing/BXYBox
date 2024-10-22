//
//  LCWebView.m
//  LCProduct
//
//  Created by 1 on 2022/10/18.
//

#import "LCWebView.h"


@interface LCWebView () <WKNavigationDelegate, WKUIDelegate>

@end

@implementation LCWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    WKWebViewConfiguration *webConfig = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *wkController = [[WKUserContentController alloc] init];
    webConfig.userContentController = wkController;
    // 自适应屏幕宽度js
    NSString *jsStr = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";

    WKUserScript *wkScript = [[WKUserScript alloc] initWithSource:jsStr injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 添加js调用
    [wkController addUserScript:wkScript];
    
    self = [super initWithFrame:frame configuration:webConfig];
    self.backgroundColor = [UIColor clearColor];
    self.allowsBackForwardNavigationGestures =YES;//打开网页间的 滑动返回
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.navigationDelegate = self;
    self.UIDelegate = self;
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame block:(void (^)(CGFloat))block {
    self = [self initWithFrame:frame];
    self.block = block;
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    return [self initWithFrame:frame];
}

- (void)setHtml:(NSString *)html {
    _html = html;
    NSString *cssStr = @"<style type=\"text/css\">p{line-height: 24px!important;background-color: #fff;}img{max-width: 100%!important;}</style>";
    NSString *htmlStr = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><title>webview</title></head><body>%@%@</body></html>", cssStr, html];
    [self loadHTMLString:htmlStr baseURL:nil];
}

- (void)setUrl:(NSString *)url {
    _url = url;
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{

//    __block CGFloat webViewHeight;
//    kSelf(self);
//    //获取内容实际高度（像素）@"document.getElementById(\"content\").offsetHeight;"
//    NSString *tempStr = @"document.body.scrollHeight";
//    if (@available(iOS 13.0, *)) {
//        tempStr = @"document.documentElement.scrollHeight";
//    }
//    [webView evaluateJavaScript:tempStr completionHandler:^(id _Nullable result,NSError * _Nullable error) {
//        // 此处js字符串采用scrollHeight而不是offsetHeight是因为后者并获取不到高度，看参考资料说是对于加载html字符串的情况下使用后者可以，但如果是和我一样直接加载原站内容使用前者更合适
//        //获取页面高度，并重置webview的frame
//        webViewHeight = [result doubleValue];
//        NSLog(@"%f",webViewHeight);
//        
//        if (weakself.block) {
//            weakself.block(webViewHeight);
//        }
//    }];
    
    NSLog(@"结束加载");
}

@end
