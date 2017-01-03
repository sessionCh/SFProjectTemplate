
//
//  SFTabBarButton.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFTabBarButton.h"

@implementation SFTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:SFKColorGolden forState:UIControlStateSelected];
    }
    return self;

}

+ (SFTabBarButton *)initWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    SFTabBarButton *tabBarBtn = [[SFTabBarButton alloc] init];
    [tabBarBtn setTitle:title forState:UIControlStateNormal];
    [tabBarBtn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    
    return tabBarBtn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, self.titleLabel.bounds.size.height, -self.titleLabel.bounds.size.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(self.imageView.bounds.size.height, -self.imageView.bounds.size.width, 0, 0);
}

@end
