//
//  KHRandomViewController.m
//  Useful Tool Collection
//
//  Created by mac on 2024/9/23.
//
#define STATE_BAR_HEIGHT 40
#define FIT_WIDTH   [UIScreen mainScreen].bounds.size.width/375
#define FIT_HEIGHT  [UIScreen mainScreen].bounds.size.height/667
#define KScreen_W  [UIScreen mainScreen].bounds.size.width
#define KScreen_H  [UIScreen mainScreen].bounds.size.height
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define BOTTOM_SAFE_HEIHT ((STATE_BAR_HEIGHT > 20)?34:0)
#import "SELRandomViewController.h"

@interface SELRandomViewController ()
@property(nonatomic,weak)     UIView *contView;
@property(nonatomic,weak)     UILabel *countVaL;
@property(nonatomic,assign)     int choiceNum;

@property(nonatomic,weak) UITextField *field_1;
@property(nonatomic,weak) UITextField *field_2;
@property(nonatomic,weak) UILabel *titleL;
@end

@implementation SELRandomViewController



- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = RGBACOLOR(225, 245, 255, 1);
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,KScreen_W, KScreen_H )];
    backView.contentMode = UIViewContentModeScaleToFill;
    backView.image = [UIImage imageNamed:@"backimage"];
    [self.view addSubview:backView];
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, STATE_BAR_HEIGHT + 10,32 , 32)];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(24, STATE_BAR_HEIGHT + 10,  KScreen_W - 48, 32)];
    titleL.text = @"Random Numbers";
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont fontWithName:@"Trebuchet MS" size:24];
    titleL.textColor = [UIColor whiteColor];
    [self.view addSubview:titleL];
    
    
    [self loadBodyWithCount:0];
    
    [self loadLastView];
    
    self.choiceNum = 1;
}

-(void)loadBodyWithCount:(int)num{
    UIView *contView = [[UIView alloc] initWithFrame:CGRectMake(24,STATE_BAR_HEIGHT + 72,KScreen_W - 48, (KScreen_W - 48) * 10 / 16)];
    self.contView = contView;
    contView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    contView.layer.cornerRadius = 5;
    contView.layer.masksToBounds = YES;
    [self.view addSubview:contView];

    UILabel *titleL = [[UILabel alloc] initWithFrame:contView.bounds];
    titleL.text = @"0";
    self.titleL = titleL;
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont fontWithName:@"Trebuchet MS" size:100];
    titleL.textColor = [UIColor blackColor];
    [contView addSubview:titleL];
}


