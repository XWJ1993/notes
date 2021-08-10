//
//  WMGameProxy.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/6/10.
//  Copyright © 2019 zali. All rights reserved.
//

// 需要使用xxx文件就导入xxx.h
// 实际是将WMGameProxy.h文件拷贝到当前文件
#import "WMGameProxy.h"
#import "MainController.h"
// 1.类名
@implementation WMGameProxy {
    // 这里的私有变量无法查看，但是可以使用KVC赋值（OC没有真正的私有）
    int _gameCount;
}
// 2.方法实现

// 什么时候调用 - 当程序一启动的时候调用
// 作用 - 将当前类加载进内存放在代码区/只会调用一次
+ (void)load {
    // 父类的 load() -> 子类的 load()
    // 有且仅有一次/加载到内存
    // 比 “main()” 函数还要先调用/这里的代码需要手动管理内存
    /////////////////////////////////
    // 匿名对象：当对象只需要使用一次的时候/对象作为实参传入方法中
    // 每次使用new都会创建一个新对象
    /**
     1.开辟存储空间/将所有的属性设置为0 - alloc
     2.初始化所有的属性 - init
     3.返回对象的地址
     */
    [MainController new];
}

// 什么时候调用 - 当第一次使用当前类的时候调用
// 作用 - 初始化当前类/会多次调用（被子类调用）
// 不需要创建对象 - 不需要开辟存储空间/优化性能
// ？？？类方法为什么不能直接访问属性？？？
// ？？？类方法怎么访问属性？？？（可以通过类方法调用对象方法间接调用属性/不建议这样写）
// 如果方法中没有使用到成员变量，尽量使用类方法。因为类方法执行效率高
// 类方法一般用于工具方法的定义
+ (void)initialize {
    // 父类的initialize() -> 子类的initialize()
    // [xxx class] - 返回当前类的类对象
    if (self == [WMGameProxy class]) {
        // 第一次新建该类的时候调用：有且仅有一次
        // 用于 init 某些静态变量
    }
}

/// 构造方法/对象的初始化方法/以init开头的方法（必须的）
// OC中称所有init开头的方法为构造方法/只能调用一次，从父类继承
// 初始化对象/初始化对象的成员变量
// id类型通用类型：一般用于"参数类型"/"返回值类型"
- (instancetype)init {
    /**
     super - 编译器的指令符号
     1.子类调用父类方法
     2.在对象方法中调用父类的对象方法
     3.在类方法中调用父类的对象方法
     4.子类重写父类的某个方法时候想要保留父类的一些行为
     */
    // 子类需要使用父类方法的时候也需要手动调用
    // 1.必须先初始化父类/保留父类初始化操作
    self = [super init]; // self代表当前对象本身
    // 2.判断父类是否初始化成功（只有父类初始化成功才可以继续初始化子类）
    if (self) {
        // 3.初始化子类/只有父类初始化成功才可以初始化子类
        // 写在函数或者代码块中的变量称为局部变量
        // 作用域：从定义开始到函数结束（遇到 {} / return）
        // 可以先定义再初始化也可以定义的同时初始化
        // 存储在栈区：系统会自动释放
        /////////////////////////////////////////////////
        // 写在函数和大括号外部的变量称为全局变量
        // 作用域：从定义的那一行开始到文件末尾
        // 可以先定义再初始化也可以定义的同时初始化
        // 存储在静态区：程序一启动就会分配存储空间，直到程序结束才会释放
        MainController *vc = [MainController alloc]; // 分配内存：创建对象后返回对象地址/堆空间
        vc = [vc init]; // 初始化
    }
    // 4.返回当前对象地址
    return self;
}

// 对象方法中访问当前对象的属性_xxx
-(void)loginWithGameId:(NSString *)gameId GameKey:(NSString *)gameKey {
    NSLog(@"login");
    // 最大浮点数 MAXFLOAT
}

/// 初始化方法
// 1>.id/instancetype有什么区别？？？
// 都是万能指针 == 指向同一个类型
// 1).id是一个动态数据类型（定义变量、作为函数参数、作为函数返回值）
// 通过动态数据类型定义变量可以调用子类特有方法
// 通过动态数据类型定义变量可以调用私有方法
// 可以调用到不是自己的方法/任何方法（编译不报错、运行报错）
/**
 静态数据类型和动态数据类型的区别
 1.静态数据类型的特点：在编译期就明确变量的类型，可以访问属性和方法
 2.动态数据类型的特点：在编译期不清楚变量的类型，运行期才知道真实类型
 */
