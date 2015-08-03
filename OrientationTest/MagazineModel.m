//
//  MagazineModel.m
//  OrientationTest
//
//  Created by Vladimir Shishov on 30/07/15.
//  Copyright (c) 2015 com.dragvs. All rights reserved.
//

#import "MagazineModel.h"

@implementation MagazineModel

+ (instancetype)modelWithOrientation:(MagazineModelOrientation)orientation
{
    return [[MagazineModel alloc] initWithOrientation:orientation];
}

- (instancetype)initWithOrientation:(MagazineModelOrientation)orientation
{
    self = [super init];
    if (self) {
        _orientation = orientation;
    }
    return self;
}

@end
