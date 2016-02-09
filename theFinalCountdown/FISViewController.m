//
//  FISViewController.m
//  theFinalCountdown
//
//  Created by Joe Burgess on 7/9/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

#define START_TEXT @"Start"
#define START_COLOR [UIColor greenColor]
#define CANCEL_TEXT @"Cancel"
#define CANCEL_COLOR [UIColor redColor]
#define PAUSE_TEXT @"Pause"
#define PAUSED_TEXT @"Resume"
#define RIGHTBUTTON_ENABLED_COLOR [UIColor blackColor]
#define RIGHTBUTTON_DISABLED_COLOR [UIColor darkGrayColor]
#define DEFAULT_TIMER_TEXT @"00:00:00"

@interface FISViewController ()
@property (nonatomic, strong) IBOutlet UIView *pickerSuperview;
@property (nonatomic, strong) IBOutlet UIDatePicker *pickerView;
@property (nonatomic, strong) IBOutlet UIView *timerSuperview;
@property (nonatomic, strong) IBOutlet UILabel *timerLabel;
@property (nonatomic, strong) IBOutlet UIButton *leftButton;
@property (nonatomic, strong) IBOutlet UIButton *rightButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSUInteger elapsedSeconds;
- (IBAction)actionLeftButton:(UIButton *)sender;
- (IBAction)actionRightButton:(UIButton *)sender;
- (void)setRightButtonEnabled:(BOOL)enabled;
- (void)startTimer;
- (void)stopTimer;
- (void)tick;
+ (void)setTitle:(NSString *)title forButton:(UIButton *)button;
+ (void)setTitleColor:(UIColor *)titleColor forButton:(UIButton *)button;
+ (NSString *)textForSeconds:(NSUInteger)seconds;
@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pickerView setAccessibilityLabel:@"picker view"];
    
    [self.timerLabel setText:DEFAULT_TIMER_TEXT];
    [self.pickerView setDatePickerMode:UIDatePickerModeCountDownTimer];
    [self setRightButtonEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionLeftButton:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:START_TEXT])
    {
        [self setElapsedSeconds:0];
        [self startTimer];
        [FISViewController setTitle:CANCEL_TEXT forButton:self.leftButton];
        [FISViewController setTitleColor:CANCEL_COLOR forButton:self.leftButton];
        [self setRightButtonEnabled:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:CANCEL_TEXT])
    {
        [self stopTimer];
        [FISViewController setTitle:START_TEXT forButton:self.leftButton];
        [FISViewController setTitleColor:START_COLOR forButton:self.leftButton];
        [FISViewController setTitle:PAUSE_TEXT forButton:self.rightButton];
        [self setRightButtonEnabled:NO];
        [self.pickerSuperview setHidden:NO];
    }
}

- (IBAction)actionRightButton:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:PAUSE_TEXT])
    {
        [self stopTimer];
        [FISViewController setTitle:PAUSED_TEXT forButton:self.rightButton];
    }
    else if ([sender.titleLabel.text isEqualToString:PAUSED_TEXT])
    {
        [self startTimer];
        [FISViewController setTitle:PAUSE_TEXT forButton:self.rightButton];
    }
}

- (void)setRightButtonEnabled:(BOOL)enabled
{
    [self.rightButton setEnabled:enabled];
    [FISViewController setTitleColor:(enabled ? RIGHTBUTTON_ENABLED_COLOR : RIGHTBUTTON_DISABLED_COLOR) forButton:self.rightButton];
}

- (void)startTimer
{
    [self setTimer:[NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(tick) userInfo:nil repeats:YES]];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer fire];
}

- (void)stopTimer
{
    [self.timer invalidate];
}

- (void)tick
{
    NSUInteger secondsLeft = self.pickerView.countDownDuration-self.elapsedSeconds;
    if (secondsLeft <= 0)
    {
        [self stopTimer];
        [self.timerLabel setText:@"DONE"];
        [self.rightButton setEnabled:NO];
        return;
    }
    
    [self.timerLabel setText:[FISViewController textForSeconds:secondsLeft]];
    [self.pickerSuperview setHidden:YES];
    self.elapsedSeconds++;
}

+ (void)setTitle:(NSString *)title forButton:(UIButton *)button
{
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateFocused];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateHighlighted];
}

+ (void)setTitleColor:(UIColor *)titleColor forButton:(UIButton *)button
{
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateFocused];
}

+ (NSString *)textForSeconds:(NSUInteger)seconds
{
    NSMutableString *text = [NSMutableString string];
    NSUInteger hours = floorf(seconds/(60.0f*60.0f));
    if (hours) [text appendFormat:@"%02lu:", hours];
    float minutes = seconds/60.0f;
    minutes = floorf(minutes);
    minutes = (int)minutes % 60;
    return [text stringByAppendingFormat:@"%02i:%02lu", (int)floorf(seconds/60.0f) % 60, seconds % 60];
}

@end
