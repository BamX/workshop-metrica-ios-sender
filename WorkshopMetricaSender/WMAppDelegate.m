//
//  Copyright (c) 2015 Yandex. All rights reserved.
//

#import "WMAppDelegate.h"
#import "WMViewController.h"

#import <YandexMobileMetrica/YandexMobileMetrica.h>

static NSString *const kWMAPIKey = @"37970";

@implementation WMAppDelegate

+ (void)initialize
{
    [YMMYandexMetrica startWithAPIKey:kWMAPIKey];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    WMViewController *viewController = [[WMViewController alloc] init];
    UINavigationController *navigationController =
        [[UINavigationController alloc] initWithRootViewController:viewController];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
