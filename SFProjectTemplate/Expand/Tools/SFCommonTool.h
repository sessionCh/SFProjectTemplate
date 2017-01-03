//
//  SFCommonTool.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFCommonTool : NSObject
/**
*  科学计数法，保留n个有效值
*
*  @param d 传入的数值
*  @param n 有效位数
*
*  @return
*/
+ (NSString *)toExponent:(double)d rms:(unsigned)n;

@end
