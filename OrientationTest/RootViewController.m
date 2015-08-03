//
//  RootViewController.m
//  OrientationTest
//
//  Created by Vladimir Shishov on 30/07/15.
//  Copyright (c) 2015 com.dragvs. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController {
    UIViewController *_currentChildController;
    NSInteger _activeTransition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    if (_currentChildController) {
        return [_currentChildController supportedInterfaceOrientations];
    }
    
    return [super supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate
{
    if (_currentChildController) {
        return [_currentChildController shouldAutorotate];
    }
    
    return [super shouldAutorotate];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    return [super shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
//}

- (BOOL)shouldAutomaticallyForwardRotationMethods
{
    return NO;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    if (_currentChildController) {
        return [_currentChildController viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    }
    
    return [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (_currentChildController) {
        return [_currentChildController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
    
    return [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (_currentChildController) {
        return [_currentChildController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
    
    return [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (_currentChildController) {
        return [_currentChildController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    }
    
    return [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)displayViewController:(UIViewController *)toViewController
                   completion:(void (^)(void))completion
{
    UIViewController *fromViewController = _currentChildController;

    _currentChildController = toViewController;

    [self adjustDeviceOrientationWithViewController:toViewController];
    
    if (fromViewController) {
        [fromViewController willMoveToParentViewController:nil];
        [self addChildViewController:toViewController];
        
        UIView *fromView = fromViewController.view;
        
        UIView *toView = toViewController.view;
        toView.alpha = 0.0f;
        toView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:toView];
        [self addFillParentConstraintsToView:toView];
        [toView layoutIfNeeded];
        
//        _currentChildController = toViewController;
        ++_activeTransition;
        NSLog(@"[RootViewController displayViewController] Starting transition with id: %ld", (long)_activeTransition);

//        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
//        [UIViewController attemptRotationToDeviceOrientation];
        
        [self transitionFromViewController:fromViewController
                          toViewController:toViewController
                                  duration:0.25 options:0
                                animations:^{
                                    fromView.alpha = 0.0f;
                                    toView.alpha = 1.0f;
                                }
                                completion:^(BOOL finished) {
                                    if (finished) {
                                        [fromViewController removeFromParentViewController];
                                        [toViewController didMoveToParentViewController:self];
                                    }
                                    NSLog(@"[RootViewController displayViewController] Ending transition with id: %ld", (long)_activeTransition);
                                    --_activeTransition;
                                    
//                                    [UIViewController attemptRotationToDeviceOrientation];
                                    
                                    if (completion)
                                        completion();
                                }];
    } else {
        UIView *toView = toViewController.view;
        toView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addChildViewController:toViewController];
        [self.view addSubview:toView];
        [self addFillParentConstraintsToView:toView];
        [toViewController didMoveToParentViewController:self];
        
//        _currentChildController = toViewController;
        
        if (completion)
            completion();
    }
}

- (void)adjustDeviceOrientationWithViewController:(UIViewController *)viewController
{
    NSUInteger supportedOrientations = viewController.supportedInterfaceOrientations;
    UIDeviceOrientation newDeviceOrientation = UIDeviceOrientationUnknown;
    UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (UIInterfaceOrientationIsPortrait(statusBarOrientation) &&
        !(supportedOrientations & (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown)))
    {
        if (supportedOrientations & UIInterfaceOrientationMaskLandscapeLeft) {
            newDeviceOrientation = UIDeviceOrientationLandscapeLeft;
        }
        else if (supportedOrientations & UIInterfaceOrientationMaskLandscapeRight) {
            newDeviceOrientation = UIDeviceOrientationLandscapeRight;
        }
    }
    else if (UIInterfaceOrientationIsLandscape(statusBarOrientation) &&
             !(supportedOrientations & UIInterfaceOrientationMaskLandscape))
    {
        if (supportedOrientations & UIInterfaceOrientationMaskPortrait) {
            newDeviceOrientation = UIDeviceOrientationPortrait;
        }
        else if (supportedOrientations & UIInterfaceOrientationMaskPortraitUpsideDown) {
            newDeviceOrientation = UIDeviceOrientationPortraitUpsideDown;
        }
    }
    
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
//    [UIViewController attemptRotationToDeviceOrientation];
    
    if (newDeviceOrientation == UIDeviceOrientationUnknown) {
        UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
        
        if (UIDeviceOrientationIsValidInterfaceOrientation(deviceOrientation)) {
            if (statusBarOrientation != UIInterfaceOrientationUnknown && (UIDeviceOrientation)statusBarOrientation != deviceOrientation) {
                newDeviceOrientation = deviceOrientation;
            }
        }
    }
    
    if (newDeviceOrientation != UIDeviceOrientationUnknown) {
        [[UIDevice currentDevice] setValue:@(newDeviceOrientation) forKey:@"orientation"];
    }
}

- (void)addFillParentConstraintsToView:(UIView *)view
{
    NSMutableArray *constraints = [NSMutableArray new];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    
    if ([NSLayoutConstraint respondsToSelector:@selector(activateConstraints:)]) {
        [NSLayoutConstraint activateConstraints:constraints];
    } else {
        [view.superview addConstraints:constraints];
    }
}

@end
