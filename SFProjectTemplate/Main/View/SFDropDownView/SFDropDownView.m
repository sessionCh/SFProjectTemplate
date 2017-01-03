
//
//  SFDropDownView.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/26.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFDropDownView.h"
#import "DropDownMacros.h"
#import "SFDropDownCell.h"
#import "SFDropDownSingleCell.h"


@interface SFDropDownView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *darkView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) SFDidSelectItemBlock block;
@property (nonatomic, copy) SFDismissCompletionBlock dismissBlock;
@property (nonatomic, assign) CGFloat dropDownHeight; // 下拉视图高度

@property (nonatomic, assign) BOOL isShow; // 下拉视图高度

@end

@implementation SFDropDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
        _row = KRow;
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        self.userInteractionEnabled = NO;

        // 背景部分
        _darkView = [[UIView alloc] initWithFrame:self.bounds];
        _darkView.hidden = YES;
        _darkView.backgroundColor = [UIColor blackColor];
        _darkView.alpha = 0.5f;
        [_darkView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        [self addSubview:_darkView];
        
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"SFDropDownCell" bundle:nil] forCellWithReuseIdentifier:@"SFDropDownCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"SFDropDownSingleCell" bundle:nil] forCellWithReuseIdentifier:@"SFDropDownSingleCell"];

        [self addSubview:_collectionView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 44.0f, self.width, self.dropDownHeight);
}

#pragma mark - setter/getter

-(void)setCollectionFrame:(CGRect)frame
{
    self.collectionView.frame = frame;
}

- (CGFloat)dropDownHeight
{
    _dropDownHeight = (self.dataArray.count + self.row - 1) / self.row * (KItemHeight + KSpace);
    if (_dropDownHeight > KMaxHeight) {
        _dropDownHeight = KMaxHeight;
    }
    return _dropDownHeight;
}

- (void)setRow:(NSInteger)row
{
    if (row > 0) {
        _row = row;
        [self setNeedsLayout];
        [self.collectionView reloadData];
    }
}

- (void)setStyle:(SFDropDownCellStyle)style
{
    _style = style;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.style) {
        case SFDropDownCellStyleDefault:
        {
            SFDropDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SFDropDownCell" forIndexPath:indexPath];
            
            cell.lab.text = self.dataArray[indexPath.row];
            cell.index = indexPath.row;
            if (cell.index == self.selectIndex) {
                cell.lab.textColor = KSelectedColor;
            } else {
                cell.lab.textColor = KDefaultColor;
            }
            return cell;

            break;
        }
        case SFDropDownCellStyleSingle:
        {
            SFDropDownSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SFDropDownSingleCell" forIndexPath:indexPath];
            
            cell.lab.text = self.dataArray[indexPath.row];
            cell.index = indexPath.row;
            if (cell.index == self.selectIndex) {
                cell.lab.textColor = KSelectedColor;
                cell.img.hidden = NO;
                
            } else {
                cell.lab.textColor = KDefaultColor;
                cell.img.hidden = YES;
            }
            return cell;
            
            break;
        }
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    if (self.block) {
        self.block(indexPath, weakSelf_SC.dataArray[indexPath.row]);
    }
    
    if (self.selectIndex == indexPath.row) {
        return ;
    }
    
    NSInteger tempIndex = self.selectIndex;
    self.selectIndex = indexPath.row;
    [self.collectionView reloadItemsAtIndexPaths:@[
                                                   [NSIndexPath indexPathForRow:tempIndex inSection:0],
                                                   [NSIndexPath indexPathForRow:indexPath.row inSection:0]]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat space = KSpace * (self.row - 1);
    return CGSizeMake((self.width - space) / self.row, KItemHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, KSpace);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return KSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - callback

- (void)didSelectItemBlock:(SFDidSelectItemBlock)block
{
    self.block = block;
}

- (void)dismissCompletionBlock:(SFDismissCompletionBlock)block
{
    self.dismissBlock = block;
}

#pragma mark - show/hidden

- (void)show
{
    if (self.isShow) return ;
    
    self.darkView.hidden = NO;
    self.userInteractionEnabled = YES;

    self.collectionView.top = 44.0f - self.dropDownHeight;

    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.collectionView.top = 44.0f;
    } completion:^(BOOL finished) {
        self.isShow = YES;
    }];
}

- (void)dismiss
{
    self.darkView.hidden = YES;
    self.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.collectionView.top = 44.0f - self.dropDownHeight;
    } completion:^(BOOL finished) {
        if (self.dismissBlock) {
            self.dismissBlock();
        }
        self.isShow = NO;
    }];
}

- (BOOL)getIsShow
{
    return self.isShow;
}

@end
