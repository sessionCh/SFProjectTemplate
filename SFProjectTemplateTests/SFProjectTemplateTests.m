//
//  SFProjectTemplateTests.m
//  SFProjectTemplateTests
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Replace.h"
#import "Macros.h"
#import "SFDealNullTool.h"
#import "NSMutableArray+Safe.h"
#import "SFCommonTool.h"
#import "SFTestBlock.h"

@interface SFProjectTemplateTests : XCTestCase

@end

@implementation SFProjectTemplateTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    NSLog(@"(18948174842)-->(%@)", [@"18948174842" replaceCharacter:@"*" startIndex:3 lastSaveCount:4]);
    
    NSLog(@"(420921199111174434)-->(%@)", [@"420921199111174434" replaceCharacter:@"*" startIndex:0 lastSaveCount:4]);
    
    
    NSLog(@"---->(%d)", SFIsNull([NSNull new]));
    NSLog(@"---->(%d)", SFIsNull([NSConstantString new]));

}

- (void)testSwizzleMethod {
    
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
    [mArr addObject:@"1"];
    [mArr addObject:@"2"];
    [mArr addObject:@"3"];
    NSLog(@"---->(%@)", [mArr objectAtIndex:1]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testCommonts {
    
    NSString *exponentStr = [SFCommonTool toExponent:15000.0 rms:3];
    NSLog(@"%@", exponentStr);
}

- (void)testBlock {
    
    SFTestBlock *testBlock = [SFTestBlock new];
    testBlock.blockName1 = ^NSString* (NSString *param) {
        NSLog(@"--(%@)--", param);
        return param;
    };
    [testBlock testBlock:testBlock didClickBlock:^NSString* (NSString *param) {
        NSLog(@"--(%@)--", param);
        return param;
    }];
    
    testBlock.blockName3 = ^NSString* (NSString *param) {
        NSLog(@"--(%@)--", param);
        return param;
    };
    
    [testBlock testBlock:testBlock didClickBlock4:^NSString* (NSString *param) {
        NSLog(@"--(%@)--", param);
        return param;
    }];

    [testBlock didClick];
}

@end
