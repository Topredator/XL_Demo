//
//  AppDelegate.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/6/20.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "AppDelegate.h"

#import "RootViewController.h"
#import "XL_BaseNaviViewController.h"
#import "XL_BaseViewController.h"

#import "XL_BaseTabbarViewController.h"

#import "HomeViewController.h"

static NSString *const kJSPatchPublicKey = @"-----BEGIN PUBLIC KEY-----\n \
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDKO/7h4WgQxahHfNqF8ofBdQgZ\n \
1YvZ3uuQ6A624mlFlPgwOn0YNeCjRDYLTBz0fse4a1yc1S4yQyBHBHxP+8sDEGCQ\n \
twc5/KoFJ14EmteIUcGWflsWe1Gd656T17Fg0YU7EoDAIGLblYpBzaDQ25U2sbif\n \
d7iExW3UZeCZodqLJQIDAQAB\n \
-----END PUBLIC KEY-----";

@interface AppDelegate ()

@end

@implementation AppDelegate

void UncaughtExceptionHandler(NSException *exception)
{
    NSArray *array = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *exceptionStr = [NSString stringWithFormat:@"iOS Exception --Version：%@\nName：%@\nReasion：%@\nCallStack：%@",
                                                                                [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"], name, reason, [array componentsJoinedByString:@"\n"]];
    NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++ERROR:\n%@", exceptionStr);
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //  JSPatch
    //  --------------------------------- JSPatch test 的分割线 ----------------------------------- //
//        [JSPatch testScriptInBundle];
    //  ----------------------------------- 分割线结束 ------------------------------------- //
    
    //  --------------------------------- JSPatch 线上 的分割线 ----------------------------------- //
    //    [JSPatch startWithAppKey:@"4570557055ed8add"];
    //    [JSPatch setupRSAPublicKey:kJSPatchPublicKey];
    //#ifdef DEBUG
    //    [JSPatch setupDevelopment];
    //#endif
    //    [JSPatch sync];
    //    [JSPatch setupLogger:^(NSString *msg) {
    //        NSLog(@"%@", msg);
    //    }];
    //  ----------------------------------- 分割线结束 ------------------------------------- //
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    NSArray *classNames = @[@"RootViewController", @"HomeViewController"];
    NSArray *titles = @[@"Root", @"Home"];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:classNames.count];
    
    for (int i = 0; i < classNames.count; i++) {
        XL_BaseViewController *baseVC = [[NSClassFromString(classNames[i]) alloc] init];
        XL_BaseNaviViewController *navi = [[XL_BaseNaviViewController alloc] initWithRootViewController:baseVC];
        [baseVC setTitle:titles[i]];
        [viewControllers addObject:navi];
    }
    
    XL_BaseTabbarViewController *tabbarVC = [[XL_BaseTabbarViewController alloc] init];
    [tabbarVC setViewControllers:viewControllers];
    
    self.window.rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];
    //  异常捕捉
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
