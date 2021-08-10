//
//  main.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/6/10.
//  Copyright © 2019 zali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WMSkillViewController.h"
/// App启动原理
// 1.执行main函数 - 由系统自动调用
// 2.执行UIApplicationMain：创建UIApplication对象，设置UIApplication代理
// 3.开启一个事件循环（主运行循环、保证App不退出）/死循环
// 4.加载info.plist文件（判断info.plist文件中是否有main参数：是否加载xib）
// 5.应用程序启动完毕（通知 delegate）
/*
 argc - 系统传递进来的参数个数/默认传入一个参数
 argv[] - 系统传递进来的参数实际值
 Edit Scheme... -> Arguments -> Run -> Arguments Passed On Launch // 可以增加传入的参数
 */
int main(int argc, char * argv[]) {
    /// 创建一个自动释放池
    /// 第一种方式
    @autoreleasepool {   // NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
        /**
         NSStringFromClass([AppDelegate class]) - 将类名转换成NSString
         第三个参数：设置App对象的名称（如果是nil/默认是UIApplication）
         第四个参数：设置App的delegate名称
         */
        // 这里开启了一个RunLoop/默认不会返回
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }   // [pool release];
    
//    // 第二种方式
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
//    // 引用计数 + 1 = 1
//    WMSkillViewController *controller = [[WMSkillViewController alloc]init];
//    // 引用计数 + 1 = 2
//    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:controller, nil];
//    // 将指针（实质是将指针加入到自动释放池）加入到自动释放池
//    // 不是让对象引用计数 - 1
//    // 引用计数不变 = 2
//    [controller autorelease];
//    // 当自动释放池销毁的时候会对池子中每个指针指向的对象发送release消息
//    // 引用计数 - 1 = 1
//    [pool release];
//    // 引用计数 - 1 = 0
//    // 销毁
//    [array release];
}
