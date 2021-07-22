//
//  WMSkillViewController.h
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/8/5.
//  Copyright © 2019 zali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMStudyProtocol.h"

NS_ASSUME_NONNULL_BEGIN


@class WMSkillViewController;
/// 1.定义协议protocol
// 协议本身不是类，类似java中的接口
// 作用：给类增加方法（外部可以用类的对象调用该协议方法）
// 规范方法的声明：可以实现多继承和对象间通信
/**
 协议的注意点：
 1.只声明方法（不实现方法/也不能实现属性）
 2.遵从协议的所有类（拥有协议中所有的方法声明）必须导入协议头文件
 3.父类遵循某个协议子类也自动遵循该协议
 4.一个类可以遵循一个或者多个协议
 */
// 可以实现多继承：相同类型可以使用“继承”，不同类型可以使用“协议”
// ！！！"协议protocol"可以直接使用“模版”创建（类似"类别Category"）！！！
// 协议也可以再遵循协议
/// 2.协议的作用
// 1.类型限定 - Student<WMStudyProtocol> *s = [[Student alloc]init];（注意格式）
// 1>.遵循某个协议的不同对象可以放在同一个数组中
// 2>.遵循某个协议但不实现该协议中的方法的对象调用协议中的方法会报错（需要做判断）
//if (self.wife respondsToSelector:@selector(study:)) {
//    [self.wife study:one];
//}
// 2.代理delegate
@protocol WMSkillViewControllerProtocol <NSObject, WMStudyProtocol> // NSObject也是协议、协议也可以再遵循协议
// 必须实现协议（缺省）
// Objective-C不实现会报警告⚠️
// swift中不实现会直接报错
@required
-(void)jumpPage:(NSString *)text;
// 可选实现协议
@optional
-(void)finishTask:(WMSkillViewController *)controller;

@end

@interface WMSkillViewController : UIViewController
// 委托方：持有协议，该类就是委托方
// 使用weak防止内存泄漏？？？说明原因？？？/会被赋值成xxx
// 代理方：遵从协议，实现方法
// 持有协议的id指针
// 不能retain
// 如果有*在<>外面
// 为什么使用id？？？（任何遵循WMSkillViewControllerProtocol的类都可以做为我的代理）
@property (weak, nonatomic) id <WMSkillViewControllerProtocol> delegate;

// 1.定义block - 怎么“声明block”就怎么“定义block”/以后使用直接使用“myBlock”
// block和delegate的区别 - block紧凑一些
@property (strong, nonatomic) void (^myBlock)(BOOL isBlue);
// 企业级开发一般不修改原有方法
// 一般会新写一个方法扩充
-(void)shouGIF;

@end

NS_ASSUME_NONNULL_END
