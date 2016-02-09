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
@property (nonatomic, strong) IBOutlet UIView *pickerView;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UIView *timerView;
@property (nonatomic, strong) IBOutlet UILabel *timerLabel;
@property (nonatomic, strong) IBOutlet UIButton *leftButton;
@property (nonatomic, strong) IBOutlet UIButton *rightButton;
- (IBAction)actionLeftButton:(UIButton *)sender;
- (IBAction)actionRightButton:(UIButton *)sender;
- (void)setRightButtonEnabled:(BOOL)enabled;
- (void)showPickerView:(BOOL)show;
+ (void)setTitle:(NSString *)title forButton:(UIButton *)button;
+ (void)setTitleColor:(UIColor *)titleColor forButton:(UIButton *)button;
@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.timerLabel setText:DEFAULT_TIMER_TEXT];
    [self.datePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
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
        [FISViewController setTitle:CANCEL_TEXT forButton:self.leftButton];
        [FISViewController setTitleColor:CANCEL_COLOR forButton:self.leftButton];
        [self setRightButtonEnabled:YES];
        [self.pickerView setHidden:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:CANCEL_TEXT])
    {
        [FISViewController setTitle:START_TEXT forButton:self.leftButton];
        [FISViewController setTitleColor:START_COLOR forButton:self.leftButton];
        [FISViewController setTitle:PAUSE_TEXT forButton:self.rightButton];
        [self setRightButtonEnabled:NO];
        [self.pickerView setHidden:NO];
    }
}

- (IBAction)actionRightButton:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:PAUSE_TEXT])
    {
        [FISViewController setTitle:PAUSED_TEXT forButton:self.rightButton];
    }
    else if ([sender.titleLabel.text isEqualToString:PAUSED_TEXT])
    {
        [FISViewController setTitle:PAUSE_TEXT forButton:self.rightButton];
    }
}

- (void)setRightButtonEnabled:(BOOL)enabled
{
    [self.rightButton setEnabled:enabled];
    [FISViewController setTitleColor:(enabled ? RIGHTBUTTON_ENABLED_COLOR : RIGHTBUTTON_DISABLED_COLOR) forButton:self.rightButton];
}

- (void)showPickerView:(BOOL)show
{
    [self.pickerView setHidden:!show];
    if (show) [self.timerLabel setText:DEFAULT_TIMER_TEXT];
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
//    [button setTitleColor:titleColor forState:UIControlStateSelected];
//    [button setTitleColor:titleColor forState:UIControlStateHighlighted];
}

@end
