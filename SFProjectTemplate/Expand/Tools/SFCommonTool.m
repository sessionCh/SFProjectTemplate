
//
//  SFCommonTool.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFCommonTool.h"

@implementation SFCommonTool

/**
 *  科学计数法，保留n个有效值
 *
 *  @param d 传入的数值
 *  @param n 有效位数
 *
 *  @return
 */
+ (NSString *)toExponent:(double)d rms:(unsigned)n
{
    if(n==0)
    {
        return nil;
    }
    CFLocaleRef currentLocale = CFLocaleCopyCurrent();
    CFNumberFormatterRef customCurrencyFormatter = CFNumberFormatterCreate
    (NULL, currentLocale, kCFNumberFormatterCurrencyStyle);
    NSString *s_n = @"#";
    if(n > 1)
    {
        for(int j = 0; j < n; j++)
        {
            NSString *temp = s_n;
            if(j == 0)
            {
                s_n = [temp stringByAppendingString:@"."];
            }
            else
            {
                s_n = [temp stringByAppendingString:@"0"];
            }
            
        }
        
    }
    CFNumberFormatterSetFormat(customCurrencyFormatter, (CFStringRef)s_n);
    
    double i=1;
    int exponent = 0;
    while (1) {
        i = i*10;
        exponent++;
        if(d < i)
        {
            break;
        }
    }
    double n1 = d * 10 / i;
    
    CFNumberRef number1 = CFNumberCreate(NULL, kCFNumberDoubleType, &n1);
    CFStringRef string1 = CFNumberFormatterCreateStringWithNumber
    (NULL, customCurrencyFormatter, number1);
    
    NSString * result = [NSString stringWithFormat:@"%s E%d",CFStringGetCStringPtr(string1, CFStringGetSystemEncoding()),exponent];
    
    CFRelease(currentLocale);
    CFRelease(customCurrencyFormatter);
    CFRelease(number1);
    CFRelease(string1);
    
    return result;
}

@end
