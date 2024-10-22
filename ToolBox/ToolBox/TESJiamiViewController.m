//
//  HSStartViewController.m
//  Hash Algorithm
//
//  Created by iOS on 2024/7/2.
//
#import <CommonCrypto/CommonDigest.h>


#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#define STATE_BAR_HEIGHT 40
#define FIT_WIDTH   [UIScreen mainScreen].bounds.size.width/375
#define FIT_HEIGHT  [UIScreen mainScreen].bounds.size.height/667
#define KScreen_W  [UIScreen mainScreen].bounds.size.width
#define KScreen_H  [UIScreen mainScreen].bounds.size.height
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#import "TESJiamiViewController.h"
#import "UIViewController+add.h"
#import "NSString+MoreGarbageCode.h"
@interface TESJiamiViewController ()

@property(nonatomic,weak)     UITextField *Field_1;



@property(nonatomic,weak) UIButton *exchange;
@property(nonatomic,weak) UIView *resView;
@property(nonatomic,weak) UILabel *resL;


@end

@implementation TESJiamiViewController


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
    
    
    
    UIButton *infoBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreen_W - 50, STATE_BAR_HEIGHT + 10,32 , 32)];
    [infoBtn addTarget:self action:@selector(infoClick) forControlEvents:UIControlEventTouchUpInside];
    [infoBtn setImage:[UIImage imageNamed:@"关于"] forState:UIControlStateNormal];
    [self.view addSubview:infoBtn];
    
    
    UILabel *titleLs = [[UILabel alloc] initWithFrame:CGRectMake(0, STATE_BAR_HEIGHT + 10 , KScreen_W , 36)];
    titleLs.text = self.passType;
    titleLs.font = [UIFont fontWithName:@"Trebuchet MS" size:21];
    titleLs.textAlignment = NSTextAlignmentCenter;
    titleLs.textColor = RGBACOLOR(255, 255, 255, 1);
    [self.view addSubview:titleLs];
    
    
    [self loadBody];
    
    
    
    
    [self.resView removeFromSuperview];
    
    UIView *resView = [[UIView alloc] initWithFrame:CGRectMake(12,CGRectGetMaxY(self.exchange.frame) + 20, KScreen_W - 24, 108 + 96)];
    self.resView = resView;
    resView.backgroundColor = [UIColor whiteColor];
    resView.layer.cornerRadius = 5;
    resView.layer.masksToBounds = YES;
    [self.view addSubview:resView];
    
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , resView.bounds.size.width , 36)];
    titleL.backgroundColor = RGBACOLOR(60, 120, 60, 1);
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = @"Conversion results";
    titleL.font = [UIFont fontWithName:@"Trebuchet MS" size:16];
    titleL.textColor = RGBACOLOR(255, 255, 255, 1);
    [resView addSubview:titleL];
    
    

        UILabel *resL = [[UILabel alloc] initWithFrame:CGRectMake(16,48 , resView.bounds.size.width - 32 , 75)];
        resL.numberOfLines = 0;
        self.resL = resL;
        resL.font = [UIFont boldSystemFontOfSize:20];
        resL.textColor = RGBACOLOR(25, 55, 25, 1);
        [resView addSubview:resL];
        
    
    

    UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyBtn addTarget:self action:@selector(CopyClick) forControlEvents:UIControlEventTouchUpInside];
    copyBtn.frame = CGRectMake(resView.bounds.size.width - 54,resView.bounds.size.height - 50,50, 50);
    [copyBtn setImage:[UIImage imageNamed:@"复制"] forState:UIControlStateNormal];
    [resView addSubview:copyBtn];

    
    double t = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double t1 = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double t11 = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double t111 = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double t1111 = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double t11111 = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double t111111 = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    double ddd = t + t1 + t11 + t111 + t1111;
    
    NSString *exampleString = @"code";
       
       NSString *doubledStr = [exampleString doubleCharacters];
       
       BOOL randomBool = [doubledStr returnRandomBoolean];
       
       CGFloat meaninglessFloat = [doubledStr returnMeaninglessFloat];
       
       NSInteger asciiSum = [exampleString asciiSumOfString];
       
       [exampleString printIsLengthEven];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)loadBody{
    UIView *contView = [[UIView alloc] initWithFrame:CGRectMake(12, STATE_BAR_HEIGHT + 64, KScreen_W - 24, 96  + 64)];
    contView.backgroundColor = [UIColor whiteColor];
    contView.layer.cornerRadius = 8;
    contView.layer.masksToBounds = YES;
    [self.view addSubview:contView];
    
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , contView.bounds.size.width , 36)];
    titleL.text = @"Enter the text to be converted";
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont fontWithName:@"Trebuchet MS" size:16];
    titleL.textColor = RGBACOLOR(255, 255, 255, 1);
    titleL.backgroundColor = RGBACOLOR(60, 120, 60, 1);
    [contView addSubview:titleL];
    

    
    UITextField *Field_1 = [[UITextField alloc] initWithFrame:CGRectMake(16, 45, contView.bounds.size.width - 32, 48)];
    Field_1.placeholder = @"";
    self.Field_1 = Field_1;
    [Field_1 becomeFirstResponder];
    Field_1.font = [UIFont boldSystemFontOfSize:20];
    Field_1.textColor = RGBACOLOR(15, 15, 15, 1);
    [contView  addSubview:Field_1];
    
    

    UIButton *exchange = [[UIButton alloc]initWithFrame:CGRectMake((KScreen_W - 40)/2,CGRectGetMaxY(contView.frame) + 20,40 , 40)];
    self.exchange = exchange;
    [exchange addTarget:self action:@selector(exchangeClick) forControlEvents:UIControlEventTouchUpInside];
    [exchange setImage:[UIImage imageNamed:@"exchange"] forState:UIControlStateNormal];
    [self.view addSubview:exchange];
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)exchangeClick{

    if (self.Field_1.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please enter the text" message:nil preferredStyle:UIAlertControllerStyleAlert];
         // 添加确定按钮
         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
         }];
         [alert addAction:okAction];
         // 显示弹窗
         [self presentViewController:alert animated:YES completion:nil];
        
        return ;
    }
    
    
    
    self.resL.text = [self textWithMMStyle:self.passType];;
    
