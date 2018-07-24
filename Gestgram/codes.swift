//
//  codes.swift
//  Gestgram
//
//  Created by Ada 2018 on 7/24/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

//import Foundation
//
//
//- (void)viewDidLoad
//    {
//        [super viewDidLoad];
//
//        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
//        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//        [self.view addGestureRecognizer:swipeLeft];
//
//        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
//        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//        [self.view addGestureRecognizer:swipeRight];
//    }
//
//    - (IBAction)tappedRightButton:(id)sender
//{
//    NSUInteger selectedIndex = [rootVC.tabBarController selectedIndex];
//
//    [self.tabBarController setSelectedIndex:selectedIndex + 1];
//
//    //To animate use this code
//    CATransition *anim= [CATransition animation];
//    [anim setType:kCATransitionPush];
//    [anim setSubtype:kCATransitionFromRight];
//    [anim setDuration:1];
//    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:
//        kCAMediaTimingFunctionEaseIn]];
//    [self.tabBarController.view.layer addAnimation:anim forKey:@"fadeTransition"];
//    }
//
//    - (IBAction)tappedLeftButton:(id)sender
//{
//    NSUInteger selectedIndex = [rootVC.tabBarController selectedIndex];
//
//    [self.tabBarController setSelectedIndex:selectedIndex - 1];
//
//    CATransition *anim= [CATransition animation];
//    [anim setType:kCATransitionPush];
//    [anim setSubtype:kCATransitionFromRight];
//
//    [anim setDuration:1];
//    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:
//        kCAMediaTimingFunctionEaseIn]];
//    [self.tabBarController.view.layer addAnimation:anim forKey:@"fadeTransition"];
//}
