//
//  RootViewController.h
//  OrientationTest
//
//  Created by Vladimir Shishov on 30/07/15.
//  Copyright (c) 2015 com.dragvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

- (void)displayViewController:(UIViewController *)toViewController
                   completion:(void (^)(void))completion;

@end
