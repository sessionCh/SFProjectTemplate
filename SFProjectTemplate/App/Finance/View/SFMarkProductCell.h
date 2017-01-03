//
//  SFMarkProductCell.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/28.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SFMarkProductType) {
    SFMarkProductTypeTicket = 1,        // 票
    SFMarkProductTypeRedeem,            // 赎
    SFMarkProductTypeRoom               // 房
};

@protocol SFMarkProductCellProtocol <NSObject>

// 头部分
- (NSString *)iconName;
- (BOOL)closed;
- (NSString *)title;
- (NSString *)markTitle;
- (NSString *)markImgName;
- (NSString *)arrowImgName;

// 中间部分
- (NSMutableAttributedString *)rate;
- (NSString *)rateTitle;
- (NSMutableAttributedString *)borrowTime;
- (NSString *)borrowTimeTitle;

@end

@interface SFMarkProductCell : UITableViewCell

- (void)loadData:(id <SFMarkProductCellProtocol>)data;

@end
