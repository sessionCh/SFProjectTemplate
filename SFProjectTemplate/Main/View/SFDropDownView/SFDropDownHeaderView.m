//
//  SFDropDownHeaderView.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/26.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFDropDownHeaderView.h"
#import "DropDownMacros.h"
#import "SFDropDownHeaderCell.h"

@interface SFDropDownHeaderView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) SFDidSelectItemBlock block;

@property (nonatomic, strong) NSMutableArray *rowIndexes;// 保存弹出菜单当前选中的索引

@property (nonatomic, strong) SFDropDownHeaderCell *selectedCell;

@end

@implementation SFDropDownHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        _selectIndex = -1;
        
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"SFDropDownHeaderCell" bundle:nil] forCellWithReuseIdentifier:@"SFDropDownHeaderCell"];
        [self addSubview:_collectionView];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _collectionView.frame = CGRectMake(0, 0, self.width, self.height);
}

#pragma mark - setter/getter

- (void)setSelectIndex:(NSInteger)selectIndex
{
    if (selectIndex >= self.dataArray.count) return ;
    
    _selectIndex = selectIndex;
    
    [self.collectionView reloadData];
}


#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SFDropDownHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SFDropDownHeaderCell" forIndexPath:indexPath];
    cell.lab.text = self.dataArray[indexPath.row];
    cell.index = indexPath.row;
    if (cell.index == self.selectIndex) {
        cell.lab.textColor = KSelectedColor;
        cell.img.image = [UIImage imageNamed:@"分类-角标-触发"];
        self.selectedCell = cell;
    } else {
        cell.lab.textColor = KDefaultColor;
        cell.img.image = [UIImage imageNamed:@"分类-角标-默认"];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    if (self.block) {
        
        // tempIndexPath.row 表示菜单索引 tempIndexPath.section 表示所在弹出菜单索引
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:[self.rowIndexes[indexPath.row] integerValue]];
        
        self.block(tempIndexPath, weakSelf_SC.dataArray[indexPath.row]);
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
    CGFloat space = KSpace * (self.dataArray.count - 1);
    
    return CGSizeMake((self.width - space) / self.dataArray.count, self.height - KSpace);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, KSpace, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return KSpace;
}

- (void)didSelectItemBlock:(SFDidSelectItemBlock)block
{
    self.block = block;
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    _rowIndexes = [NSMutableArray arrayWithCapacity:dataArray.count];
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.rowIndexes addObject:@(0)]; // 初始化
    }];
}

- (void)updateUI:(NSIndexPath *)indexPath title:(NSString *)title
{
    // indexPath.row 表示菜单索引 indexPath.section 表示所在弹出菜单索引
    if (indexPath.row >= self.dataArray.count) return;
    
    [self.dataArray replaceObjectAtIndex:indexPath.row withObject:title];
    [self.rowIndexes replaceObjectAtIndex:indexPath.row withObject:@(indexPath.section)];
    
    [self.collectionView reloadItemsAtIndexPaths:@[
                                                   [NSIndexPath indexPathForRow:indexPath.row inSection:0]]];
}

- (void)changeSelectedColor:(UIColor *)color
{
    if (self.selectedCell) {
        self.selectedCell.lab.textColor = color;
        self.selectedCell.img.image = [UIImage imageNamed:@"分类-角标-默认"];
    }
}

@end
