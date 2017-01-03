//
//  SFMarkProductModelAdapter.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/29.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFMarkProductModelAdapter.h"
#import "SFMarkProductModel.h"

@interface SFMarkProductModelAdapter ()

@property (nonatomic, strong) SFMarkProductModel *model;

@end

@implementation SFMarkProductModelAdapter

- (instancetype)initWithData:(id)data {
    
    self = [super init];
    if (self) {
        
        self.data = data;
    }
    
    return self;
}

- (SFMarkProductModel *)model
{
    return self.data;
}

// 重写这些方法
- (NSString *)iconName {
    return self.model.logoUrl;
}

- (BOOL)closed {
    return YES;
}

- (NSString *)title {
    return self.model.borrowTitle;
}

- (NSString *)markTitle {
    return self.model.borrowStatus ? @"可转" : nil;
}

- (NSString *)markImgName {
    return nil;
}

- (NSString *)arrowImgName {
    return nil;
}

- (NSMutableAttributedString *)rate {
    
    NSString *rateStr = [NSString stringWithFormat:@"%.1f%%", (CGFloat)self.model.annualRate];
    
    return [self adjustLabeTextAttributedText:rateStr];
}

- (NSString *)rateTitle {
    return nil;
}

- (NSMutableAttributedString *)borrowTime {
    
    NSString *text1 = [NSString stringWithFormat:@"%ld", self.model.deadline];
    NSString *text2 = @"个月";
    NSString *orginStr = [NSString stringWithFormat:@"%@%@",text1,text2];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:orginStr];
    
    NSRange minRange = [orginStr rangeOfString:text1];
    NSRange waveRange = [orginStr rangeOfString:text2];
    
    [string addAttribute:(NSString *)NSFontAttributeName
                   value:[UIFont systemFontOfSize:34]
                   range:minRange];
    [string addAttribute:(NSString *)NSFontAttributeName
                   value:[UIFont systemFontOfSize:16]
                   range:waveRange];
    
    return string;
}

- (NSString *)borrowTimeTitle {
    
    return nil;
}

- (NSMutableAttributedString *)adjustLabeTextAttributedText:(NSString *)text
{
    NSArray *arr = [text componentsSeparatedByString:@"."];
    
    NSString *text1 = arr[0];
    NSString *text2 = [NSString stringWithFormat:@".%@",arr[1]];
    
    NSString *orginStr = [NSString stringWithFormat:@"%@%@",text1,text2];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:orginStr];
    
    NSRange minRange = [orginStr rangeOfString:text1];
    NSRange waveRange = [orginStr rangeOfString:text2];
    
    [string addAttribute:(NSString *)NSFontAttributeName
                   value:[UIFont systemFontOfSize:34]
                   range:minRange];
    [string addAttribute:(NSString *)NSFontAttributeName
                   value:[UIFont systemFontOfSize:16]
                   range:waveRange];
    
    return string;
}

@end
