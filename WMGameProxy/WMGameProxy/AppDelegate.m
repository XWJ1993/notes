//
//  AppDelegate.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/6/10.
//  Copyright © 2019 zali. All rights reserved.
//

#import "AppDelegate.h"
#import "WMComponentController.h"
#import "MainController.h"
#import "WMGameProxy.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/// SceneDelegate
// https://blog.csdn.net/weixin_38735568/article/details/101266408
#pragma mark - App默认代理
// 程序开始启动 0 - 4
// 程序进入后台 1 - 2
// 程序进入前台 3 - 4
// 程序杀死 1 - 2 - 5
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /// 0.需要主动的请求授权才可以发送本地通知
    // 该方法一般放在 AppDelegate.h 中 - 表示程序一启动就主动请求授权
    if (@available(iOS 8.0, *)) {
        UIUserNotificationSettings *set = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:set];
    }
    // 1.说明用户点击了本地通知启动的App
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        // 在这里需要做一些操作
    }
    /// 2.程序启动时首先调用该方法
    // [[UIScreen mainScreen] bounds]只能使用该方法获取设备尺寸
    // 问题 - iOS9.0以后，如果添加多个窗口，控制器会自动把状态栏隐藏
    // 解决办法 - 把状态栏交给应用程序管理
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = UIColor.whiteColor;
    
    // 底层调用 [navigationController pushViewController:[[WMComponentController alloc]init] animated:true];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:[[MainController alloc]init]];
    /// 当前 UIWindow 的根视图控制器 rootViewController
    // self.window.windowLevel
    self.window.rootViewController = navigationController;
    
//    /// 通过UIStoryboard加载程序
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//    // 加载箭头指向的UIStoryboard
//    self.window.rootViewController = [sb instantiateInitialViewController];
//    // 加载指定UIStoryboard
//    self.window.rootViewController = [sb instantiateViewControllerWithIdentifier:@"main"];
//    // ？？？通过Segue实现页面的跳转？？？
    
    /// 显示 UIWindow
    // 1.将当前 self.window 设置成当前App主窗口：这样在别的控制器就可以通过 [UIApplication sharedApplication].keyWindow 取到
    // 2.将 rootViewController 添加到当前App主窗口
    [self.window makeKeyAndVisible];
    
//    // WMGameProxy借用地盘
//    /**
//     [WMGameProxy alloc] - 堆内存开辟存储空间并返回对象地址/类方法
//     [wm init] - 初始化对象属性并返回对象地址/对象方法
//     wm - 指针变量wm接收返回对象地址
//     */
//    /**
//     1.创建对象返回的地址就是类的第零个属性的地址
//     2.类的第零个属性就是isa属性
//     */
//    WMGameProxy *wm = [[WMGameProxy alloc]init];
//    [wm performSelector:@selector(test)]; // oc没有真正的私有（使用该方法可以访问私有方法）
//    /**
//     不推荐使用 new
//     1.为WMGameProxy类创建出来的对象分配存储空间 + alloc()方法/1.开辟存储空间；2.将所有属性设置为0
//     2.初始化WMGameProxy类创建出来的对象的属性 + init()方法/1.初始化成员变量（默认情况下什么都没做）；2.返回初始化后的实例对象地址
//     3.返回WMGameProxy类创建出来的对象对应的地址
//     */
//    WMGameProxy *wm = [WMGameProxy new];
//    wm.sdk = @"sdk"; // 不推荐直接赋值
//    /// "调用方法"在OC中叫做"发送消息"
//    // ？？？OC中调用方法的原理？？？
//    [wm setSdk:@"sdk"];
//    NSString *sdk = wm.sdk; // 点语法就是调用“setter/getter方法”
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /// 1.App将要进入非活动状态
    // 该期间App不接收消息和事件
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /// 2.App进入后台（比如按home键）
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 3.App进入前台
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /// 4.App进入活动状态
    // 能否与用户进行交互
    // 需要在这里清除图标右上角的数字
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /// 5.App将要退出调用
    // 保存数据、清理缓存
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    // 6.App接收到内存警告
    // 清理缓存
    // 内存警告2次你还没有操作会闪退
}


#pragma mark -设置App支持的屏幕方向
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    // 如果这里设置了就以这里为准/如果这里没有设置以info.plist为准
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark -恢复处理程序
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    // 应用程序处理了程序
    return YES;
}


#pragma mark -push
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    /**
     接收到本地通知 - 满足以下条件就会调用
     1>.应用程序在前台
     2>.应用程序从后台进入到前台
     */
    // 完全退出不会点击再进入App不会调用该方法
    NSLog(@"接收到本地通知");
    //
    switch ([UIApplication sharedApplication].applicationState) {
        case UIApplicationStateActive: {
            // 应用程序在前台
        }
            break;
        case UIApplicationStateInactive: {
            // 应用程序从后台进入前台
        }
            break;
        case UIApplicationStateBackground: {
            // 应用程序在后台
        }
            break;
    }
}


#pragma mark - 应用间跳转
/// iOS9.x以上
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    /**
     ？？？怎么把 url 传给别的控制器？？？
     */
    // 当别的App通过URL打开该App的时候调用该方法
    if ([url.host containsString:@"friend"]) {
        NSLog(@"跳转到好友列表页面");
    }
    if ([url.host containsString:@"pengyouquan"]) {
        NSLog(@"跳转到朋友圈页面");
    }
    return YES;
}
/// iOS9.x以下
// 当别的App通过URL打开该App的时候调用该方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url API_DEPRECATED_WITH_REPLACEMENT("application:openURL:options:", ios(2.0, 9.0)) API_UNAVAILABLE(tvos) {
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation API_DEPRECATED_WITH_REPLACEMENT("application:openURL:options:", ios(4.2, 9.0)) API_UNAVAILABLE(tvos) {
    return YES;
}

@end
