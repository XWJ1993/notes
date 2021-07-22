//
//  WMGameProxy.h
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/6/10.
//  Copyright © 2019 zali. All rights reserved.
//

// 由于继承NSObject、所以导入Foundation
// import可以防止重复导入
#import <Foundation/Foundation.h>
#import "SyPostItem.h"

NS_ASSUME_NONNULL_BEGIN
/**
 1.认识Objective-C语言
 1>.概述：面向对象(oop)的C语言/ 完全兼容C语言/ C语言代码可以直接编译在Objective-C工程中
 2>.源文件：.h/.m/.mm；
 3>.关键字：C语言关键字在Objective-C中都可以使用/新增部分关键字（@interface、@public、@implementation等）
 4>.数据类型：BOOL/SEL/null
 5>.C语言/int <==> OC语言/NSInteger <==> swift语言/Int
 */

// 面向对象编程是把问题中拥有相同属性的东西建立一个类，然后创建类的对象
// 面向对象编程注重生活逻辑、面向过程编程注重数学逻辑
/**
 2.面向对象OOP - 把问题里拥有相同属性的东西建立一个类
 1>.封装：利用类将数据和基于数据的操作封装在一起，数据被保护在类的内部，系统的其它部分只有通过被授权的操作才可以访问数据；将不需要对外提供的内容隐藏起来：把属性隐藏起来，提供公共方法对外访问
 2>.继承/派生：1.继承：父类的属性（成员变量：不包括私有）和方法（对象方法 & 类方法），子类可以直接获取；2.派生：子类保持父类中的行为和属性，新增其它功能（对象方法 & 类方法可以重写、属性不能重写）；3.提示：每个类都有一个"[self superclass]指针" 指向自己父类（OC只支持单继承）；4.好处：1).创建大量类抽取重复代码；2).建立类与类之间的关系；3).耦合性（依赖性）太强；
 3>.多态：程序中可以有同名的不同方法共存，利用子类对父类方法的覆盖和重载在同一个类中定义多个同名的方法来实现；
 */
// 面向对象编程是把问题中拥有相同属性的东西建立一个类，然后创建类的对象
// 面向对象编程注重生活逻辑、面向过程编程注重数学逻辑
/**
 3.主头文件 - copy该工具箱中所有工具的头文件的文件
 1>.只需要导入主头文件就可以使用该工具箱中所有头文件，避免每次使用都需要导入一众对应的头文件
 2>.主头文件的名称都和工具箱的名称相同（导入该工具箱的所有头文件）
 */

/**
 4.类class：属性 + 行为（谁最清楚这个行为，那么行为就属于谁）
 1>.定义：具有相同和相似性质对象的抽象就是类；对象的抽象就是类，类的具体化就是对象（堆内存）
 2>.类 = 结构体(存储数据) + 函数(管理数据)
 3>.实质：类的实质是一个对象，该对象会在这个类第一次被使用的时候创建
 */

/// .h文件用来声明类
// NSObject是基类，顶级父类
// 子类可以继承父类的所有方法和属性（私有属性虽然拥有但是不能访问/非私有属性才可以访问）
// 父类的属性可以继承、但是方法只能通过super调用
// WMGameProxy类名/类名必须大写
// NSObject父类（顶级父类）
// .h/.m相互切换：command + control + 👆
// 自定义泛型
@interface WMGameProxy <ObjectType> : NSObject <NSCoding, NSCopying, NSMutableCopying> {
    /// 定义属性
    // 实例变量/成员变量/属性
    // 成员变量不能离开类：只能写在类内部
    // 在OC中：成员变量不能直接赋值（不能直接初始化）、swift可以
    // ！！！定义成员变量：变量必须使用下划线！！！
    // Objective-C语言没有真正意义的私有方法、只是一个约定而已、也是可以调用
    // Objective-C语言支持消息机制（运行时可以动态绑定）
    // 引用私用api（苹果官方私有方法）不能上架AppStore
    // 存储在堆区（当前对象对应的堆的存储空间中）：不会被自动释放（程序员手动释放）
    /// Objective-C语言修饰符
    // 修饰范围：从出现的位置到第二个修饰符出现或者遇到 "}"
    @private  // 私有成员：只能被本类访问、不能被子类访问、不能被外部访问（虽然不能访问但是还可以查看，如果不想让其查看可以直接定义在.m中）
    NSString *_name;
    @protected  // 受保护的属性：默认属性、可以被本类访问、也能为子类访问、不能被外部访问
    NSString *_age;
    @public   // 公共成员：能被本类访问、能为子类访问、能被外部访问
    NSString *_height;
    @package  // 只能在当前包中才能被访问（在当前包中相当于@public、在非当前包中相当于@private）
}
/// @property编译器指令
// 如果类中成员方法太多，setter/getter方法非常臃肿
// 1.让编译器自动声明“setter/getter方法”/2.生成_sdk成员变量
// 持有的对象sdk引用计算 + 1
// 通过自动释放池管理内存
// 如果重写setter/getter方法，则以重写的为主/@property就不会（自动声明setter/getter方法/生成_sdk成员变量）
// 自动生成的变量_sdk是私有变量
@property (strong, nonatomic) NSString *sdk;
// @synthesize编译器指令（孙色size）
// 让编译器自动实现setter/getter方法（Xcode4.6以后可以省略）
// atomic原子性：对当前属性进行加锁、线程安全、消耗性能、访问速度慢/默认
// nonatomic非原子性：不加锁、线程不安全、访问速度快
@property (strong, atomic) NSString *publishName;
// assign一般用于基础数据类型
// 这里不需要加*
// NSInteger的含义？？？
@property (assign, nonatomic) NSInteger publishAge;
// readonly只读：只生成getter方法
// readwrite缺省
@property (readonly, strong, nonatomic) NSString *GameKey;
/// 可以增强代码的可读性
// 给getter方法取别名
// 一般使用于BOOL：改成isXxx
@property (getter = myWeight) NSInteger weight;
// 给setter方法取别名
// 一般不使用
@property (setter = myHeight:) NSInteger mheight;
// 多个属性使用","隔开
@property (setter = setUserName:, getter = getUserName, strong, nonatomic) NSString *mName;
/**
 表示"可能为空" - 用于属性、参数、方法返回值/为了迎合 swift
 nullable修饰属性位于 (nullable, strong, nonatomic)/nullable修饰形参位于(nullable NSString *)
 */
