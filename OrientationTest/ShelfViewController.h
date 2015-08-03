//
//  ShelfViewController.h
//  OrientationTest
//
//  Created by Vladimir Shishov on 30/07/15.
//  Copyright (c) 2015 com.dragvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShelfViewControllerDelegate;
@class MagazineModel;


@interface ShelfViewController : UIViewController

@property (nonatomic, weak) id<ShelfViewControllerDelegate> delegate;

@end


@protocol ShelfViewControllerDelegate <NSObject>

- (void)shelfView:(ShelfViewController *)controller didSelectMagazineModel:(MagazineModel *)magazineModel;

@end