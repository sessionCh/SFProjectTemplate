//
//  SFDropDownHeaderView.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/26.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SFDidSelectItemBlock)(NSIndexPath *indexPath, NSString *title);

@interface SFDropDownHeaderView : UIView

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger selectIndex;

- (void)didSelectItemBlock:(SFDidSelectItemBlock)block;

- (void)updateUI:(NSIndexPath *)indexPath title:(NSString *)title;

- (void)changeSelectedColor:(UIColor *)color;

@end
