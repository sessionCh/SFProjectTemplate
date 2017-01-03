//
//  SFPopView.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/8.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SFPopView;

typedef NS_ENUM(NSInteger, SFPopViewBtnType) {
    SFPopViewBtnTypeCancel,
    SFPopViewBtnTypeSure
};

typedef void(^SFPopViewBlock)(NSInteger buttonIndex, SFPopView *popView);

@interface SFPopView : UIView

+ (SFPopView *)popViewWithTitle:(NSString *)title clicked:(SFPopViewBlock)clicked;

- (void)show;
- (void)dismiss;

@end
