//
//  ShelfViewController.m
//  OrientationTest
//
//  Created by Vladimir Shishov on 30/07/15.
//  Copyright (c) 2015 com.dragvs. All rights reserved.
//

#import "ShelfViewController.h"
#import "ShelfCollectionViewCell.h"
#import "MagazineModel.h"


@interface ShelfViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation ShelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerNib:[UINib nibWithNibName:@"ShelfCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellId"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShelfCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    NSString *labelText;
    
    switch (indexPath.row) {
        case MagazineModelOrientationPortrait:
            labelText = @"Portrait";
            break;
        case MagazineModelOrientationLanscape:
            labelText = @"Landscape";
            break;
        case MagazineModelOrientationBoth:
            labelText = @"Both";
            break;
        default:
            labelText = @"Unknown";
            break;
    }
    
    cell.label.text = labelText;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected item idx: %ld", (long)indexPath.row);
    
    if ([self.delegate respondsToSelector:@selector(shelfView:didSelectMagazineModel:)]) {
        MagazineModel *magazineModel = [MagazineModel modelWithOrientation:indexPath.row];
        
        [self.delegate shelfView:self didSelectMagazineModel:magazineModel];
    }
}

@end
