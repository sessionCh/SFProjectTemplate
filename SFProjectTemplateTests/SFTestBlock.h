//
//  SFTestBlock.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  NSString* (^SFDidClickBlock)(NSString *param);

@interface SFTestBlock : NSObject

@property (nonatomic, copy) NSString* (^blockName1)(NSString *param);

- (void)testBlock:(SFTestBlock *)testBlock didClickBlock:(NSString* (^)(NSString *param))blockName2;

- (void)didClick;

@property (nonatomic, copy) SFDidClickBlock blockName3;

- (void)testBlock:(SFTestBlock *)testBlock didClickBlock4:(SFDidClickBlock)blockName4;

@end
