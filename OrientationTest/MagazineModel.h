//
//  MagazineModel.h
//  OrientationTest
//
//  Created by Vladimir Shishov on 30/07/15.
//  Copyright (c) 2015 com.dragvs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MagazineModelOrientation) {
    MagazineModelOrientationPortrait,
    MagazineModelOrientationLanscape,
    MagazineModelOrientationBoth
};


@interface MagazineModel : NSObject

@property (nonatomic) MagazineModelOrientation orientation;

+ (instancetype)modelWithOrientation:(MagazineModelOrientation)orientation;

- (instancetype)initWithOrientation:(MagazineModelOrientation)orientation;

@end
