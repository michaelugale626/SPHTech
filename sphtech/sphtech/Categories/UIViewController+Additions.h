//
//  UIViewController+Additions.h
//  BOW
//
//  Created by A101 on 7/21/16.
//  Copyright © 2016 A101. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Additions)

/**
 *  Returns the top ViewController.
 */
+ (UIViewController*)topViewController;

/**
 *  Returns YES if the view controller is the root view controller of its navigation controller.
 */
@property (readonly, assign, nonatomic) BOOL isRootViewController;

/**
 *  Returns YES if the view controller is presented as modal.
 */
@property (readonly, assign, nonatomic) BOOL isPresentedAsModal;

/**
 *  Returns YES if the view controller's view is currently visible.
 */
- (BOOL)isVisible;

@end
