//
//  SFTimerManager.h
//  ZGPPT
//
//  Created by zngoo_mac7 on 15/12/10.
//  Copyright © 2015年 zngoo_mac7. All rights reserved.
//

#import "SFBaseManager.h"

typedef NS_ENUM(NSInteger, SFTimerType) {
    SFTimerTypeSMSCode, // 短信验证码
};

typedef void (^TimerAction)(NSTimeInterval timeValue, SFTimerType type);

@interface SFTimerManager : SFBaseManager

+ (instancetype)shareInstance;

// 计时器回调
- (void)callBackWithSMSCodeTimerAction:(TimerAction)timerAction; // 短信验证码倒计时

- (void)startTimer:(SFTimerType)type; // 开启定时器

- (void)stopTimer:(SFTimerType)type; // 停止定时器

@end
