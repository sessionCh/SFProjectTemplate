//
//  SFInputValidator.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/27.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SFInputValidator : NSObject

/**
 *  策略的输入 (结束编辑时校验)
 *
 *  @param input
 *
 *  @return 如果为NO,表示校验不通过
 */
- (BOOL)validateInput:(UITextField *)input;

/**
 *  校验不通过,返回的信息
 */
@property (nonatomic, strong) NSString *errorMessage;

/**
 *  策略的输入（每次输入字符时校验）
 *  @param string 新输入的字符
 *  @param textField
 *  @param range  输入的范围
 *
 *  @return 如果为NO,表示输入字符无效，不修改输入框内容
 */
- (BOOL)validateCharacter:(NSString*)string textField:(UITextField*)textField range:(NSRange)range;

/**
 *  剔除卡号里的非法字符(仅保留数字)
 *
 *  @param s 需要处理的字符串
 *
 *  @return 处理后的字符串
 */
- (NSString *)getDigitsOnly:(NSString *)s;

/**
 *  格式化输入框中的内容
 *
 *  @param textField 输入框
 *  @param string    当前改变的字符串
 *  @param range     改变字符串所在位置
 *  @param maxLen     格式化后字符串最大长度
 *
 *  @return 是否有效改变
 */
- (BOOL)formatTextField:(UITextField *)textField validateCharacter:(NSString *)string range:(NSRange)range maxLen:(NSInteger)maxLen;

/**
 *  显示错误提示
 *
 *  @param errorMessage
 */
- (void)showErrorMessage:(NSString *)errorMessage;

@end
