//
//  AppDelegate.h
//  Task01
//
//  Created by Evgeniy Shuliak on 29.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryTableView.h"

@class ViewController;
@class CategoryTableView;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CategoryTableView *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
