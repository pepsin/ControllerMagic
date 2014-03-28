//
//  CMLeftViewController.m
//  ControllerMagic
//
//  Created by Pepsin on 3/17/14.
//  Copyright (c) 2014 me.pepsin. All rights reserved.
//

#import "CMLeftViewController.h"

@implementation CMLeftViewController

- (IBAction)dismissCurrentViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightGestureAction
{
    [super rightGestureAction];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
