//
//  SFMarkProductCellAdapter.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/29.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFMarkProductCellAdapter.h"

@implementation SFMarkProductCellAdapter

- (instancetype)initWithData:(id)data {
    
    self = [super init];
    if (self) {
        
        self.data = data;
    }
    
    return self;
}

// 重写这些方法
- (NSString *)iconName {
    return nil;
}
- (BOOL)closed {
    return YES;
}
- (NSString *)title {
    return nil;
}
- (NSString *)markTitle {
    return nil;
}
- (NSString *)markImgName {
    return nil;
}
- (NSString *)arrowImgName {
    return nil;
}
- (NSMutableAttributedString *)rate {
    return nil;
}
- (NSString *)rateTitle {
    return nil;
}
- (NSMutableAttributedString *)borrowTime {
    return nil;
}
- (NSString *)borrowTimeTitle {
    return nil;
}

@end
