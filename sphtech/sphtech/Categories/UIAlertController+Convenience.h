//
//  UIAlertController+Convenience.h
//  BOW
//
//  Created by A101 on 7/21/16.
//  Copyright © 2016 A101. All rights reserved.
//

#import "UIAlertController+Blocks.h"

@interface UIAlertController (Convenience)

/**
 *  Shows the alert in the view controller. The default cancel button is 'OK'
 *
 *  @param viewController The viewcontroller where the alert will be shown.
 *  @param title          The title of the alert.
 *  @param message        The message of the alert.
 *
 *  @return The instance of alert controller.
 */
+ (nonnull instancetype)showAlertInViewController:(nonnull UIViewController *)viewController
										withTitle:(nullable NSString *)title
										  message:(nullable NSString *)message;

/**
 *  Shows the alert in the view controller.
 *
 *  @param viewController    The viewcontroller where the alert will be shown.
 *  @param title             The title of the alert.
 *  @param message           The message of the alert.
 *  @param cancelButtonTitle The title of the cancel button.
 *  @param otherButtonTitles The titles of other buttons in array.
 *
 *  @return The instance of alert controller.
 */
+ (nonnull instancetype)showAlertInViewController:(nonnull UIViewController *)viewController
										withTitle:(nullable NSString *)title
										  message:(nullable NSString *)message
								cancelButtonTitle:(nullable NSString *)cancelButtonTitle
								otherButtonTitles:(nullable NSArray *)otherButtonTitles;

/**
 *  Shows the alert in the view controller.
 *
 *  @param viewController    The viewcontroller where the alert will be shown.
 *  @param title             The title of the alert.
 *  @param message           The message of the alert.
 *  @param cancelButtonTitle The title of the cancel button.
 *  @param otherButtonTitles The titles of other buttons in array.
 *  @param tapBlock          The block that will be called when any of the buttons is tapped.
 *
 *  @return The instance of alert controller.
 */
+ (nonnull instancetype)showAlertInViewController:(nonnull UIViewController *)viewController
										withTitle:(nullable NSString *)title
										  message:(nullable NSString *)message
								cancelButtonTitle:(nullable NSString *)cancelButtonTitle
								otherButtonTitles:(nullable NSArray *)otherButtonTitles
										 tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

/**
 *  Shows the actionsheet in the view controller.
 *
 *  @param viewController         The viewcontroller where the action sheet will be shown.
 *  @param title                  The title of the action sheet.
 *  @param message                The message of the action sheet.
 *  @param cancelButtonTitle      The title of the cancel button.
 *  @param destructiveButtonTitle The title of the red destructive button.
 *  @param otherButtonTitles      The other buttons title in array.
 *  @param tapBlock               The block that will be called when any of the buttons is tapped.
 *
 *  @return The instance of alert controller.
 */
+ (nonnull instancetype)showActionSheetInViewController:(nonnull UIViewController *)viewController
											  withTitle:(nullable NSString *)title
												message:(nullable NSString *)message
									  cancelButtonTitle:(nullable NSString *)cancelButtonTitle
								 destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
									  otherButtonTitles:(nullable NSArray *)otherButtonTitles
											   tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

@end
