//
//  theFinalCountdownTests.m
//  theFinalCountdownTests
//
//  Created by Joe Burgess on 7/9/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"
#import "FISViewController.h"

SpecBegin(FISViewController)

describe(@"FISViewController", ^{
    
    __block FISViewController *viewController;
    __block NSDate *sixtyOneSeconds;
    __block NSDate *twoHoursOneMinuteFiftyNineSeconds;
    
    beforeAll(^{
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *duration = [calendar components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:[NSDate date]];
        
        [duration setHour:0];
        [duration setMinute:1];
        [duration setSecond:1];
        sixtyOneSeconds = [calendar dateFromComponents:duration];
        
        [duration setHour:2];
        [duration setMinute:1];
        [duration setSecond:59];
        twoHoursOneMinuteFiftyNineSeconds = [calendar dateFromComponents:duration];
    });
    
    beforeEach(^{
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UINavigationController *navController = [main instantiateViewControllerWithIdentifier:@"rootViewController"];
        viewController = [navController.childViewControllers firstObject];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = viewController;
    });
    
    describe(@"initial view", ^{
        
        it(@"should display picker view in portrait", ^{
            
            [tester waitForViewWithAccessibilityLabel:@"picker view"];
        });
        
        it(@"should display buttons in portrait", ^{
            
            [tester waitForViewWithAccessibilityLabel:@"left button"];
            [tester waitForViewWithAccessibilityLabel:@"right button"];
        });
        
        it(@"should display left button with text Start", ^{
            UIButton *leftButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:@"left button"];
            
            expect(leftButton.titleLabel.text).to.equal(@"Start");
        });
        
        /*
        it(@"should display left button with green tint", ^{
            UIButton *leftButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:@"left button"];
            
            expect(leftButton.tintColor).to.equal([UIColor greenColor]);
        });
         */
        
        it(@"should display right button with text Pause", ^{
            UIButton *rightButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:@"right button"];
            
            expect(rightButton.titleLabel.text).to.equal(@"Pause");
        });
        
        /*
        it(@"should display right button with black tint", ^{
            UIButton *rightButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:@"right button"];
            
            expect(rightButton.tintColor).to.equal([UIColor blackColor]);
        });
         */
        
        it(@"should display right button as disabled", ^{
            UIButton *rightButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:@"right button"];
            
            expect(rightButton.enabled).to.beFalsy;
        });
        
        /*
         
        it(@"should display countdown in landscape", ^{
            // rotate device
            
            [tester waitForViewWithAccessibilityLabel:@"countdown"];
        });
        
        it(@"should hide picker view in landscape", ^{
            // rotate device
            
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"picker view"];
        });
        
        it(@"should hide buttons in landscape", ^{
            // rotate device
            
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"left button"];
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"right button"];
        });
         
         */
    });
    
    describe(@"left button", ^{
        
        it(@"should display countdown when starting timer", ^{
            [tester tapViewWithAccessibilityLabel:@"left button"];
            
            [tester waitForViewWithAccessibilityLabel:@"countdown"];
        });
        
        it(@"should display 01:01 when starting timer with 61 seconds", ^{
            UIDatePicker *pickerView = (UIDatePicker *)[tester waitForViewWithAccessibilityLabel:@"picker view"];
            [pickerView setDate:sixtyOneSeconds animated:NO];
            [tester tapViewWithAccessibilityLabel:@"left button"];
            UILabel *countdown = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"countdown"];
            
            expect(countdown.text).to.equal(@"01:01");
        });
        
        it(@"should display 02:01:59 when starting timer with 7319 seconds", ^{
            UIDatePicker *pickerView = (UIDatePicker *)[tester waitForViewWithAccessibilityLabel:@"picker view"];
            [pickerView setDate:twoHoursOneMinuteFiftyNineSeconds animated:NO];
            [tester tapViewWithAccessibilityLabel:@"left button"];
            UILabel *countdown = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"countdown"];
            
            expect(countdown.text).to.equal(@"02:01:59");
        });
        
        it(@"should hide picker view when starting timer", ^{
            [tester tapViewWithAccessibilityLabel:@"left button"];
            
            [tester waitForAbsenceOfViewWithAccessibilityLabel:@"picker view"];
        });
        
        it(@"should enable right button after tapping", ^{
            UIButton *rightButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:@"right button"];
            [tester tapViewWithAccessibilityLabel:@"left button"];
            
            expect(rightButton.enabled).to.beTruthy;
        });
        
        it(@"should have text Cancel after tapping", ^{
            UIButton *leftButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:@"left button"];
            [tester tapViewWithAccessibilityLabel:@"left button"];
            
            expect(leftButton.titleLabel.text).to.equal(@"Cancel");
        });
        
        /*
        it(@"should have red tint color after tapping", ^{
            UIButton *leftButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:@"left button"];
            [tester tapViewWithAccessibilityLabel:@"left button"];
            
            expect(leftButton.tintColor).to.equal([UIColor redColor]);
        });
         */
        
        it(@"should display picker view when canceling timer", ^{
            [tester tapViewWithAccessibilityLabel:@"left button"];
            [tester tapViewWithAccessibilityLabel:@"left button"];
            
            [tester waitForViewWithAccessibilityLabel:@"picker view"];
        });
        
        it(@"should disable right button after canceling timer", ^{
            UIButton *rightButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:@"right button"];
            [tester tapViewWithAccessibilityLabel:@"left button"];
            [tester tapViewWithAccessibilityLabel:@"left button"];
            
            expect(rightButton.enabled).to.beFalsy;
        });
        
    });
    
    describe(@"countdown", ^{
        
        it(@"should read 00:59 two seconds after 01:01", ^{
            UIDatePicker *pickerView = (UIDatePicker *)[tester waitForViewWithAccessibilityLabel:@"picker view"];
            [pickerView setDate:sixtyOneSeconds animated:NO];
            [tester tapViewWithAccessibilityLabel:@"left button"];
            dispatch_after(2, dispatch_get_main_queue(), ^{
                UILabel *countdown = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"countdown"];
                
                expect(countdown.text).to.equal(@"00:59");
            });
        });
        
    });
    
});

SpecEnd
