
//
//  SFTimerManager.m
//  ZGPPT
//
//  Created by zngoo_mac7 on 15/12/10.
//  Copyright © 2015年 zngoo_mac7. All rights reserved.
//

#import "SFTimerManager.h"

#define SFKSMSTimerValue 0

@interface SFTimerManager ()

@property (nonatomic, assign) int smsTimeValue; // 短信验证码倒计时
@property (nonatomic, strong) NSTimer *smsTimer;

@end

@implementation SFTimerManager
{
    TimerAction _smsTimerAction;
}

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.smsTimeValue = SFKSMSTimerValue;
    }
    return self;
}

- (void)startTimer:(SFTimerType)type
{
    switch (type) {
        case SFTimerTypeSMSCode:
            [self startSMSTimer];
            break;
    }
}

- (void)stopTimer:(SFTimerType)type
{
    switch (type) {
        case SFTimerTypeSMSCode:
            [self stopSMSTimer];
            break;
    }
}

- (void)callBackWithSMSCodeTimerAction:(TimerAction)timerAction
{
    _smsTimerAction = timerAction;
}

#pragma mark - 私有方法

// 短信验证码
- (void)startSMSTimer {
    
    [self stopSMSTimer];
    if (_smsTimer == nil) {
        _smsTimeValue = SFKSMSTimerValue;
        _smsTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(smsTimerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_smsTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopSMSTimer {
    if (_smsTimer) {
        [_smsTimer invalidate];
        _smsTimer = nil;
    }
}

- (void)smsTimerAction {
    _smsTimeValue ++;
    if (_smsTimerAction) {
        _smsTimerAction(_smsTimeValue, SFTimerTypeSMSCode);
    }
    
    if (_smsTimeValue >= 100000) {
        [self stopSMSTimer];
    }
}

@end
