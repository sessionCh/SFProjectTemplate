//
//  SFViewControllerIntercepter.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/24.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFViewControllerIntercepter.h"
#import "Aspects.h"

@implementation SFViewControllerIntercepter

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        [UIViewController aspect_hookSelector:@selector(loadView) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            [self loadView:[aspectInfo instance]];
        } error:NULL];
        
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            [self viewWillAppear:animated viewController:[aspectInfo instance]];
        } error:NULL];
    }
    return self;
}

#pragma mark - fake methods

- (void)loadView:(UIViewController *)viewController
{
    NSLog(@"[%@ loadView]", [viewController class]);
}

- (void)viewWillAppear:(BOOL)animated viewController:(UIViewController *)viewController
{
    NSLog(@"[%@ viewWillAppear:%@]", [viewController class], animated ? @"YES" : @"NO");
}

@end
