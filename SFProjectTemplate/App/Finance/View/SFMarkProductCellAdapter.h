//
//  SFMarkProductCellAdapter.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/29.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFMarkProductCell.h"

@interface SFMarkProductCellAdapter : NSObject <SFMarkProductCellProtocol>

/**
 *  输入对象
 */
@property (nonatomic, weak) id data;

/**
 *  与输入对象建立联系
 *
 *  @param data 输入的对象
 *
 *  @return 实例对象
 */
- (instancetype)initWithData:(id)data;

@end
