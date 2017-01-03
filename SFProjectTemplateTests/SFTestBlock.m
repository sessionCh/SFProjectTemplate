//
//  SFTestBlock.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFTestBlock.h"

@interface SFTestBlock ()

@property (nonatomic, copy) NSString* (^blockName2)(NSString *param);

@end


@implementation SFTestBlock
{
    SFDidClickBlock _blockName4;
}

- (void)didClick
{
    if (self.blockName1) {
        self.blockName1(@"param1");
    }
    
    if (self.blockName2) {
        self.blockName2(@"param2");
    }
    
    if (self.blockName3) {
        self.blockName3(@"param3");
    }
    
    if (_blockName4) {
        _blockName4(@"param4");
    }
}

- (void)testBlock:(SFTestBlock *)testBlock didClickBlock:(NSString *(^)(NSString *param))blockName2
{
    self.blockName2 = blockName2;
}

- (void)testBlock:(SFTestBlock *)testBlock didClickBlock4:(SFDidClickBlock)blockName4
{
    _blockName4 = blockName4;
}

@end
