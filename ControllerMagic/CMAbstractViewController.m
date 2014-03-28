//
//  CMAbstractViewController.m
//  ControllerMagic
//
//  Created by Pepsin on 3/26/14.
//  Copyright (c) 2014 me.pepsin. All rights reserved.
//

#import "CMAbstractViewController.h"

@implementation CMAbstractViewController

@synthesize transitioning;
@synthesize customScreenEdgeRightPanGestureRecognizer;
@synthesize customScreenEdgeLeftPanGestureRecognizer;


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    transitioning = [[CMTransitioning alloc] init];
    transitioning.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    transitioning.isGestureTriggered = NO;
    self.transitioningDelegate = transitioning;
    self.navigationController.delegate = transitioning;
    customScreenEdgeLeftPanGestureRecognizer.enabled = YES;
    customScreenEdgeRightPanGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    customScreenEdgeLeftPanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(_gestureAction:)];
    customScreenEdgeLeftPanGestureRecognizer.edges = UIRectEdgeLeft;
    customScreenEdgeLeftPanGestureRecognizer.delaysTouchesBegan = NO;
    [self.view addGestureRecognizer:customScreenEdgeLeftPanGestureRecognizer];
    
    customScreenEdgeRightPanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(_gestureAction:)];
    customScreenEdgeRightPanGestureRecognizer.edges = UIRectEdgeRight;
    customScreenEdgeRightPanGestureRecognizer.delaysTouchesBegan = NO;
    [self.view addGestureRecognizer:customScreenEdgeRightPanGestureRecognizer];
}

- (void)_gestureAction: (UIScreenEdgePanGestureRecognizer *)recognizer
{
    transitioning.isGestureTriggered = YES;
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    if (recognizer == customScreenEdgeLeftPanGestureRecognizer) {
        progress = MIN(1.0, MAX(0.0, progress));
    } else if (recognizer == customScreenEdgeRightPanGestureRecognizer) {
        progress = MIN(1.0, MAX(0.0, - progress));
    }
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Create a interactive transition and pop the view controller
        if (recognizer == customScreenEdgeLeftPanGestureRecognizer) {
            [self leftGestureAction];
        } else if (recognizer == customScreenEdgeRightPanGestureRecognizer) {
            [self rightGestureAction];
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Update the interactive transition's progress
        [transitioning.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // Finish or cancel the interactive transition
        if (progress > 0.5) {
            [transitioning.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [transitioning.interactivePopTransition cancelInteractiveTransition];
        }
    }
}

- (void)leftGestureAction {}
- (void)rightGestureAction {}

@end