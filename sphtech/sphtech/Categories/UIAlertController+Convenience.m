//
//  UIAlertController+Convenience.m
//  BOW
//
//  Created by A101 on 7/21/16.
//  Copyright © 2016 A101. All rights reserved.
//

#import "UIAlertController+Convenience.h"

@implementation UIAlertController (Convenience)

+ (nonnull instancetype)showAlertInViewController:(nonnull UIViewController *)viewController
										withTitle:(nullable NSString *)title
										  message:(nullable NSString *)message {
	return [self showAlertInViewController:viewController
								 withTitle:title
								   message:message
						 cancelButtonTitle:@"OK"
						 otherButtonTitles:nil];
}

+ (nonnull instancetype)showAlertInViewController:(nonnull UIViewController *)viewController
										withTitle:(nullable NSString *)title
										  message:(nullable NSString *)message
								cancelButtonTitle:(nullable NSString *)cancelButtonTitle
								otherButtonTitles:(nullable NSArray *)otherButtonTitles {
	return [self showAlertInViewController:viewController
								 withTitle:title
								   message:message
						 cancelButtonTitle:cancelButtonTitle
						 otherButtonTitles:otherButtonTitles
								  tapBlock:nil];
}

+ (nonnull instancetype)showAlertInViewController:(nonnull UIViewController *)viewController
										withTitle:(nullable NSString *)title
										  message:(nullable NSString *)message
								cancelButtonTitle:(nullable NSString *)cancelButtonTitle
								otherButtonTitles:(nullable NSArray *)otherButtonTitles
										 tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock {
	return [self showAlertInViewController:viewController
								 withTitle:title
								   message:message
						 cancelButtonTitle:cancelButtonTitle
					destructiveButtonTitle:nil
						 otherButtonTitles:otherButtonTitles
								  tapBlock:tapBlock];
}

+ (nonnull instancetype)showActionSheetInViewController:(nonnull UIViewController *)viewController
											  withTitle:(nullable NSString *)title
												message:(nullable NSString *)message
									  cancelButtonTitle:(nullable NSString *)cancelButtonTitle
								 destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
									  otherButtonTitles:(nullable NSArray *)otherButtonTitles
											   tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock {
	return [self showActionSheetInViewController:viewController
									   withTitle:title
										 message:message
							   cancelButtonTitle:cancelButtonTitle
						  destructiveButtonTitle:destructiveButtonTitle
							   otherButtonTitles:otherButtonTitles
			  popoverPresentationControllerBlock:nil
										tapBlock:tapBlock];
}

@end