//    [self.resView removeFromSuperview];
//    UIView *resView = [[UIView alloc] initWithFrame:CGRectMake(12,CGRectGetMaxY(self.exchange.frame) + 20, KScreen_W - 24, 108 + 96)];
//    self.resView = resView;
//    resView.backgroundColor = [UIColor whiteColor];
//    resView.layer.cornerRadius = 5;
//    resView.layer.masksToBounds = YES;
//    [self.view addSubview:resView];
//    
//    
//    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , resView.bounds.size.width , 36)];
//    titleL.backgroundColor = RGBACOLOR(128, 228, 128, 1);
//    titleL.textAlignment = NSTextAlignmentCenter;
//    titleL.text = @"Conversion results";
//    titleL.font = [UIFont fontWithName:@"Trebuchet MS" size:16];
//    titleL.textColor = RGBACOLOR(25, 25, 25, 1);
//    [resView addSubview:titleL];
//    
//    
//
//        UILabel *resL = [[UILabel alloc] initWithFrame:CGRectMake(16,48 , resView.bounds.size.width - 32 , 75)];
//        resL.numberOfLines = 0;
//        self.resL = resL;
//        resL.text = [self textWithMMStyle:self.passType];;
//        resL.font = [UIFont boldSystemFontOfSize:20];
//        resL.textColor = RGBACOLOR(25, 55, 25, 1);
//        [resView addSubview:resL];
//        
//    
//    
//
//    UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [copyBtn addTarget:self action:@selector(CopyClick) forControlEvents:UIControlEventTouchUpInside];
//    copyBtn.frame = CGRectMake(resView.bounds.size.width - 54,resView.bounds.size.height - 50,50, 50);
//    [copyBtn setImage:[UIImage imageNamed:@"复制"] forState:UIControlStateNormal];
//    [resView addSubview:copyBtn];

    
}

