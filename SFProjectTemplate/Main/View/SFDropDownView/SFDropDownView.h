//
//  SFDropDownView.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/26.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SFDropDownCellStyle) {
    SFDropDownCellStyleDefault,
    SFDropDownCellStyleSingle
};

typedef void (^SFDidSelectItemBlock)(NSIndexPath *indexPath, NSString *title); // 选中回调
typedef void (^SFDismissCompletionBlock)(); // 消失后回调

@interface SFDropDownView : UIView

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, assign) SFDropDownCellStyle style; // cell风格
@property (nonatomic, assign) NSInteger row; // 显示多少列

- (void)didSelectItemBlock:(SFDidSelectItemBlock)block;
- (void)dismissCompletionBlock:(SFDismissCompletionBlock)block;

- (void)dismiss;
- (void)show;

- (void)setCollectionFrame:(CGRect)frame;

- (BOOL)getIsShow;

@end
