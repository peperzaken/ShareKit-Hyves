//
//  HyvesTestAppDelegate.m
//  HyvesTest
//
//  Created by Martijn de Haan on 5/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HyvesTestAppDelegate.h"

#import "SHK.h"
#import "SHKHyves.h"

@implementation HyvesTestAppDelegate

- (void) shareHyves {
	SHKItem* item = [SHKItem text:@"Hyves service example test in ShareKit by Peperzaken. http://peperzaken.nl/over-peperzaken"];
	[SHKHyves shareItem:item];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// To logout out a user for whatever reason, use the logout class method of the service, for instance, +[SHKHyves logout]
	
	// ShareKit searches for a rootViewController to do their UI magic on, so let's create one
	_viewController = [[UIViewController alloc] init];
		
	CGSize buttonSize = CGSizeMake(200.0f, 44.0f);
	
	UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin];
	[button setTitle:@"Hyves" forState:UIControlStateNormal];
	[button setFrame:CGRectMake(_viewController.view.bounds.size.width / 2 - buttonSize.width / 2, _viewController.view.bounds.size.height / 2 - buttonSize.height / 2, buttonSize.width, buttonSize.height)];
	[button addTarget:self action:@selector(shareHyves) forControlEvents:UIControlEventTouchUpInside];
	[_viewController.view addSubview:button];
	
	[_window addSubview:_viewController.view];
	[_window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
	[_window release];
	[_viewController release];
    [super dealloc];
}

@end
