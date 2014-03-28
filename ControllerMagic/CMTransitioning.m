//
//  CMTransitioning.m
//  ControllerMagic
//
//  Created by Pepsin on 3/20/14.
//  Copyright (c) 2014 me.pepsin. All rights reserved.
//

#import "CMTransitioning.h"

@interface CMTransitioning()
{
    id<UIViewControllerContextTransitioning> _context;
    UIView *_transitioningView;
}
@end

@implementation CMTransitioning

#pragma mark Implement UIViewControllerAnimatedTransitioning protocol

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"Called");
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (self.type == AnimationTypePresent) {
        NSLog(@"Presenting");
        toViewController.view.transform = CGAffineTransformMakeTranslation(-320, 0);
        toViewController.view.backgroundColor = [UIColor whiteColor];
        fromViewController.view.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        
        [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            NSLog(@"Animating");
            toViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
            toViewController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
            toViewController.view.layer.shadowOpacity = 0.1;
            toViewController.view.layer.shadowOffset = CGSizeMake(3, 0);
            toViewController.view.layer.shadowRadius = 5;
            fromViewController.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            
        } completion:^(BOOL finished) {
            NSLog(@"Finished");
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    } else if (self.type == AnimationTypeDismiss) {
        
        fromViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        fromViewController.view.backgroundColor = [UIColor whiteColor];
        toViewController.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];

        [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];

        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformMakeTranslation(-320, 0);
            fromViewController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
            fromViewController.view.layer.shadowOpacity = 0.1;
            fromViewController.view.layer.shadowOffset = CGSizeMake(3, 0);
            fromViewController.view.layer.shadowRadius = 5;
            toViewController.view.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

#pragma mark Implement UIViewControllerInteractiveTransitioning protocol

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    _context = transitionContext;
    
    //Get references to view hierarchy
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //Insert 'to' view into hierarchy
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    //Save reference for view to be scaled
    _transitioningView = fromViewController.view;
}

#pragma mark UINavigationController Delegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    switch (operation) {
        case UINavigationControllerOperationPush:
            self.type = AnimationTypePresent;
            return  self;
        case UINavigationControllerOperationPop:
            self.type = AnimationTypeDismiss;
            return self;
        default: return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    // Check if this is for our custom transition
    self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    if ([animationController isKindOfClass:[CMTransitioning class]] && self.isGestureTriggered) {
        return self.interactivePopTransition;
    }
    else {
        return nil;
    }
}

@end
