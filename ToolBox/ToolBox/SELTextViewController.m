//
//  FlTextViewController.m
//  File Hash
//
//  Created by iOS on 2024/7/11.
//

#import "NSString+MdStr.h"
#import "SELFSTextView.h"
#define STATE_BAR_HEIGHT 40
#define FIT_WIDTH   [UIScreen mainScreen].bounds.size.width/375
#define FIT_HEIGHT  [UIScreen mainScreen].bounds.size.height/667
#define KScreen_W  [UIScreen mainScreen].bounds.size.width
#define KScreen_H  [UIScreen mainScreen].bounds.size.height
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#import "SELTextViewController.h"
@interface SELTextViewController ()

@property(nonatomic,weak) SELFSTextView *Field_1;
@property(nonatomic,weak) UILabel *resL;
@property(nonatomic,weak) UIButton *ZXCopyBtn;

@end

@implementation SELTextViewController

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
    titleL.text = @"Text Hash";
    titleL.font = [UIFont fontWithName:@"Trebuchet MS" size:25];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = RGBACOLOR(255, 255, 255, 1);
    [self.view addSubview:titleL];
    [self loadBody];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadBody{
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(20,STATE_BAR_HEIGHT + 80, KScreen_W - 40, (KScreen_W - 40) / 2.4)];
    innerView.backgroundColor = [UIColor whiteColor];
    innerView.layer.cornerRadius = 8;
    innerView.layer.masksToBounds = YES;
    [self.view addSubview:innerView];
    
    SELFSTextView  *Field_1 = [[SELFSTextView alloc] initWithFrame:CGRectMake(20,20,KScreen_W - 40, 128)];
    self.Field_1 = Field_1;
    Field_1.placeholder = @"Please enter text";
    [Field_1 becomeFirstResponder];
    Field_1.backgroundColor = [UIColor clearColor];
    Field_1.font = [UIFont fontWithName:@"Trebuchet MS" size:21];
    Field_1.textColor = RGBACOLOR(25, 15, 25, 1);
    [innerView  addSubview:Field_1];
    
    UIView *contView = [[UIView alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(innerView.frame) + 120, KScreen_W - 40, (KScreen_W - 40) / 2.4)];
    contView.backgroundColor = [UIColor whiteColor];
    contView.layer.cornerRadius = 8;
    contView.layer.masksToBounds = YES;
    [self.view addSubview:contView];
    
    UILabel *resL = [[UILabel alloc] initWithFrame:CGRectMake(20, 30 , contView.bounds.size.width - 40, 75)];
    resL.text = @" ";
    self.resL = resL;
    resL.numberOfLines = 0;
    resL.font = [UIFont fontWithName:@"Trebuchet MS" size:21];
    resL.textColor = RGBACOLOR(25, 25, 25, 1);
    resL.backgroundColor = [UIColor clearColor];
    [contView addSubview:resL];
    
    UIButton *exchange = [[UIButton alloc]initWithFrame:CGRectMake((KScreen_W - 48)/2,CGRectGetMaxY(innerView.frame) + 100,48 , 48)];
    [exchange addTarget:self action:@selector(exchangeClick) forControlEvents:UIControlEventTouchUpInside];
    [exchange setImage:[UIImage imageNamed:@"转变方向"] forState:UIControlStateNormal];
    exchange.backgroundColor = RGBACOLOR(20, 228, 88, 1);
    exchange.layer.cornerRadius = 24;
    [self.view addSubview:exchange];
    
    UIButton *copyBtn = [[UIButton alloc]initWithFrame:CGRectMake(contView.bounds.size.width - 52,contView.bounds.size.height - 52,48 , 48)];
    [copyBtn addTarget:self action:@selector(CopyClick) forControlEvents:UIControlEventTouchUpInside];
    [copyBtn setImage:[UIImage imageNamed:@"复制"] forState:UIControlStateNormal];
    [contView addSubview:copyBtn];
}

-(void)exchangeClick{
    [self.view endEditing:YES];
    if (self.Field_1.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please enter text" message:nil preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];

        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSString *md5Str = [self.Field_1.text stringToMD5];
    self.resL.text = md5Str;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
}


-(void)CopyClick{
    if (self.Field_1.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please enter text" message:nil preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];

        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Copy successful" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];

    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.resL.text;
}







@end
