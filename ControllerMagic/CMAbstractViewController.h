//
//  CMAbstractViewController.h
//  ControllerMagic
//
//  Created by Pepsin on 3/26/14.
//  Copyright (c) 2014 me.pepsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMTransitioning.h"

@interface CMAbstractViewController : UIViewController

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *customScreenEdgeLeftPanGestureRecognizer;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *customScreenEdgeRightPanGestureRecognizer;
@property (nonatomic, strong) CMTransitioning *transitioning;

- (void)leftGestureAction;
- (void)rightGestureAction;

@end
