
//
//  SFMarkProductCell.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/28.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFMarkProductCell.h"


@interface SFMarkProductCell ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *markLab;
@property (weak, nonatomic) IBOutlet UIView *markV;
@property (weak, nonatomic) IBOutlet UIImageView *markImg;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;

@property (weak, nonatomic) IBOutlet UILabel *rateLab;
@property (weak, nonatomic) IBOutlet UILabel *rateTitle;
@property (weak, nonatomic) IBOutlet UILabel *borrowTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *borrowTimeTitle;
@property (weak, nonatomic) IBOutlet UIButton *investBtn;

- (IBAction)investClick:(UIButton *)sender;

@end

@implementation SFMarkProductCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addSubview:self.contentView];
    self.backgroundColor = HEXCOLOR(0XE8E8F1);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)loadData:(id<SFMarkProductCellProtocol>)data
{
    // 头部分
    if (data.closed) {
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:SFKImageUrl(data.iconName)] placeholderImage:[UIImage imageNamed:@"credit_turn_close"]];
    } else {
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:data.iconName] placeholderImage:[UIImage imageNamed:@"credit_turn_open"]];
    }
    self.titleLab.text = data.title;
    
    if (data.markTitle) {
        self.markLab.text = data.markTitle;
    } else {
        self.markV.hidden = YES;
        self.markLab.hidden = YES;
    }
    
    // 中间部分
    self.rateLab.attributedText = data.rate;
    self.rateTitle.text = data.rateTitle;
    self.borrowTimeLab.attributedText = data.borrowTime;
    self.borrowTimeTitle.text = data.borrowTimeTitle;
}

- (IBAction)investClick:(UIButton *)sender {
    
    SFFinanceDetailViewController *vc = [[SFFinanceDetailViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

@end