@property (nullable, strong, nonatomic) SyPostItem *item;
/**
 表示"不能为空" - 用于属性、参数、方法返回值/为了迎合 swift
 nonnull修饰属性位于 (nonnull, strong, nonatomic)/nonnull修饰形参位于(nonnull NSString *)
*/
@property (nonnull, strong, nonatomic) NSString *resetName;
/**
 1.原子性
 atomic // 加锁/消耗性能、访问速度慢/多线程环境下存在线程保护（默认/原子性）
 nonatomic // 不加锁/访问速度快/多线程环境下不存在线程保护/非原子性
 2.赋值
 assign // 一般用于基本类型/直接赋值（默认）
 retain  //  保留对象
 copy    // 拷贝对象/修饰字符串（不可变字符串可以直接使用strong）
 3.读写
 readwrite  // 生成“getter/setter方法”
 readonly   // 只生成“getter方法”
 */
// 如果想对传入的数据进行过滤需要重写“getter/setter方法”
// 如果重写“getter/setter方法”，@property将不再生成“getter/setter方法”
@property (nonatomic, retain, readonly) NSString *userName;
// 自定义泛型
@property (strong, nonatomic) ObjectType obj;
/**
 __kindof - 当前类或者子类
 给某个类提供类方法，可以让外界知道创建了什么对象
 */
+(__kindof WMGameProxy *)WMGameProxy;

#pragma mark - 这是一个注释（可以用来分割功能点）
/// 定义方法/行为
// 冒号也是方法名的一部分
// 定义在.h文件中的方法都会公有的、不能使用@private/@protected/@public修饰（这点与java等其他语言不同）
// 对象方法：只能被对象名调用、以“-”开头
// 方法属于类
// ⚠️在oc中“()”只有一个作用：括住数据类型
// 对象作为参数传递是地址传递
-(void)loginWithGameId:(NSString *)gameId GameKey:(NSString *)gameKey;

/**
 5.类方法 - 以“+”开头
 1>.概念：C++中的静态方法/不属于任何一个对象/通过类名调用，不需要创建对象/不能直接调用对象方法和成员变量
 2>.对一个功能模块留下简单的对外接口
 3>.类方法的执行效率比对象方法高：对象方法可以访问成员变量/类方法中不可以直接访问成员变量
 */
+(instancetype)getInstance;

/**
 6.类工厂方法 - 用于快速创建对象的类方法
 1>.一定是类方法+
 2>.方法名称以 “类名” 开头/首字母小写
 3>.一定有返回值id/instancetype
 */
+(instancetype)wmGameProxy;
+(instancetype)wmGameProxyWithSdk:(NSString *)sdk;

// 初始化方法
-(id)initWithSdk:(NSString *)sdk;

// 不推荐直接给属性赋值
// 如果需要给属性赋值、可以使用set方法
// 修改实例变量
-(void)setSdk:(NSString * _Nonnull)sdk;

// 获取属性内容、可以使用get方法
// 读取实例变量
-(NSString * _Nonnull)getSdk;

// 通过传入NSDictionary赋值模型
// 返回的 model 放在数组
+(instancetype)gameWithDict:(NSDictionary *)dict;

// 消息中心
-(void)onChange:(NSNotification *)notifucaiton;

// 声明类结束的标志
@end

NS_ASSUME_NONNULL_END
