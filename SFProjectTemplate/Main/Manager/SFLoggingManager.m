//
//  SFLoggingManager.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/24.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFLoggingManager.h"
#import <UIKit/UIKit.h>
#import <Aspects.h>

#define SFLoggingPageImpression @"SFLoggingPageImpression"
#define SFLoggingTrackedEvents @"SFLoggingTrackedEvents"
#define SFLoggingEventName @"SFLoggingEventName"
#define SFLoggingEventSelectorName @"SFLoggingEventSelectorName"
#define SFLoggingEventHandlerBlock @"SFLoggingEventHandlerBlock"

typedef void (^AspectHandlerBlock)(id<AspectInfo> aspectInfo);

@implementation SFLoggingManager

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
    }
    return self;
}

/**
 *  事件统计
 */
- (void)setupLogging
{
    NSDictionary *config = @{
                             // 为 视图 添加点 击事件统计
                             @"SFMarkProductCell": @{
                                     SFLoggingTrackedEvents: @[
                                             @{
                                                 SFLoggingEventName: @"SFMarkProductCell button clicked",
                                                 SFLoggingEventSelectorName: @"investClick:",
                                                 SFLoggingEventHandlerBlock: ^(id<AspectInfo> aspectInfo) {
                                                     NSLog(@"SFMarkProductCell button clicked");
                                                 },
                                                 }
                                             ],
                                     },
                             
                             // 为 视图控制器 添加点 事件统计
                             @"SFFinanceViewController": @{
                                     SFLoggingPageImpression: @"[SFFinanceViewController viewDidAppear]",
                                     },
                             
                             @"SFFinanceDetailViewController": @{
                                     SFLoggingPageImpression: @"[SFFinanceDetailViewController viewDidAppear]",
                                     }
                             };
    
    [self setupWithConfiguration:config];
}

- (void)setupWithConfiguration:(NSDictionary *)configs
{
    // Hook Page Impression
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                       NSString *className = NSStringFromClass([[aspectInfo instance] class]);
                                       NSString *pageImp = configs[className][SFLoggingPageImpression];
                                       if (pageImp) {
                                           NSLog(@"%@", pageImp);
                                       }
                                   });
                               } error:NULL];
    
    // Hook Events
    for (NSString *className in configs) {
        Class clazz = NSClassFromString(className);
        NSDictionary *config = configs[className];
        
        if (config[SFLoggingTrackedEvents]) {
            for (NSDictionary *event in config[SFLoggingTrackedEvents]) {
                SEL selekor = NSSelectorFromString(event[SFLoggingEventSelectorName]);
                AspectHandlerBlock block = event[SFLoggingEventHandlerBlock];
                
                [clazz aspect_hookSelector:selekor
                               withOptions:AspectPositionAfter
                                usingBlock:^(id<AspectInfo> aspectInfo) {
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                        block(aspectInfo);
                                    });
                                } error:NULL];
                
            }
        }
    }
}


@end
