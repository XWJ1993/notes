//
//  AppDelegate.h
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/6/10.
//  Copyright © 2019 zali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

/**
 1.UIWindow
 1>.https://www.jianshu.com/p/af2a6a438a0a - 可以重写UIWindow
 2>.UIWindow是一种特殊的UIView
 3>.每个App至少一个UIWindow：一般只创建一个
 4>.启动原理：iOS程序启动完毕以后创建的第一个视图控件就是UIWindow -> 接着创建控制器的view加到UIWindow
 5>.包含App中的可视化内容
 6>.keyWindow：用来管理键盘以及非触摸类的消息，只能有一个
 7>.UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
 8>.UIWindow有3个级别：UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
 */
@property (strong, nonatomic) UIWindow *window;

/**
 2.设置启动图的方式
 1>.使用LaunchScreen.storyboard（优先级高）
 2>.使用LaunchImage（已废弃）
 */

/**
 3.版本号
 1>.新发布版本必须大于已有版本（Apple强制规定）
 2>.新版本最小必须从1.0开始（0.1不行）
 */
@end