/**
 1.由于动态数据类型可以调用任意方法(有可能调用到不属于自己的方法)、这样可能导致运行期错误；
 2.应用场景：多态-可以减少代码量、避免调用子类特有的方法需要强制类型转换；
 3.怎么避免动态数据类型运行期错误？
 id obj = [person new];
 // 判断某个对象是否属于某一个类（某一个类的子类）
 if ([obj isKindOfClass:[Person class]]) {
     [obj eat];
 }
 id obj = [self new];
 // 判断某个对象是否为当前类的实例
 if ([obj isMemberOfClass:[Person class]]) {
     [obj eat];
 }
 面试题：id和NSObject *有什么区别？？？
 */
// 2).instancetype
// instancetype做为返回值赋值给一个其他类型会报警告（编译的时候可以判断对象的真实类型）
// id做为返回值赋值给一个其他类型不会报警告（编译的时候不可以判断对象的真实类型）
// instancetype只能做为返回值
// id可以定义变量/做为返回值/形参
// 2>.自定义构造方法尽量使用instancetype
// 自定义构造方法强制格式：大小写敏感
// Objective-C中称所有init开头的方法为构造方法
// 构造方法用于“初始化对象”和“初始化对象的属性”
//-(instancetype)initWithXxx {
//}
// 属性名/方法名都尽量不要以new开头
-(instancetype)initWithSdk:(NSString *)sdk {
    // 子类重写父类方法想要保留父类的对象方法
    // super在类方法中调用父类的类方法
    // super在对象方法中调用父类的对象方法
    // 可以利用super在任意方法中调用父类方法
    // ！！！必须先赋值self！！！
    // super - 仅仅是一个编译指示器指令/只要编译器看到super就会让“当前对象”去调用“父类方法”
    // 此处还是“WMGameProxy类的对象”在调用“NSObject类的对象”的“init()”方法
    self = [super init];
    // self不能离开类
    // self在对象方法中指向当前对象（谁调用对象方法self指向谁）
    // self在类方法中指向当前类
    // self->成员变量名; - 访问当前对象内部的成员变量
    // 不能在“对象方法/类方法”中使用self调用“自身对象方法/类方法”（死循环）
    if (self) {
        _name = @"";
        _age = @"";
        _height = @"";
        _sdk = sdk;
    }
    /**
     [self class] - 获取当前方法调用者的类
     [self superclass] - 获取当前方法调用者的父类
     super - 仅仅是一个编译指示器/只要编译器看到super就会让“当前对象”去调用“父类方法”
     [super class] - 让当前类的对象去调用父类的方法
     */
    // [self class] == [super class] = WMGameProxy
    NSLog(@"%@ = %@ = %@", [self class], [self superclass], [super class]);
    return self;
}

/// 单例方法：程序运行过程中，实例对象只有一个
// swift可以声明全局静态变量
// OC不允许对象静态内存分配，因此不能声明全局变量
// 单例 -> 全局变量/单例对象存储的内容全程序共享
// 面试：手写单例方法
// 单例的创建方法通常以 default/shared 开头
/**
 常见单例
 UIApplication - 应用程序
 NSNotificationCenter - 通知中心
 NSFileManager - 文件管理
 */
+(instancetype)getInstance {
    // static声明静态变量 - 在函数结束变量不销毁
    static WMGameProxy *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WMGameProxy alloc]init];
    });
    // 第一次进入创建对象
    // 后续调用不需要再创建对象，因为 static 修饰的对象在函数结束不销毁
    if (instance == nil) {
        instance = [[WMGameProxy alloc]init];
    }
    return instance;
}

// 类工厂方法
// 1>.用于快速创建对象的类方法/用于创建一个对象
// 2>.自定义类工厂方法是Apple规范
// 3>.不要使用WMGameProxy（这样在继承的时候会出现问题）/改成self
// 4>.self在“类方法”中代表“类”/谁调用该方法self就代表谁
// 5>.类方法/方法名称==类名称(首字母小写)/返回值id/instancetype
+(instancetype)wmGameProxy {
    return [[self alloc] init];
//    // MRC环境下
//    return [[[self alloc]init] autorelease];
}
+(instancetype)wmGameProxyWithSdk:(NSString *)sdk {
    // 父类指针指向子类对象
    WMGameProxy *p = [[self alloc] init];
    p.sdk = sdk;
    return p;
}

