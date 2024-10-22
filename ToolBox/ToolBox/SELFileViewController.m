//
//  FlfileViewController.m
//  File Hash
//
//  Created by iOS on 2024/7/12.
//
#import <CommonCrypto/CommonDigest.h>
#import <MobileCoreServices/MobileCoreServices.h>
#define STATE_BAR_HEIGHT 40
#define FIT_WIDTH   [UIScreen mainScreen].bounds.size.width/375
#define FIT_HEIGHT  [UIScreen mainScreen].bounds.size.height/667
#define KScreen_W  [UIScreen mainScreen].bounds.size.width
#define KScreen_H  [UIScreen mainScreen].bounds.size.height
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#import "SELFileViewController.h"
#import "UIViewController+add.h"
@interface SELFileViewController ()<UIDocumentPickerDelegate>

@property(nonatomic,weak) UIButton *uploadBtn;
@property(nonatomic,weak) UILabel *resL;
@property(nonatomic,weak) UIButton *zxcopyBtn;
@property(nonatomic,weak) UIButton *fileBtn;
@property(nonatomic,weak) UIView *contView;

@end

@implementation SELFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backView.image = [UIImage imageNamed:@"backimage"];
    [self.view addSubview:backView];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, STATE_BAR_HEIGHT + 10,32 , 32)];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, STATE_BAR_HEIGHT + 10 , KScreen_W , 36)];
    titleL.text = @"File Hash";
    titleL.font = [UIFont fontWithName:@"Trebuchet MS" size:25];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = RGBACOLOR(255, 255, 255, 1);
    [self.view addSubview:titleL];
    
    [self loadBody];
    double t = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double t1 = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double t11 = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double t111 = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double t1111 = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double t11111 = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double t111111 = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double ddd = t + t1 + t11 + t111 + t1111;
}


-(void)loadBody{
    CGFloat mars = 48;
    UIView *contView = [[UIView alloc] initWithFrame:CGRectMake(mars,STATE_BAR_HEIGHT + 180, KScreen_W - mars * 2, (KScreen_W - mars * 2) )];
    self.contView = contView;
    contView.layer.cornerRadius = (KScreen_W - mars * 2)/2;
    contView.backgroundColor = RGBACOLOR(125, 175, 150, 1);
    [self.view addSubview:contView];
    

    UIButton *upLoadBtn = [[UIButton alloc]initWithFrame:CGRectMake((contView.bounds.size.width - 80)/2, (contView.bounds.size.height - 80)/2,80 ,80)];
    [upLoadBtn addTarget:self action:@selector(LoadClick) forControlEvents:UIControlEventTouchUpInside];
    self.uploadBtn = upLoadBtn;
    [upLoadBtn setImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];
    [contView addSubview:upLoadBtn];
}

-(void)LoadClick{
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[(NSString *)kUTTypePDF] inMode:UIDocumentPickerModeImport];
    // 设置代理
    documentPicker.delegate = self;
    // 显示文档选择器
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    NSString *String= [self md5ForFile:url];
    [self.uploadBtn removeFromSuperview];
    [self.resL removeFromSuperview];
    [self.zxcopyBtn removeFromSuperview];
    [self.fileBtn removeFromSuperview];
    
    UILabel *resL = [[UILabel alloc] initWithFrame:CGRectMake(50, 80 * FIT_WIDTH , self.contView.bounds.size.width - 100, 48)];
    self.resL = resL;
    resL.text = String;
    resL.textAlignment = NSTextAlignmentCenter;
    resL.numberOfLines = 0;
    resL.font = [UIFont fontWithName:@"Avenir Book" size:16];
    resL.textColor = RGBACOLOR(255, 255, 255, 1);
    [self.contView addSubview:resL];
    
    CGFloat inner_X = 20;
    CGFloat btn_w = 48;
    CGFloat mars = (self.contView.bounds.size.width - btn_w * 2 - inner_X) / 2;
    
    NSLog(@"%f~~~%f~~%f",inner_X,btn_w,mars);
    
    UIButton *copyBtn = [[UIButton alloc]initWithFrame:CGRectMake(mars,CGRectGetMaxY(resL.frame) + 30,btn_w , btn_w)];
    self.zxcopyBtn = copyBtn;
    [copyBtn addTarget:self action:@selector(CopyClick) forControlEvents:UIControlEventTouchUpInside];
    [copyBtn setImage:[UIImage imageNamed:@"copys"] forState:UIControlStateNormal];
    [self.contView addSubview:copyBtn];
    
    
    UIButton *fileBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(copyBtn.frame) + inner_X,CGRectGetMaxY(resL.frame) + 30,btn_w , btn_w)];
    self.fileBtn = fileBtn;
    [fileBtn addTarget:self action:@selector(LoadClick) forControlEvents:UIControlEventTouchUpInside];
    [fileBtn setImage:[UIImage imageNamed:@"文件"] forState:UIControlStateNormal];
    [self.contView addSubview:fileBtn];
}

-(void)CopyClick{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Copy successful" message:nil preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];

    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.resL.text;
}

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    NSLog(@"Document picker was cancelled");
}

-(NSString *)md5ForFile:(NSURL *)filePath {
    NSData *data = [NSData dataWithContentsOfURL:filePath];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
}












@end
