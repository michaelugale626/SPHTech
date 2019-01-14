//
//  UIViewController+Additions.m
//  BOW
//
//  Created by A101 on 7/21/16.
//  Copyright © 2016 A101. All rights reserved.
//

#import "UIViewController+Additions.h"

@implementation UIViewController (Additions)

+ (UIViewController*)topViewController {
	return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
	if ([rootViewController isKindOfClass:[UITabBarController class]]) {
		UITabBarController *tabBarController = (UITabBarController*)rootViewController;
		return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
	} else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
		UINavigationController *navigationController = (UINavigationController*)rootViewController;
		return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
	} else if (rootViewController.presentedViewController) {
		UIViewController *presentedViewController = rootViewController.presentedViewController;
		return [self topViewControllerWithRootViewController:presentedViewController];
	} else {
		return rootViewController;
	}
}

- (BOOL)isRootViewController {
	return [[self.navigationController.viewControllers firstObject] isKindOfClass:[self class]];
}

- (BOOL)isPresentedAsModal {
	if(self.presentingViewController) {
		return YES;
	}
	if(self.presentingViewController.presentedViewController == self) {
		return YES;
	}
	if(self.navigationController.presentingViewController.presentedViewController == self.navigationController) {
		return YES;
	}
	if([self.tabBarController.presentingViewController isKindOfClass:[UITabBarController class]]) {
		return YES;
	}
	return NO;
}

- (BOOL)isVisible {
	return self.isViewLoaded && self.view.window;
}

@end
