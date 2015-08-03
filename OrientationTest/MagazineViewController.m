//
//  MagazineViewController.m
//  OrientationTest
//
//  Created by Vladimir Shishov on 30/07/15.
//  Copyright (c) 2015 com.dragvs. All rights reserved.
//

#import "MagazineViewController.h"
#import "MagazineModel.h"


@interface MagazineViewController ()

@property (nonatomic, weak) IBOutlet UILabel *modelOrientationsLabel;
@property (nonatomic, weak) IBOutlet UILabel *currentOrientationLabel;
@property (nonatomic, weak) IBOutlet UILabel *deviceOrientationLabel;

@end

@implementation MagazineViewController {
    NSUInteger _supportedInterfaceOrientations;
}

- (void)setMagazineModel:(MagazineModel *)magazineModel
{
    _magazineModel = magazineModel;
    
    _supportedInterfaceOrientations = 0;
    
    if (_magazineModel.orientation == MagazineModelOrientationBoth) {
        _supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
    }
    else if (_magazineModel.orientation == MagazineModelOrientationPortrait) {
        _supportedInterfaceOrientations = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
    }
    else if (_magazineModel.orientation == MagazineModelOrientationLanscape) {
        _supportedInterfaceOrientations = UIInterfaceOrientationMaskLandscape;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateLabels];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([self.delegate respondsToSelector:@selector(magazineViewWasClosed:)]) {
        [self.delegate magazineViewWasClosed:self];
    }
}

- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    NSLog(@"[MagazineViewController deviceOrientationDidChange]");
    
    [self updateLabels];
}

- (void)updateLabels
{
    //
    NSString *magazineOrientations = @"Portrait, Lanscape";
    if (self.magazineModel.orientation == MagazineModelOrientationPortrait) {
        magazineOrientations = @"Portrait";
    }
    else if (self.magazineModel.orientation == MagazineModelOrientationLanscape) {
        magazineOrientations = @"Landscape";
    }
    
    self.modelOrientationsLabel.text = [NSString stringWithFormat:@"Magazine orientations: %@", magazineOrientations];
    
    //
    NSString *currentOrientation = @"Unknown";
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        currentOrientation = @"Portrait";
    }
    else if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        currentOrientation = @"Landscape";
    }
    
    self.currentOrientationLabel.text = [NSString stringWithFormat:@"Status bar orientation: %@", currentOrientation];
    
    //
    NSString *deviceOrientation = @"Unknown";
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
        currentOrientation = @"Portrait";
    }
    else if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        currentOrientation = @"Landscape";
    }
    
    self.deviceOrientationLabel.text = [NSString stringWithFormat:@"Device orientation: %@", deviceOrientation];
}

- (NSUInteger)supportedInterfaceOrientations
{
//    return [super supportedInterfaceOrientations];
    return _supportedInterfaceOrientations;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    return [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    return [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    return [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    return [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

@end
