
//
//  SFValidatorTool.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/28.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFValidatorTool.h"

@implementation SFValidatorTool

/**
 *  验证是否由字母数字组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorCharacters:(NSString *)string
{
    NSCharacterSet* charSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

/**
 *  验证是否由数字组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorNumbers:(NSString *)string
{
    NSCharacterSet* charSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

/**
 *  验证是否由字母、数字、_@.+- 组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorEmailCharacters:(NSString *)string
{
    NSCharacterSet* charSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_@.+-"]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}


@end
