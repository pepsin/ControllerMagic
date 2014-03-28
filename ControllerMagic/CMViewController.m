//
//  CMViewController.m
//  ControllerMagic
//
//  Created by Pepsin on 3/17/14.
//  Copyright (c) 2014 me.pepsin. All rights reserved.
//

#import "CMViewController.h"
#import "CMLeftViewController.h"

@implementation CMViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)buttonAction:(id)sender
{
    CMLeftViewController *leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    [self.navigationController pushViewController:leftViewController animated:YES];
}

- (void)leftGestureAction
{
    [super leftGestureAction];
    CMLeftViewController *leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    [self.navigationController pushViewController:leftViewController animated:YES];
}

@end
