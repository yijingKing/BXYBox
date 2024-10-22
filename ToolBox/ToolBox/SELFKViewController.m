//
//  YRSFKViewController.m
//  Multi base conversion
//
//  Created by iOS on 2024/8/22.
//
#import "SELFSTextView.h"
#define STATE_BAR_HEIGHT 40
#define FIT_WIDTH   [UIScreen mainScreen].bounds.size.width/KScreen_W
#define FIT_HEIGHT  [UIScreen mainScreen].bounds.size.height/667
#define KScreen_W  [UIScreen mainScreen].bounds.size.width
#define KScreen_H  [UIScreen mainScreen].bounds.size.height
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#import "SELFKViewController.h"
#import "SELFKViewController+add.h"

#import "NSString+MoreGarbageCode.h"
@interface SELFKViewController ()

@property(nonatomic,weak)     SELFSTextView *NRView;
@property(nonatomic,weak)  SELFSTextView *PHView;

@end

@implementation SELFKViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGBACOLOR(90, 150, 215, 1);
    
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backView.contentMode = UIViewContentModeScaleAspectFill;
    backView.image = [UIImage imageNamed:@"backimage"];
    [self.view addSubview:backView];

    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, STATE_BAR_HEIGHT + 10,32 , 32)];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, STATE_BAR_HEIGHT + 10 , KScreen_W , 32)];
    titleL.text = @"Suggestion";
    titleL.font = [UIFont fontWithName:@"Trebuchet MS" size:25];;
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = RGBACOLOR(255, 255, 255, 1);
    [self.view addSubview:titleL];
    
    [self loadBody];
    
    double t = [self CheckTheCalculationPageGetTheSumOfValues] + [self CheckTheCalculationPageGetTheSumOfValues];
    
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}


-(void)loadBody{
    UIView *contView = [[UIView alloc] initWithFrame:CGRectMake(20, STATE_BAR_HEIGHT + 72, KScreen_W - 40, 168)];
    contView.layer.cornerRadius = 8;
    contView.layer.masksToBounds = YES;
    contView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contView];
    
    SELFSTextView *NRView = [SELFSTextView textView];
    self.NRView = NRView;
    [NRView becomeFirstResponder];
    NRView.backgroundColor =  [UIColor clearColor];
    NRView.frame = CGRectMake(12, 12, contView.bounds.size.width - 24, 128);
    NRView.placeholder = @"Enter the content you want to feedback";
    NRView.maxLength = 300;
    NRView.font = [UIFont fontWithName:@"Trebuchet MS" size:18];
    [contView addSubview:NRView];
    
    UIView *PhoneView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(contView.frame) + 20, KScreen_W - 40, 62)];
    PhoneView.layer.cornerRadius = 8;
    PhoneView.layer.masksToBounds = YES;
    PhoneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:PhoneView];
    
    SELFSTextView *PHView = [SELFSTextView textView];
    self.PHView = PHView;
    [PHView becomeFirstResponder];
    PHView.backgroundColor =  [UIColor clearColor];
    PHView.frame = CGRectMake(12, 12, PhoneView.bounds.size.width - 24, 38);
    PHView.placeholder = @"Enter your contact information";
    PHView.font = [UIFont fontWithName:@"Trebuchet MS" size:18];
    [PhoneView addSubview:PHView];
    
    UIButton *DoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(20,KScreen_H - 128,KScreen_W - 40,48)];
    DoneBtn.layer.cornerRadius = 8;
    DoneBtn.layer.masksToBounds = YES;
    [DoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    DoneBtn.titleLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:18];
    DoneBtn.backgroundColor = RGBACOLOR(225, 255, 245, 1);
    [DoneBtn addTarget:self action:@selector(YKSfeedBackClick) forControlEvents:UIControlEventTouchUpInside];
    [DoneBtn setTitle:@"Feedback" forState:UIControlStateNormal];
    [self.view addSubview:DoneBtn];
}

-(void)YKSfeedBackClick{
    if (self.NRView.text.length == 0) {
        
        NSString *str = @"Please enter the content you want to feedback";
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
         // 添加确定按钮
         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
         }];
         [alert addAction:okAction];
         // 显示弹窗
         [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    if (self.PHView.text.length == 0) {
        
        NSString *str = @"Please enter your contact information";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
         // 添加确定按钮
         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
         }];
         [alert addAction:okAction];
         // 显示弹窗
         [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *str = @"Feedback successful";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
         // 添加确定按钮
         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
             
             [self.navigationController popViewControllerAnimated:YES];
             
         }];
         [alert addAction:okAction];
         // 显示弹窗
         [self presentViewController:alert animated:YES completion:nil];
        
    });
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
