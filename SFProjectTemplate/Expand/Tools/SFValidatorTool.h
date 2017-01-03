//
//  SFValidatorTool.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/28.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFValidatorTool : NSObject

/**
 *  验证是否由字母数字组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorCharacters:(NSString *)string;

/**
 *  验证是否由数字组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorNumbers:(NSString *)string;

/**
 *  验证是否由字母、数字、_、@ 组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorEmailCharacters:(NSString *)string;

@end
