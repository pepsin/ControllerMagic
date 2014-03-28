//
//  CMTransitioning.h
//  ControllerMagic
//
//  Created by Pepsin on 3/20/14.
//  Copyright (c) 2014 me.pepsin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    AnimationTypePresent,
    AnimationTypeDismiss
} AnimationType;

@interface CMTransitioning : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) AnimationType type;
@property (nonatomic, assign, getter = isInteractive) BOOL interactive;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property BOOL isGestureTriggered;

@end
