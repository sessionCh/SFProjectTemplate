//
//  SFShareView.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/21.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HXOriginX 15.0 //ico起点X坐标
#define HXOriginY 15.0 //ico起点Y坐标
#define HXIcoWidth 57.0 //正方形图标宽度
#define HXIcoAndTitleSpace 10.0 //图标和标题间的间隔
#define HXTitleSize 10.0 //标签字体大小
#define HXTitleColor [UIColor colorWithRed:52/255.0 green:52/255.0 blue:50/255.0 alpha:1.0] //标签字体颜色
#define HXLastlySpace 15.0 //尾部间隔
#define HXHorizontalSpace 15.0 //横向间距

@interface SFShareView : UIView

@property (nonatomic,assign) float originX;//ico起点X坐标
@property (nonatomic,assign) float originY;//ico起点Y坐标
@property (nonatomic,assign) float icoWidth;//正方形图标宽度
@property (nonatomic,assign) float icoAndTitleSpace;//图标和标题间的间隔
@property (nonatomic,assign) float titleSize;//标签字体大小
@property (nonatomic,strong) UIColor *titleColor;//标签字体颜色
@property (nonatomic,assign) float lastlySpace;//尾部间隔
@property (nonatomic,assign) float horizontalSpace;//横向间距

/**
 *  显示分享按钮
 */
+ (void)showShareView;

@end
