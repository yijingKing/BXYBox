//
//  HYTimerViewController.m
//  Customized  Clock
//
//  Created by 朱志雄 on 2024/7/27.
//
#define STATE_BAR_HEIGHT 40
#define FIT_WIDTH   [UIScreen mainScreen].bounds.size.width/375
#define FIT_HEIGHT  [UIScreen mainScreen].bounds.size.height/667
#define KScreen_W  [UIScreen mainScreen].bounds.size.width
#define KScreen_H  [UIScreen mainScreen].bounds.size.height
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#import "SELTimerViewController.h"
#import "NSString+ccc.h"
@interface SELTimerViewController ()
@property (weak, nonatomic)  UILabel *countdownLabel;
@property (nonatomic, assign) NSInteger remainingTime;
@property (strong, nonatomic)      NSTimer *timer;

@property(nonatomic,weak) UIButton *selBtn;
@property(nonatomic,strong) NSMutableArray *arrM;

@property(nonatomic,weak) UIButton *startBtn;
@property(nonatomic,weak) UIButton *pauseBtn;
@property(nonatomic,assign) NSInteger selNum;
@property(nonatomic,assign) BOOL isBegin;

@end

@implementation SELTimerViewController


-(NSMutableArray *)arrM{
    if (_arrM == nil) {
        _arrM = [NSMutableArray array];
    }
    return _arrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = RGBACOLOR(225, 235, 225, 1);
    
    [self loadBody];
    
    self.selNum = 15;
    
}
//(50, 119, 198, 1)
-(void)loadBody{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,KScreen_W, STATE_BAR_HEIGHT + 52)];
    navView.backgroundColor = RGBACOLOR(50, 119, 198, 1);
    [self.view addSubview:navView];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, STATE_BAR_HEIGHT + 8 , KScreen_W , 32)];
    titleL.text = @"Tomato timer";
    titleL.font = [UIFont fontWithName:@"Trebuchet MS" size:25];;
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = RGBACOLOR(255, 255, 255, 1);
    [navView addSubview:titleL];
    
    UIButton *backBtn = [[UIButton alloc] init];;
    backBtn.frame = CGRectMake(KScreen_W - 50, STATE_BAR_HEIGHT + 8,32 , 32);
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"endimage"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    UIView *StartView = [[UIView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(titleL.frame) + 90, (KScreen_W - 80), (KScreen_W - 80))];
    StartView.layer.borderColor = RGBACOLOR(50, 119, 198, 1).CGColor;
    StartView.layer.borderWidth = 5.0f;
    [StartView setBackgroundColor:RGBACOLOR(215, 250, 235, 1)];
    StartView.layer.masksToBounds = YES;
    StartView.layer.cornerRadius = (KScreen_W - 70) / 2;
    [self.view  addSubview:StartView];

    
    UILabel *countdownLabel = [[UILabel alloc] initWithFrame:StartView.bounds];
    countdownLabel.text = @"15:00";
    self.countdownLabel = countdownLabel;
    countdownLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:64];;
    countdownLabel.textAlignment = NSTextAlignmentCenter;
    countdownLabel.textColor = RGBACOLOR(25, 55, 25, 1);
    [StartView addSubview:countdownLabel];
    

    CGFloat mar = 10;
    CGFloat btn_w = (KScreen_W - mar * 8) / 7;
    CGFloat btn_h = btn_w;
    CGFloat image_w = (KScreen_W - mar * 3)/2;
    CGFloat image_h = btn_h;
    
    NSArray *array = @[@"1",@"5",@"10",@"15",@"20",@"30",@"60"];
    
    for (int a = 0; a < array.count; a ++) {
        UIButton *numBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        numBtn.layer.cornerRadius = 4;
        numBtn.layer.masksToBounds = YES;
        numBtn.frame = CGRectMake(mar + (mar + btn_w) * a, CGRectGetMaxY(StartView.frame) + 75, btn_w, btn_w);
        [numBtn addTarget:self action:@selector(numClick:) forControlEvents:UIControlEventTouchUpInside];
        [numBtn setTitleColor:RGBACOLOR(50, 119, 198, 1) forState:UIControlStateNormal];
        numBtn.tag = a;
        numBtn.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        [numBtn setTitle:array[a] forState:UIControlStateNormal];
        numBtn.titleLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
        [self.view addSubview:numBtn];
        [self.arrM addObject:numBtn];
    }
    
    
    UIButton *btn = self.arrM[3];
    [self numClick:btn];
    
    UIButton *btns = [UIButton buttonWithType:UIButtonTypeCustom];
    btns.layer.cornerRadius = 4;
    btns.layer.masksToBounds = YES;
    btns.frame = CGRectMake(mar, CGRectGetMaxY(StartView.frame) + 136, (KScreen_W - mar * 2), image_h);
    [btns addTarget:self action:@selector(btnsClick:) forControlEvents:UIControlEventTouchUpInside];
    [btns setTitleColor:RGBACOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    btns.backgroundColor = RGBACOLOR(50, 119, 198, 1);
    [btns setTitle:@"Start" forState:UIControlStateNormal];
    btns.titleLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
    [self.view addSubview:btns];
    
    UIButton *PauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    PauseBtn.layer.cornerRadius = 4;
    PauseBtn.layer.masksToBounds = YES;
    self.pauseBtn = PauseBtn;
    PauseBtn.frame = CGRectMake(mar, CGRectGetMaxY(StartView.frame) + 136, image_w, image_h);
    PauseBtn.hidden = YES;
    [PauseBtn addTarget:self action:@selector(PauseClick) forControlEvents:UIControlEventTouchUpInside];
    [PauseBtn setTitleColor:RGBACOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    PauseBtn.backgroundColor = RGBACOLOR(50, 119, 198, 1);
    [PauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
    PauseBtn.titleLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
    [self.view addSubview:PauseBtn];
    
    UIButton *StartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    StartBtn.layer.cornerRadius = 4;
    self.startBtn = StartBtn;
    StartBtn.hidden = YES;
    StartBtn.layer.masksToBounds = YES;
    StartBtn.frame = CGRectMake(mar + CGRectGetMaxX(PauseBtn.frame), CGRectGetMaxY(StartView.frame) + 136, image_w, image_h);
    [StartBtn addTarget:self action:@selector(StartClick) forControlEvents:UIControlEventTouchUpInside];
    [StartBtn setTitleColor:RGBACOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    StartBtn.backgroundColor = RGBACOLOR(50, 119, 198, 1);
    [StartBtn setTitle:@"Start" forState:UIControlStateNormal];
    StartBtn.titleLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:24];
    [self.view addSubview:StartBtn];
    
    NSString *testString = @"H";
    [testString reverseString];
    [testString uselessMethod];
    (long)[testString randomInteger];
//    (50, 119, 198, 1)
}

-(void)btnsClick:(UIButton *)btn{
    NSInteger times = self.selNum;
    [self startCountdownWithDuration:times * 60]; // 600秒 = 10分钟
    
    btn.hidden = YES;
    self.startBtn.hidden = NO;
    self.pauseBtn.hidden = NO;
    self.isBegin = YES;
}

-(void)StartClick{
    if (self.isBegin) {
        [self.timer setFireDate:[NSDate date]];
    }else{
        NSInteger times = self.selNum;
        [self startCountdownWithDuration:times * 60]; // 600秒 = 10分钟
    }

    self.isBegin = YES;
}

-(void)PauseClick{
    [self.timer setFireDate:[NSDate distantFuture]];
}

-(void)numClick:(UIButton *)btn{
    [_selBtn setTitleColor:RGBACOLOR(50, 119, 198, 1) forState:UIControlStateNormal];
    _selBtn.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    
    btn.backgroundColor = RGBACOLOR(50, 119, 198, 1);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _selBtn = btn;
    
    [self.timer setFireDate:[NSDate distantFuture]];

    if (btn.tag == 0) {
        self.countdownLabel.text = @"01:00";
    }
    
    if (btn.tag == 1) {
        self.countdownLabel.text = @"05:00";
    }
    
    if (btn.tag == 2) {
        self.countdownLabel.text = @"10:00";
    }
    
    if (btn.tag == 3) {
        self.countdownLabel.text = @"15:00";
    }
    
    if (btn.tag == 4) {
        self.countdownLabel.text = @"20:00";
    }
    
    if (btn.tag == 5) {
        self.countdownLabel.text = @"30:00";
    }
    
    if (btn.tag == 6) {
        self.countdownLabel.text = @"60:00";
    }
    
    self.selNum = [btn.titleLabel.text integerValue];
    self.isBegin = NO;
}

- (void)startCountdownWithDuration:(NSTimeInterval)duration {
    self.remainingTime = duration;
    [self updateCountdownLabel];

    // 使用NSTimer来每秒更新倒计时
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdownTimerTicked:) userInfo:nil repeats:YES];
}

- (void)countdownTimerTicked:(NSTimer *)timer {
    if (self.remainingTime > 0) {
        self.remainingTime -= 1.0; // 减少剩余时间
        [self updateCountdownLabel]; // 更新Label显示
    } else {
        // 倒计时结束，可以停止定时器并处理结束逻辑
        [timer invalidate];
        self.countdownLabel.text = @"Countdown ends";
        self.countdownLabel.font = [UIFont systemFontOfSize:27];
    }
}

- (void)updateCountdownLabel {
    // 将剩余时间转换为时分秒格式
    int minutes = (int)(self.remainingTime / 60);
    int seconds = (int)(self.remainingTime % 60);
    // 注意：如果seconds是个位数，我们需要在前面添加一个0
    NSString *secondsStr = [NSString stringWithFormat:@"%02d", seconds];
    // 更新Label的文本
    self.countdownLabel.text = [NSString stringWithFormat:@"%02d:%@", minutes, secondsStr];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

@end