/**
 继承 - 又叫做派生
 1>.继承 - 父类的属性（成员变量（不包括私有））和方法，子类可以直接获取，这个过程就叫做继承
 2>.派生 - 子类在父类的基础上，创建自己独有的成员变量和方法，这个过程就叫做派生
 3>.每个类的 “[super class]指针” 指向自己的父类/ “isa指针” 指向元类/OC只支持单继承
 4>.好处 - 创建大量的相似类的时候，可以节省工作量（抽取出了重复代码）/重写系统类/建立类和类之间的联系
 5>.缺点 - 耦合性太强
 6>.特点 - 子类可以使用父类的所有方法（方法可以重写）/子类可以访问父类非私有的成员变量（成员变量不能重写）
 */

/**
 多态 - 同一个接口不同的实现
 1>.特点：父类指针指向子类对象/不看指针看对象
 2>.实现条件：有继承关系、有重写、父类的指针指向子类的对象
 3>.优点：提高了代码的扩展性
 */
/**
 重写和重载的区别？
 1.重写 - 重新实现父类方法（方法名相同/实现不同/子类最终执行重写以后得方法）/多态的一种
 2.重载 - 在同一个类定义多个同名方法（每个方法具有不同参数类型或参数个数）/多态的一种
 */
-(void)polyMore {
//    // 1.有继承关系
//    // 2.有重写 - 重新实现父类方法（子类最终执行重写以后得方法）
//    // 3.父类指针a指向子类对象
//    Animal *a = [Dog new];
//    // 编译期：检查当前类型Animal有没有该方法
//    // 运行时：系统会判断a的真实类型
//    [a eat];
//    // 想要调用子类特有方法需要强制类型转换成子类
//    Dog *d = (Dog *)a;
//    [d eat];
}

/**
 虚方法
 1>.定义 - 调用方法的时候不看指针看对象/对象的地址指向什么对象就调用什么方法
 2>.好处 - 可以描述不同事物被相同事件触发产生不同的响应
 3>.特征 - OC中的每一个方法都是虚方法
 */

/**
 工厂类
 1>.定义 - NSString/NSArray/NSDictionary/NSNumber都是工厂类（抽象类）
 2>.特征 - 不能被继承
 3>.不能被继承的原因 - NSString采用“抽象工厂”模式：内部是个类簇(class cluster)。它在外层提供了很多方法接口，但是这些方法的实现是由具体的内部类来实现的。当使用NSString生成一个对象时，初始化方法会判断哪个“自己内部的类”最适合生成这个对象，然后这个“工厂”就会生成这个具体的类对象返回给你，这种由外层类提供统一抽象的接口，然后隐藏具体的内部类来实现
 */

/**
 Category类别/分类
 // 1.作用
 1.一旦使用类别给已有的类增补方法，那么这个类的对象就可以使用该方法
 2.不修改原有类的基础上给已有的类/系统原生类增加方法：组件化基础
 3.可以对类的方法进行分类管理：将类的实现分散到多个不同的文件和框架中
 // 2.注意
 1.类别中不能添加成员变量（在分类@property只能生成setter/getter方法的声明，不会生成setter/getter方法的实现和私有的成员变量）
 2.使用类别必须导入类别头文件
 3.父类类别中的方法子类也可以使用（可以在分类中访问原有类中.h中的属性、分类和原有类中的方法同名会优先调用分类中的方法）
 4.如果多个分类和原有类都有同名方法，则调用该方法的顺序由编译器决定（会执行最后一个参与编译的分类中的方法）
 */
// 类扩展/匿名类别
// 1.当定义不想对外公开一些类的方法和属性时可以使用类扩展（）
// @interface SyPerson()
// // 可以声明私有成员变量
// @property (weak, nonatomic) UIImageView *iconImageView;
// // 可以声明私有方法：声明和实现都在“.m文件”中
// -(void)song;
// @end
/**
 1.熟悉怎么新建Category类别
 2.明白类扩展就是匿名类别
 3.Category类别不能新增成员属性/类扩展既可以新增成员属性也可以新增成员方法
 */
/**
 category和extension的区别
 1.category有名字，extension没有名字
 2.category只能扩展方法（属性仅仅是声明，并没有真正实现）、extension可以扩展属性和成员方法
 */

// 不会输出"self"/死循环
// NSLog()输出<类名:地址>/<Person: 0x100202310>
// 输出self就是调用[self description];
- (NSString *)description {
    // 调用方法
    // 先从自己类中找 -> 再去父类中找
    // 返回当前对象
    // 调用 - (NSString *)description {}
    // 默认返回：<类名: 地址>
    NSLog(@"%@", self);
    // 返回当前类对象
    // 调用 + (NSString *)description {}
    // 默认返回：xxx
    NSLog(@"%@", [self class]);
    return [NSString stringWithFormat:@"%@", _height];
}

