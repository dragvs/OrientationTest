//
//  MagazineViewController.h
//  OrientationTest
//
//  Created by Vladimir Shishov on 30/07/15.
//  Copyright (c) 2015 com.dragvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MagazineModel;
@protocol MagazineViewControllerDelegate;


@interface MagazineViewController : UIViewController

@property (nonatomic) MagazineModel *magazineModel;

@property (nonatomic, weak) id<MagazineViewControllerDelegate> delegate;

@end


@protocol MagazineViewControllerDelegate <NSObject>

- (void)magazineViewWasClosed:(MagazineViewController *)controller;

@end