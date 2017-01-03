//
//  SFDropDownSingleCell.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/27.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFDropDownSingleCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (nonatomic, assign) NSInteger index;

@end