// 整型NSInteger
// 布尔类型BOOL
// 结构体NSRange
-(void)showRange {
    NSRange range0 = {1,5};
    NSRange range1 = NSMakeRange(1, 5);
    NSLog(@"%ld,%ld", range0.length, range1.location);
}

// 如果需要给属性赋值、可以使用set方法
// 封装：屏蔽内部实现细节，对外提供共有的方法和接口
// 一定是对象方法：有参数无返回值
-(void)setSdk:(NSString * _Nonnull)sdk {
    _sdk = sdk;
//    // set方法的实质
//    // 可以自己操作一把
//    if (_sdk != sdk) {
//        [_sdk release];
//        _sdk = [sdk retain];
//    }
}
// 获取属性内容、可以使用get方法
// 一定是对象方法：无参数有返回值
-(NSString * _Nonnull)getSdk {
    return _sdk;
}

/// 点语法 - 为了让程序设计简单化
// 属性可以在不使用"[对象指针 方法名称]"的情况下使用点语法
// 点语法的实质 - 是调用"setter/getter方法"（不是使用成员变量）
/**
 // 点语法在等号左边就是set方法，点语法在等号右边就是get方法
 xiaoMing.name = @"小明"; <==> [xiaoMing setName:@"小明"];
 NSString *name = xiaoMing.name; <==> NSString *name = [xiaoMing getName];
 */
// 点语法是一个编译器的特征（会在程序翻译成二进制的时候转换成"setter/getter方法"）
// 注意：一般情况下如果不是给成员变量赋值不建议使用点语法
-(void)pointWay {
    WMGameProxy *wm = [[WMGameProxy alloc]init];
    wm.sdk = @"xxx"; // 在等号左边：编译器自动转换成“setter方法”
    NSString *name = wm.sdk; // 在等号右边（没有等号）：编译器自动转换成“getter方法”
    NSLog(@"%@", name);
    // 预置在编译器中的宏
    // __func__是一个字符串
    // 输出调用__func__的函数的函数名
    NSLog(@"%s", __func__);
    /*
     访问属性的方式：
     p->_age; // 真正Objective-C语法
     [p age];
     p.age;
     */
}

/// json解析
// 实质：将所有的dict都转化成model放到对应NSArray中
// 把dict传入model
// model内部赋值
// 返回model
+(instancetype)gameWithDict:(NSDictionary *)dict {
    // 保证字典键 (key) 和模型的属性一致才可以使用 KVC
    WMGameProxy *proxy = [[WMGameProxy alloc]init];
    [proxy setValuesForKeysWithDictionary:dict];
    return proxy;
}

/// 归档
// 告诉需要保存当前对象的哪些属性
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.userName forKey:@"username"];
    [coder encodeInteger:self.weight forKey:@"weight"];
    [coder encodeObject:self.item forKey:@"item"];
}
// 当解析一个文件的时候调用
- (instancetype)initWithCoder:(NSCoder *)coder {
//    // 只有遵循“NSCoding协议”才可以调用
//    self = [super initWithCoder:coder];
    self = [super init];
    if (self) {
        self.userName = [coder decodeObjectForKey:@"username"];
        self.weight = [coder decodeIntegerForKey:@"weight"];
        self.item = [coder decodeObjectForKey:@"item"];
    }
    return self;
}

/// 通知相关
-(void)onChange:(NSNotification *)notifucaiton {
    // id属性没有“点语法”
    // 可以使用“get方法”
    NSLog(@"通知名称[%@]-通知内容[%@]-通知发布者[%@]",
          notifucaiton.name, notifucaiton.userInfo, notifucaiton.object);
}

/// 自定义类实现Copy
- (id)copyWithZone:(nullable NSZone *)zone {
    // 1.创建一个新对象
    WMGameProxy *wm = [[[self class] allocWithZone:zone] init];
    // 2.设置当前对象的内容给新对象
    wm.mName = _mName;
    // 3.返回新对象
    return wm;
//    // 如果父类已经实现该协议
//    id obj = [super copyWithZone:zone];
//    obj.age = _age;
//    return obj;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    // 1.创建一个新对象
    WMGameProxy *wm = [[[self class] allocWithZone:zone] init];
    // 2.设置当前对象的内容给新对象
    wm.mName = _mName;
    // 3.返回新对象
    return wm;
}

// 实现类结束的标志
@end
