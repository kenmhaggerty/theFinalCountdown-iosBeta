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

@interface FISViewController ()
@property (nonatomic, strong) IBOutlet UIView *pickerView;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UIView *timerView;
@property (nonatomic, strong) IBOutlet UILabel *timerLabel;
@property (nonatomic, strong) IBOutlet UIButton *leftButton;
@property (nonatomic, strong) IBOutlet UIButton *rightButton;
- (IBAction)actionLeftButton:(UIButton *)sender;
- (IBAction)actionRightButton:(UIButton *)sender;
@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionLeftButton:(UIButton *)sender
{
    //
}

- (IBAction)actionRightButton:(UIButton *)sender
{
    //
}

@end
