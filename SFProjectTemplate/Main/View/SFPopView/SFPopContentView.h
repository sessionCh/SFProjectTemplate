//
//  SFPopContentView.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/8.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFTextField.h"

@interface SFPopContentView : UIView

@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet SFTextField *input_field;
@property (weak, nonatomic) IBOutlet UIButton *cancel_btn;
@property (weak, nonatomic) IBOutlet UIButton *sure_btn;

+ (SFPopContentView *)popContentView;

@end
