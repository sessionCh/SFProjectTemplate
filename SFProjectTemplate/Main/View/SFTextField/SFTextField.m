//
//  SFTextField.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/27.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFTextField.h"

@interface SFTextField ()

@end

@implementation SFTextField

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    UIView *leftView       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, self.frame.size.height)];
    self.leftView          = leftView;
    self.leftViewMode      = UITextFieldViewModeAlways;
    
    self.font = [UIFont fontWithName:@"Avenir-Book" size:12.f];
    
    self.layer.borderWidth = 0.5f;
}

- (BOOL)validate {
    
    return [self.validator validateInput:self];
}

- (BOOL)validateCharacter:(NSString *)string range:(NSRange)range {
    
    return [self.validator validateCharacter:string textField:self range:range];
}

@end