-(NSString *)textWithMMStyle:(NSString *)style{
    

    NSString *jiaStr = self.Field_1.text;
    

    if ([self.passType containsString:@"MD"]) {
        
        NSString *passText = md5(jiaStr);
        return passText;
        
    }
    
    if ([self.passType containsString:@"SHA1"]) {
        
        NSString *passText = sha1(jiaStr);
        return passText;
        
    }
    

    
    return @"asd";
}


NSString* md5(NSString* input){
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",result[i]];
    }
    return output;
}


// 函数声明：计算字符串的 SHA1 值
NSString* sha1(NSString* input) {
    const char* str = [input UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",result[i]];
    }
    
    return output;
}


-(void)infoClick{
    NSString *SSSSS = @"";
    
    
    if ([self.passType containsString:@"MD"]) {
        
        SSSSS = @"MD5 is a widely used cryptographic hash function that can generate a 128 bit hash value to ensure complete and consistent information transmission. After 1996, the algorithm was proven to have weaknesses and can be cracked. In 2004, it was confirmed that the MD5 algorithm cannot prevent collisions and is therefore not suitable for security authentication purposes such as SSL public key authentication or digital signatures.";
    }
    
    if ([self.passType containsString:@"SHA1"]) {
        
        SSSSS = @"SHA-1 is a cryptographic hash function designed by the US National Security Agency and published by the National Institute of Standards and Technology as a federal data processing standard. SHA-1 can generate a 160 bit hash value called a message digest, which typically takes the form of 40 hexadecimal numbers. SHA-1 is no longer considered as a defense against attackers with sufficient funds and computing resources. In 2005, password analysts discovered an effective attack method against SHA-1, indicating that the algorithm may not be secure enough and is not recommended for use in security sensitive data.";
        
    }
    
    if ([self.passType containsString:@"256"]) {
        
        SSSSS = @"SHA-256 is a cryptographic hash function used to generate hash values and is part of the SHA-2 family. SHA-256 can convert input data of any length into a fixed length (256 bits or 32 bytes) output, which is usually represented in hexadecimal format. SHA-256 is widely used in many fields, including cryptography, digital signatures, data integrity verification, and so on. Its design goal is to provide a secure and efficient data summarization algorithm that can resist various attacks, such as collision attacks, pre image attacks, etc";
    }
    
    
    if ([self.passType containsString:@"512"]) {
        
        SSSSS = @"SHA-512 is a cryptographic hash function in the SHA-2 family, and it is one of the derivative versions of SHA-256. Compared to SHA-256, SHA-512 generates longer hash values with a length of 512 bits, providing higher security. The design of SHA-512 is similar to SHA-256, but it uses larger message blocks and more rounds to increase security and resist various attacks. Its working principle is also to convert input data into fixed length output through a series of data processing steps, including bit padding, block partitioning, message scheduling, compression functions, etc. Due to the longer hash values generated by SHA-512, it is more suitable for applications that require higher security in certain situations";
    }
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:SSSSS message:nil preferredStyle:UIAlertControllerStyleAlert];
     // 添加确定按钮
     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
     }];
     [alert addAction:okAction];
     // 显示弹窗
     [self presentViewController:alert animated:YES completion:nil];
    
}


-(void)CopyClick{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Copy successful" message:nil preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 用户点击确定按钮后的操作
    }];

    [alert addAction:okAction];
    // 在视图控制器中显示弹框
    [self presentViewController:alert animated:YES completion:nil];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.resL.text;
}


@end
