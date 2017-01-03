//
//  SFPopContentView.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/8.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFPopContentView.h"

@interface SFPopContentView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *center_margin_top_cons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *center_margin_bottom_cons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_center_width_cons;

@end

@implementation SFPopContentView

+ (SFPopContentView *)popContentView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SFPopContentView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.center_margin_top_cons.constant = 0.5f;
    self.center_margin_bottom_cons.constant = 0.5f;
    self.bottom_center_width_cons.constant = 0.5f;
}

@end
