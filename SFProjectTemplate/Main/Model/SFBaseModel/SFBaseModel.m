//
//  SFBaseModel.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseModel.h"

@implementation SFBaseModel

- (void) setNilValueForKey:(NSString *)key{};
- (void) setValue:(id)value forUndefinedKey:(NSString *)key{}
- (void) setValue:(id)value forKey:(NSString *)key
{
    @try {
        [super setValue:value forKey:key];
    }
    @catch (NSException *exception) {
        NSLog(@"当前 model 发生错误，error：key = %@, value = %@", key, value);
    }
    @finally {}
}

@end