-(void)loadLastView{
    UIView *lastView = [[UIView alloc] initWithFrame:CGRectMake(24,CGRectGetMaxY(self.contView.frame) + 12,KScreen_W - 48, 88)];
    lastView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    lastView.layer.cornerRadius = 5;
    lastView.layer.masksToBounds = YES;
    [self.view addSubview:lastView];
    
    
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15,10, 300, 30)];
    titleL.text = @"Random interval (1 - 10000)";
    titleL.font = [UIFont fontWithName:@"Trebuchet MS" size:16];
    titleL.textColor = [UIColor blackColor];
    [lastView addSubview:titleL];
    
    
    CGFloat line_w = (lastView.bounds.size.width) / 5;
    
    
    
    UIView *line_1 = [[UIView alloc] initWithFrame:CGRectMake(line_w,CGRectGetMaxY(titleL.frame) + 35,line_w, 1)];
    line_1.backgroundColor = RGBACOLOR(55, 55, 25, 1);
    [lastView addSubview:line_1];
    
    
    UIView *line_2 = [[UIView alloc] initWithFrame:CGRectMake(line_w * 3,CGRectGetMaxY(titleL.frame) + 35,line_w, 1)];
    line_2.backgroundColor = RGBACOLOR(55, 55, 25, 1);
    [lastView addSubview:line_2];
    
    UITextField *field_1 = [[UITextField alloc] initWithFrame:CGRectMake(line_w, CGRectGetMaxY(titleL.frame) + 6,line_w, 20)];
    self.field_1 = field_1;
    field_1.textAlignment = NSTextAlignmentCenter;
    field_1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    field_1.text = @"1";
    field_1.font = [UIFont systemFontOfSize:16];
    field_1.textColor = [UIColor blackColor];
    [lastView addSubview:field_1];
    
    
    UITextField *field_2 = [[UITextField alloc] initWithFrame:CGRectMake(line_w * 3, CGRectGetMaxY(titleL.frame) + 6,line_w, 20)];
    self.field_2 = field_2;
    field_2.textAlignment = NSTextAlignmentCenter;
    field_2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    field_2.text = @"10000";
    field_2.font = [UIFont systemFontOfSize:16];
    field_2.textColor = [UIColor blackColor];
    [lastView addSubview:field_2];
    
    
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(24,CGRectGetMaxY(lastView.frame) + 12,KScreen_W - 48, 50)];
    innerView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    innerView.layer.cornerRadius = 5;
    innerView.layer.masksToBounds = YES;
    [self.view addSubview:innerView];
    
    
    UILabel *countL = [[UILabel alloc] initWithFrame:CGRectMake(15,10, 300, 30)];
    countL.text = @"Number";
    countL.font = [UIFont fontWithName:@"Trebuchet MS" size:16];
    countL.textColor = [UIColor blackColor];
    [innerView addSubview:countL];

    
    UILabel *countVaL = [[UILabel alloc] initWithFrame:CGRectMake(innerView.bounds.size.width - 90,10, 45, 30)];
    countVaL.textAlignment =  NSTextAlignmentRight;
    self.countVaL = countVaL;
    countVaL.text = @"1";
    countVaL.font = [UIFont fontWithName:@"Trebuchet MS" size:16];
    countVaL.textColor = [UIColor blackColor];
    [innerView addSubview:countVaL];
    
    
    UIButton *arrow = [UIButton buttonWithType:UIButtonTypeCustom];
    arrow.frame = CGRectMake(CGRectGetMaxX(countVaL.frame) + 3, 10, 30, 30);
    [arrow setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [arrow addTarget:self action:@selector(arrowClick) forControlEvents:UIControlEventTouchUpInside];
    [innerView addSubview:arrow];
    
    
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(24, KScreen_H - BOTTOM_SAFE_HEIHT - 128 , KScreen_W - 48, 44);
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:21];
    doneBtn.backgroundColor = RGBACOLOR(225, 255, 235, 1);
    doneBtn.layer.cornerRadius = 5;
    [doneBtn addTarget:self action:@selector(DoneClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
}

-(void)DoneClick{
    
    NSLog(@"CCCCC %d",self.choiceNum);
    
    if (self.choiceNum == 1) {
        
        for (UIView *SSSS in self.contView.subviews) {
            [SSSS removeFromSuperview];
        }
        
        
        uint32_t randomNumber = arc4random_uniform(10000) + 1;


        UILabel *titleL = [[UILabel alloc] initWithFrame:self.contView.bounds];
        titleL.text = [NSString stringWithFormat:@"%u",randomNumber];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.font = [UIFont fontWithName:@"Trebuchet MS" size:100];
        titleL.textColor = [UIColor blackColor];
        [self.contView addSubview:titleL];
        
        
    }
    
    if (self.choiceNum == 2) {
    
        for (UIView *SSSS in self.contView.subviews) {
            [SSSS removeFromSuperview];
        }
        
        uint32_t randomNumber_1 = arc4random_uniform(10000) + 1;
        uint32_t randomNumber_2 = arc4random_uniform(10000) + 1;
        
        UILabel *titleL_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contView.bounds.size.width, self.contView.bounds.size.height / 2)];
        titleL_1.text = [NSString stringWithFormat:@"%u",randomNumber_1];
        titleL_1.textAlignment = NSTextAlignmentCenter;
        titleL_1.font = [UIFont fontWithName:@"Trebuchet MS" size:60];
        titleL_1.textColor = [UIColor blackColor];
        [self.contView addSubview:titleL_1];
        
        UILabel *titleL_2 = [[UILabel alloc] initWithFrame:CGRectMake(0,self.contView.bounds.size.height / 2, self.contView.bounds.size.width, self.contView.bounds.size.height / 2)];
        titleL_2.text = [NSString stringWithFormat:@"%u",randomNumber_2];
        titleL_2.textAlignment = NSTextAlignmentCenter;
        titleL_2.font = [UIFont fontWithName:@"Trebuchet MS" size:60];
        titleL_2.textColor = [UIColor blackColor];
        [self.contView addSubview:titleL_2];
        
    }
    
    if (self.choiceNum == 3) {
    
        for (UIView *SSSS in self.contView.subviews) {
            [SSSS removeFromSuperview];
        }
        
        uint32_t randomNumber_1 = arc4random_uniform(10000) + 1;
        uint32_t randomNumber_2 = arc4random_uniform(10000) + 1;
        uint32_t randomNumber_3 = arc4random_uniform(10000) + 1;
        
        
        UILabel *titleL_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contView.bounds.size.width, self.contView.bounds.size.height / 3)];
        titleL_1.text = [NSString stringWithFormat:@"%u",randomNumber_1];
        titleL_1.textAlignment = NSTextAlignmentCenter;
        titleL_1.font = [UIFont fontWithName:@"Trebuchet MS" size:40];
        titleL_1.textColor = [UIColor blackColor];
        [self.contView addSubview:titleL_1];
        
        UILabel *titleL_2 = [[UILabel alloc] initWithFrame:CGRectMake(0,self.contView.bounds.size.height / 3, self.contView.bounds.size.width, self.contView.bounds.size.height / 3)];
        titleL_2.text = [NSString stringWithFormat:@"%u",randomNumber_2];
        titleL_2.textAlignment = NSTextAlignmentCenter;
        titleL_2.font = [UIFont fontWithName:@"Trebuchet MS" size:40];
        titleL_2.textColor = [UIColor blackColor];
        [self.contView addSubview:titleL_2];
        
        
        UILabel *titleL_3 = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(titleL_2.frame), self.contView.bounds.size.width, self.contView.bounds.size.height / 3)];
        titleL_3.text = [NSString stringWithFormat:@"%u",randomNumber_3];
        titleL_3.textAlignment = NSTextAlignmentCenter;
        titleL_3.font = [UIFont fontWithName:@"Trebuchet MS" size:40];
        titleL_3.textColor = [UIColor blackColor];
        [self.contView addSubview:titleL_3];
    }
}

-(void)arrowClick{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Please choose an option"
    preferredStyle:UIAlertControllerStyleActionSheet];

    // 添加第一个动作，标题为"1"，样式为默认，并设置处理函数
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"用户选择了1");
        self.choiceNum = 1;
        self.countVaL.text = @"1";
    }];

    // 添加第二个动作，标题为"2"，样式为默认，并设置处理函数
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"用户选择了2");
        self.choiceNum = 2;
        self.countVaL.text = @"2";
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"3" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"用户选择了2");
        self.choiceNum = 3;
        self.countVaL.text = @"3";
    }];

    // 添加取消动作，标题为"取消"，样式为取消，并设置处理函数
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"用户取消了选择");
    // 在这里处理用户取消选择的逻辑
                                                      }];

    // 将这些动作添加到UIAlertController中
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:cancelAction];

    // 展示UIAlertController
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
