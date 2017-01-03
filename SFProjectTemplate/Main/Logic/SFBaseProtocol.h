//
//  SFBaseProtocol.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//  管理类统一实现的协议

#import <Foundation/Foundation.h>

@protocol SFBaseProtocol <NSObject>

@required

/**
 *	程序启动时调用:统一加载
 */
- (void)load;

@end
