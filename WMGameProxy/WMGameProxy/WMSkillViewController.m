//
//  WMSkillViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/8/5.
//  Copyright © 2019 zali. All rights reserved.
//

#import "WMSkillViewController.h"
#import "UIImage+animatedGIF.h"
#import "MainController.h"
#import "WMGameProxy.h"
#import <StoreKit/StoreKit.h>

@interface WMSkillViewController () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) void(^block)(void);
// 这里使用weak/strong都可以
// 因为此处有一个看不到的强指针引用
@property (weak, nonatomic) NSTimer *timer;

@end

@implementation WMSkillViewController
#pragma mark - ViewController的生命周期
/**
 // 首次进入
 1.第一次加载vc：loadView->viewDidLoad->viewWillAppear->viewDidAppear
 // push
 2.跳转第二个vc：viewWillDisappear->loadView->viewDidLoad->viewWillAppear->
 viewDidDisappear->viewDidAppear
 // present
 2.跳转第二个vc：loadView->viewDidLoad->viewWillDisappear->viewWillAppear->
 viewDidAppear->viewDidDisappear
 // pop、dismiss
 // 不重新创建第一个VC
 // 第二个VC销毁
 3.返回第一个vc：viewWillDisappear->viewWillAppear->viewDidDisappear->viewDidAppear
 ->dealloc
 https://blog.csdn.net/spicyshrimp/article/details/70886516
 */

// 系统调用
/**
 作用 - 控制器会调用方法去创建控制器的view
 什么时候调用 - 当第一次使用控制器的view
 使用场景 - 自定义控制器的view（一旦重写loadView，必须自己创建控制器的view）
 注意 - 在view没有赋值之前不可在loadView中调用view的getter方法，因为getter方法底层会调用loadView方法造成死循环
 */
- (void)loadView {
    // 保留父类方法
    // 一般都需要调用
    // “自定义self.view” 不用调用该方法
    [super loadView];
    // 0.初始化控制器的 self.view/创建self.view
    // 当 self.view 第一次使用的时候调用
    // self.view是lazy
    // ！！！ self.view还没有加载完成 ！！！
    /*
     底层原理：
     先判断当前VC是不是从storyboard中加载的？？？
     1.如果是：把storyboard中的view设置为self.view
     2.如果不是：创建一个空白的View
     */
    // 系统调用：当控制器 View 第一次使用的时候调用该方法
    // 一旦重写该方法：需要自定义View
    self.view = [[UIView alloc]init];
    // 通过该方法设置 alpha = 0 不能响应事件
    self.view.alpha = 0;
    // 如果需要透明控件响应事件：颜色透明/可以处理事件
    self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.控制器view加载完毕：创建所有子视图
    // 2.控件的初始化
    // 3.数据的初始化（懒加载）
    // view是否加载
    if (self.viewIfLoaded) {
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 2.视图将要出现
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 5.视图已经出现/显示完毕
    // 只能在这里移除 self.view
    // 只有有父视图都可以移除
    // self.view的父视图是 self.window
    [self.view removeFromSuperview];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    // 3.控制器的View将要布局子视图
    // 会调用多次
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 4.控制器的View布局子视图结束
    // 会调用多次
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 6.视图将要消失
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 7.视图已经消失
}

#pragma mark - 设计模式
-(void)showModel {
    // 1.什么是设计模式 - 一套被反复使用的代码设计经验的总结
    // 2.常见的设计模式 - 单例模式、工厂模式、代理模式
    /**
     3.单例模式
     */
    /**
     3.工厂模式
     1>.工厂方法 - 用来快速创建对象
     2>.抽象工厂 - 抽象出来一个公共的父类（子类继承即可，不会使用父类创建对象）
     */
    /**
     3.代理模式
     */
}

#pragma mark - 定时器
// 频繁的销毁和创建"定时器"
// https://blog.csdn.net/zhuzhihai1988/article/details/7742881
-(void)createTimer {
    /// 创建定时器
    // NSTimer可以直接用weak
    // 定时器会在 1s 以后开始
    // 第一种方式 - 需要加入到NSRunLoop中
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
//    // 第二种方式 - 不需要加入到NSRunLoop中/内部已经加入默认模式中
//    // 这种创建方式定时器在UI界面滑动的时候也是不工作 - 需要重新添加
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    // 解决定时器在主线程不工作的原因
    // ！！！主线程无论在处理什么操作都会抽时间处理NSTimer！！！
    // ？？？有点不太明白？？？
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    // 立即开始
    [timer fire];
//    // 停止定时器
//    // NSTimer停止以后就不能再使用（需要再重新创建一个）
//    [timer invalidate];
//    // 如果self持有timer则需要再加上这句话（存在循环引用）
//    timer = nil;
    // 开启定时器
    // 骚操作
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:)
                                           userInfo:@"123" repeats:YES];
}
-(void)onTimer:(NSTimer *)timer {
    NSLog(@"%@", timer.userInfo);
    // 比较消耗性能
    // 容易乱
    // 会递归一直遍历self.view的子控件
    UILabel *myLabel = [self.view viewWithTag:0];
    myLabel.text = @"我过分";
}


#pragma mark - MPMoviePlayerController/MPMusicPlayerController


#pragma mark - iOS自动布局框架 / Masonry详解
// https://www.jianshu.com/p/ea74b230c70d


#pragma mark - 使用 gif
// 一般使用"帧动画"替代"gif"
-(void)shouGIF {
    // 每个本地文件都可以通过该方法转换成 "url"
    // 利用"url"生成对象本身
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"FlagZombie" withExtension:@"gif"];
    UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:url];
    UIImageView *gifImageView = [[UIImageView alloc]initWithImage:image];
    gifImageView.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:gifImageView];
}


#pragma mark - 传值
// 1.普通传值
// 2.delegate传值
// 3.block传值
-(void)jumpPage {
    /// 1.普通传值
    MainController *controller = [[MainController alloc]init];
    controller.mainText = @"普通传值";
    [self.navigationController pushViewController:controller animated:YES];
    /// 2.delegate传值
    // 那个页面需要调用该方法就需要遵循该 delegate
    // 2.调用delegate
    // delegate 是否实现了该方法
    if ([_delegate respondsToSelector:@selector(jumpPage:)]) {
        [_delegate jumpPage:@"delegate传值"];
    }
    /// bolck（与 delegate 一样）
    // 调用 block
    self.myBlock(YES);
}


#pragma mark - 异常处理
-(void)hock {
    NSArray *array = [NSArray array];
    @try {
        // 可能会出现异常的代码
        [array objectAtIndex:5];
    } @catch (NSException *exception) {
        // 如果捕捉到错误：执行此处的代码
        NSLog(@"%@", exception);
    } @finally {
        // 可选：必执行代码
        NSLog(@"finally");
    }
}


#pragma mark - 数据持久化
/// 0.为什么有 “数据持久化”？
// 通常程序在运行中或者程序结束以后，需要保存一些信息（登录信息、播放记录等）
/// 1.“数据持久化” 存放的位置？
// 数据存放在“沙盒”中
/// 2.沙盒机制NSHomeDirectory()
// 1>.定义 - “沙盒机制”是一种安全体系，规定了应用程序只能在该自己创建的文件夹内读取文件，不可以访问其他地方的内容。所有的非代码文件都保存在沙盒：比如图片、声音、属性列表和文本文件等；
// Documents-保存应用程序运行时生成的需要持久化的数据（持久化数据/会备份）
// tmp-保存应用程序运行时所需要的临时数据（临时文件/不会备份）
// Library/Caches-保存应用程序运行时生成的需要持久化的数据（不会备份/缓存/一般较大）
// Library/Preference-保存应用的所有偏好设置（缓存/会备份）
/**
 1.每个应用程序都有自己的沙盒；
 2.不能随意跨越自己的沙盒去访问别的应用程序沙盒的内容；
 3.应用程序向外请求或接收数据都需要经过权限认证；
 */
-(void)showSandBox {
    //沙盒根目录
    NSLog(@"获取该应用沙盒根目录===%@", NSHomeDirectory());
    NSString *string = @"我的小可爱";
    /**
     获取 ../Documents
     第一个参数：搜索的目录
     第二个参数：搜索的范围
     第三个参数：是否展开路径
     */
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES).firstObject;
//    // 获取 ../Library
//    NSString *libarayPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
//    NSUserDomainMask, YES).firstObject;
//    // 获取 ../tmp
//    NSString *tempPath = NSTemporaryDirectory();
    // 拼接一个文件名
    NSString *filePath = [documentPath stringByAppendingPathComponent: @"nick.txt"];
    // 路径是沙盒路径
    if ([string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
        NSLog(@"存储成功");
    }
}
/// 3.“数据持久化” 常用方法（少量数据 - 文件操作/Preference偏好设置/plist属性列表 ｜ 大量数据 - SQLite数据库/Core Data/FMDB第三方库）
// 0.文件操作
-(void)showFile {
    
}
// 1.Preference偏好设置
// 保存一些简单数据
// 不能保存自定义对象（自定义对象使用“归档”保存）
-(void)showPreference {
    /// 写入数据
    // 实例化
    [[NSUserDefaults standardUserDefaults] setObject:@"value" forKey:@"key0"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"key1"];
    [[NSUserDefaults standardUserDefaults] setValue:@(10) forKey:@"key2"];
    [[NSUserDefaults standardUserDefaults] setInteger:10 forKey:@"key3"];
    // 同步到持久状态
    [[NSUserDefaults standardUserDefaults] synchronize];
    /// 读取数据
    NSString *value = [[NSUserDefaults standardUserDefaults] objectForKey:@"key0"];
    BOOL shouldHide = [[NSUserDefaults standardUserDefaults] boolForKey:@"key1"];
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"key2"];
    NSLog(@"%@===%d===%ld", value, shouldHide, count);
}
// 2.XML属性列表归档plist
// 只能存放NSString/NSNumber/NSDate/NSArray/NSDictionary
// 不能保存自定义对象（自定义对象使用“归档”保存）
// plist的手动创建（右键 -> New File -> Resource -> Property List）
-(void)showPlist {
    /// 1.写入数据 myConfig.plist
    // 把NSDictionary/NSArray写入到myConfig.plist
    NSArray *names = @[@"yjn", @"mj", @"gxq", @"nj"];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                            NSUserDomainMask, YES).firstObject;
    // 拼接一个文件名
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"myConfig.plist"];
    // 路径是沙盒路径
    [names writeToFile:filePath atomically:YES];
    
    /// 2.获取myConfig.plist数据
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"myConfig" ofType:@"plist"];
    // 通过路径转化数组（字典）
    // 1>.如果root是dic使用NSMutableDictionary接收
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    // 2>.如果root是Array使用NSMutableArray接收
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSLog(@"%@===%@", dic, array);
}
// 3.归档NSCoding
// 一种序列化与反序列化
// 可以用来保存 “对象”
// 对象必须实现 "NSCoding协议" 才可以
// https://www.jianshu.com/p/3e08fa21316d
-(void)showCoding {
    // 新建对象
    WMGameProxy *wm0 = [WMGameProxy new];
    wm0.userName = @"谢吴军";
    wm0.weight = 150;
    // 如果需要保存 SyPostItem 对象
    // SyPostItem也需要实现 “NSCoding协议”
    // 实现 "NSCoding协议" 就是告诉用户：我准备存储哪个属性
    SyPostItem *item = [SyPostItem new];
    item.citys = @[@"A", @"B", @"C"];
    item.name = @"安庆";
    wm0.item = item;
    // 获取 “沙盒目录”
    NSString *tempPath = NSTemporaryDirectory();
    // 拼接文件
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"sdk.data"];
    // 归档
    // 会调用 - (void)encodeWithCoder:(NSCoder *)coder 方法
    if (@available(iOS 12.0, *)) {
        NSError *error;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:wm0 requiringSecureCoding:YES error:&error];
        [data writeToFile:filePath atomically:YES];
    } else {
        [NSKeyedArchiver archiveRootObject:wm0 toFile:filePath];
    }
    // 解档
    // 会调用“-(instancetype)initWithCoder:(NSCoder *)coder方法”
    if (@available(iOS 12.0, *)) {
        NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
        NSError *error;
        WMGameProxy *wm1 = (WMGameProxy *)[NSKeyedUnarchiver unarchivedObjectOfClass:[WMGameProxy class] fromData:data error:&error];
        if (error) {
        }
         NSLog(@"%@", wm1.userName);
    } else {
        WMGameProxy *wm1 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        NSLog(@"%@", wm1.userName);
    }
}
// 4.数据库SQLite3
-(void)showSqlite {
    
}
// 5.Core Data
-(void)showCoreData {
    
}


#pragma mark - block
// 1.概念：block是iOS中一种比较特殊的数据类型（官方特别推荐使用）
// 2.作用：用来保存“代码块”，在恰当的时候再取出来调用（类似于函数、效率高）
-(void)shouBlock {
    // 3.block的基本写法
    // 1).无参数无返回值
    /**
     void - 表示myBlock保存的代码没有返回值
     (^myBlock) - 代表myBlock是一个"block变量"，可以保存一段block代码
     (void) - 表示myBlock保存的代码没有形参
     */
    void (^myBlock)(void);
    // 只能保存“block代码段”
    // ！！！如果没有“形参”的话()可以省略！！！
    myBlock = ^(){
        NSLog(@"这是一个block");
    };
    // 想要执行“block保存的代码”，需要调用block
    myBlock();
    
    // 2).无参数有返回值
    // ！！！如果没有“形参”的话()可以省略！！！
    NSString* (^plus)(void);
    plus = ^ {
        return @"这是一个block";
    };
    plus();
    
    // 3).有参数无返回值
    void (^add)(int, int);
    add = ^ (int value1, int value2){
        NSLog(@"这是一个block");
    };
    add(10, 20);
    // 4).有参数有返回值
    int (^sum)(int, int);
    sum = ^ (int value1, int value2){
        return value1 + value2;
    };
    sum(10, 20);
    
    // 4.block是一种数据类型
    // 1>.先定义再初始化
    int (^log)(int, int);
    log = ^ (int value1, int value2){
        return value1 + value2;
    };
    log(10, 20);
    // 2>.定义的同时初始化
    int (^request)(int, int) = ^ (int value1, int value2){
        return value1 + value2;
    };
    request(10, 20);
    
    // 5.利用"typedef"给"block取别名"（因为block是一种数据类型）
    // “block变量名”就是别名
    typedef int (^sumBlock)(int, int);
    sumBlock sumP = ^ (int value1, int value2){
        return value1 + value2;
    };
    sumP(10, 20);
    
    // 6.block作为函数参数
    // 普通数据类型作为函数参数只可以传递“数字/字符串”
    // block作为函数参数直接可以传递“代码块”
    
    // 7.注意事项
    // 1).block中可以访问外部的变量
    // 如果想要在block中修改外部变量的值，必须在外界变量前面加上__block
    // 如果在block中修改了外部变量的值，会影响到外部变量的值
    /**
     如果是局部变量 -> 值传递 -> 不能被内部修改/！！！什么修饰都不加不能被传递！！！
     如果是静态变量 / 全局变量 / __block -> 地址传递 -> 能够被内部修改
     */
    __block int m1 = 10;
    void (^yourBlock)(void) = ^{
//        // 2).block中可以定义和外界同名的变量（就近原则）
//        int m1 = 20;
        
        // 3).默认情况下，不可以在block中修改外部的变量
        // 因为block中的变量和外界的变量并不是同一个变量
        // 如果block中访问到外界的变量会将外界的变量copy一份到堆内存
        m1 = 30;
        NSLog(@"m1 = %d", m1);
    };
    // 因为block使用外界的变量是copy的，所以此处修改变量值不会影响block中变量值
    m1 = 20;
    yourBlock();
    // cc -rewrite-objc xxx.m 转换成c++代码
    
    // 8.面试题
    // 1>.block是存储在“堆内存”还是“栈内存”中
    /**
     1.默认情况下block存储在栈中，如果对block进行一个copy操作就会转移到堆中；
     2.如果block在栈中访问了外部的对象，那么不会对外部的对象进行retain操作；
     3.如果block在堆中访问了外部的对象，那么会对外部的对象进行retain操作；
     */
//    // 如果在block中访问外部的对象，一定需要给对象加上__block，只要加上__block哪怕block在堆中也不会对外界的对象进行retain操作
//    WMGameProxy *wm = [WMGameProxy new];
//    NSLog(@"retainCount = %lu", [wm retainCount]);
//    void (^proxy)(void) = ^ {
//        NSLog(@"%@", wm);
//        NSLog(@"retainCount = %lu", [wm retainCount]);
//    };
//    Block_copy(proxy);
//    proxy();
    
    // 9.block的快捷方式 - inlineBlock
}
// 将 “void (^myBlock)(void)” 中myBlock取出来即可
-(void)completeBlock:(void (^)(void))myBlock {
    // 代码块
    
    myBlock();
    
    // 代码块
}
// 内存管理
-(void)setMemoryManager {
    // 1>.block是不是一个对象？？？
    // 是一个对象/需要管理内存
    // 2>.MRC
    // block代码块中引用外部局部变量 -> 栈
    // block代码块中没有引用外部局部变量 -> 全局区
    /**
     1.只能使用copy修饰block/copy可以让block从栈区转移到堆区
     2.不能使用retain修饰block/retain修饰的block还是在栈区/调用会crash
     */
    void(^block)(void) = ^{
        NSLog(@"调用block");
    };
    NSLog(@"%@", block);
    // 3>.ARC
    // block代码块中引用外部局部变量 -> 堆
    // block代码块中没有引用外部局部变量 -> 全局区
    // 最好使用strong/不要使用copy
}
/**
 什么是循环引用 - A引用B/B引用A导致A和B都不能够释放内存
 1>.block为什么会导致循环引用？- block会对“代码块”中的强指针变量全部进行一次强引用
 __weak typeof(self) weakSelf = self;
 */
// 渐变动画会出现循环引用吗？？？- 不会
-(void)setCycle {
    // 指明  “self” 为 “弱指针变量”
    __weak typeof(self) weakSelf = self;
    _block = ^ {
        // block内部如果有延迟操作需要用一个强指针指向，不然拿不到结果
        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@", strongSelf);
        });
    };
}


#pragma mark - 通知机制
/**
 常见的几种 “消息通信” 的方式的区别？？？
 0>.利用 “通知”/“代理” 都可以实现对象之间的通信
 1>.“通知”可以一对多，全局都可以接收到通知；
 2>.“代理”只能一对一，执行效率比通知高；
 */
// 1.每个App都有一个通知中心，负责不同对象之间的消息通信
// 2.任何对象都可以发布通知，其他对象（观察者）都可以接收该通知/一对多
// 3.可以降低对象之间的耦合度/解耦
-(void)showNotification {
    WMGameProxy *wm = [WMGameProxy new];
    // 一、监听通知
    // ！！！先注册 “接收通知”，再 “发送通知”！！！
    // 另外一个对象接收通知
    /**
     参数一/添加的观察者、接收通知的对象（ “响应方法”一般在 “该类” 中实现 ）
     参数二/观察者的响应方法、一旦被观察者消息发生变化就会触发该方法
     参数三/通知的名称（可以为 nil/不关注是 “什么通知”）/明确告诉系统想要监听 “什么通知”
     参数四/通知的发布者（可以为 nil/不关注是 “谁发布的通知”）/被观察者/明确告诉系统想要监听 “谁发布的通知”
     */
    // 此处不接收 “匿名通知”
    [[NSNotificationCenter defaultCenter] addObserver:wm selector:@selector(onChange:) name:@"network3" object:wm];
    // 此处接收 “匿名通知”
    [[NSNotificationCenter defaultCenter] addObserver:wm selector:@selector(onChange:) name:@"network3" object:nil];
    // 二、创建通知对象
    /**
     参数一/通知的名称
     参数二/通知的发布者（可以为 nil）
     参数三/通知传递的参数
     */
    NSNotification *notification1 = [[NSNotification alloc]initWithName:@"network1" object:wm userInfo:@{@"title": @"中国大佬"}];
    NSNotification *notification2 = [NSNotification notificationWithName:@"network2" object:nil userInfo:@{@"title": @"中国大佬"}];
    // 三、发送通知
    // 任何对象 -> “通知中心[NSNotificationCenter defaultCenter]” -> 另外一个对象/观察者
    [[NSNotificationCenter defaultCenter] postNotification:notification1];
    // 匿名通知
    [[NSNotificationCenter defaultCenter] postNotification:notification2];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"network3" object:wm userInfo:@{@"title": @"中国大佬"}];
    /// 四、移除通知（ iOS9.x以后可以不做 ）
    // ！！！一般在 “被观察者对象wm” 的 “- (void)dealloc;” 方法中移除移除通知！！！
    // ！！！移除通知必须要在 “wm被销毁” 之前！！！
    // 移除 “network3通知”
    [[NSNotificationCenter defaultCenter] removeObserver:wm name:@"network3" object:nil];
    // 移除 “wm所有监听的通知”
    [[NSNotificationCenter defaultCenter] removeObserver:wm];
    /// 常见通知
    /**
     UIDevice对象不间断发布以下通知
     1.UIDeviceOrientationDidChangeNotification - 设备旋转
     2.UIDeviceBatteryStateDidChangeNotification - 电池状态改变
     3.UIDeviceBatteryLevelDidChangeNotification - 电池电量改变
     4.UIDeviceProximityStateDidChangeNotification - 近距离传感器
     */
     /**
      // 键盘对象会发布以下通知
      1.UIKeyboardWillShowNotification - 键盘即将显示
      2.UIKeyboardDidShowNotification - 键盘显示完毕
      3.UIKeyboardWillHideNotification - 键盘即将隐藏
      4.UIKeyboardDidHideNotification - 键盘隐藏完毕
      5.UIKeyboardDidChangeFrameNotification - 键盘的位置尺寸即将发生改变
      6.UIKeyboardWillChangeFrameNotification - 键盘的位置尺寸改变完毕
      // 系统会附带一些额外信息
      1.UIKeyboardFrameBeginUserInfoKey - 键盘刚开始的 frame
      2.UIKeyboardFrameEndUserInfoKey - 键盘最终的 frame
      3.UIKeyboardAnimationDurationUserInfoKey - 键盘动画的时间
      4.UIKeyboardAnimationCurveUserInfoKey - 键盘动画的执行节奏/快慢
      */
}


#pragma mark - KVC/KVO
// https://www.jianshu.com/p/742b4b248da9
// 1>.KVC - Key Value Coding/键值编码
// 间接访问属性的方法
-(void)showKVC {
    // 1.常规赋值
    WMGameProxy *wm = [[WMGameProxy alloc]init];
    wm.publishName = @"谢吴军";
    wm.publishAge = 18;
    // 常规赋值的也可以使用KVC取到值
    NSLog(@"%@",[wm valueForKeyPath:@"publishName"]);
    // model -> NSDictionary
    NSDictionary *dict = [wm dictionaryWithValuesForKeys:@[@"publishName", @"publishAge"]];
    NSLog(@"%@", dict);
    // 可以取出“数组”中所有对象的某个属性
    NSArray *array = @[wm, wm, wm];
    NSArray *arrayPublishName = [array valueForKeyPath:@"publishName"];
    NSLog(@"%@", arrayPublishName);
    
    // 2.KVC赋值
    // key属性值千万不能写错、不然会崩溃
    [wm setValue:@"谢吴军" forKey:@"publishName"];
    // KVC可以自动类型转换
    // 对于“网络请求”十分有用（我们不用特别关注后台返回的数据类型/只用保证key一致即可）
    [wm setValue:@"18" forKey:@"publishAge"];
    NSLog(@"%@===%ld", wm.publishName, (long)wm.publishAge);
    // ‘forKeyPath’包含‘forKey’的功能/尽量使用‘forKeyPath’
    // ‘forKeyPath’进行内部的点语法可以层层访问内部的属性
    // “key”必须在“属性”中找到，不然会崩溃
    [wm.item setValue:@"小陈" forKey:@"name"];
    [wm setValue:@"小陈" forKeyPath:@"item.name"];
    
    // 3.给数组赋值
    [[wm mutableSetValueForKeyPath:@"dateArray"] addObject:@"xwj"];
    [[wm mutableSetValueForKeyPath:@"dateArray"] removeObject:@"xwj"];
    
    // 4.使用KVC给私有属性赋值
    // nbplus
    // 两种方式都可以
    [wm setValue:@"88" forKeyPath:@"_gameCount"];
    [wm setValue:@"88" forKeyPath:@"gameCount"];
    
    /**
     KVC的底层原理/可以通过重写“set方法”做一些操作
     1.查看当前key值的set方法，如果有set方法就会调用set方法，给对应的属性赋值
     2.如果没有set方法就会去查看是否有与key值相同并且带有下划线的成员属性，给对应的属性赋值
     3.如果没有与key值相同并且带有下划线的成员属性，就会去查看有没有与key值相同名称的成员属性，给对应的属性赋值
     4.如果还是没有找到会调用“- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key”/默认抛出异常
     */
}
// 2>.KVO - Key Value Observing/键值监听
// 监听某个对象的属性变化
/**
 ！！！可以监听“系统类（比如UIScrollView/UITableView）”的一些属性去做一些特定操作！！！
 比如有contentOffset
 */
-(void)showKVO {
    WMGameProxy *wm = [WMGameProxy new];
    // 1.先绑定监听器
    /**
     给"对象wm/被观察者"绑定一个监听器（观察者）
     第一个参数 - 观察者
     第二个参数 - 需要监听的属性
     第三个参数 - 选项
     第四个参数 - nil
     */
    [wm addObserver:self forKeyPath:@"publishName" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    // 2.再修改属性值
    wm.publishName = @"wj";
    wm.publishName = @"fj";
    // 3.移除监听/一般写在“dealloc方法”
    // 现在可以不再写
    [wm removeObserver:self forKeyPath:@"publishName"];
}
/**
 当监听的属性值发生改变调用
 @param keyPath - 要改变的属性/publishName
 @param object - 要改变的属性所属的对象/wm地址
 @param change - 改变的内容/NSDictionary/change[NSKeyValueChangeNewKey]/change[NSKeyValueChangeOldKey]
 @param context - 上下文
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}


#pragma mark - 懒加载
// 0>.概念 - 在开发中程序启动的时候不加载资源，只有在运行中有需要的时候再去加载资源
// 1>.格式 - 重写"getter方法"/如果为空加载数据/如果不为空直接返回数据
// 2>.特点 - 用到的时候再加载/全局只会被加载一次/全局都可以使用
/**
 3>.懒加载的好处：
 1.不用将创建对象的代码写在“viewDidLoad()”中，代码的可读性更强
 2.每个属性的“getter方法”分别负责各自的实例化处理，只有真正需要资源的时候才会加载，节省了内存
 */
// 4>.说一说懒加载的例子？- XXX
- (NSArray *)dataArray {
    // 不能使用self（会导致死循环）
    if (_dataArray == nil) {
        _dataArray = @[@"", @"", @""];
    }
    return _dataArray;
}


#pragma mark - 富文本
-(void)showAttribute {
    
}


#pragma mark - UIApplication
// 1.UIApplication对象是应用程序的象征
// 2.iOS程序启动以后创建的第一个对象就是UIApplication对象
// https://www.cnblogs.com/wendingding/p/3766347.html
- (void)showApplication {
    // 每个应用程序都有自己的UIApplication对象（单例）
    // 获取UIApplication对象
    UIApplication *app = [UIApplication sharedApplication];
//    // 不可以手动创建
//    UIApplication *app_01 = [[UIApplication alloc]init]; // 报错（？？？怎么模拟该写法？？？）
    // 1>.设置“App图标”右上角的红色提醒数字
    // 之前必须注册用户通知
    // 会弹出“是否允许通知”弹窗
    UIUserNotificationSettings *notice = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [app registerUserNotificationSettings:notice];
    app.applicationIconBadgeNumber = 400;
    // 2>.设置联网指示器的可见性
    // 状态栏会出现一个"菊花"
    app.networkActivityIndicatorVisible = YES;
    // 3>.屏幕常亮不变暗
    app.idleTimerDisabled = YES;
    // 4>.设置状态栏
    // iOS7.0以后系统提供2种管理状态栏的方法
    // 1.通过UIViewController管理：每个UIViewController可以拥有自己不同的状态栏
    // 2.通过UIApplication管理：一个App的状态栏统一管理
    // 默认通过“方法1”管理状态栏
    // 如果使用“方法2”需要配置info.plist文件
    // 参考 - https://www.jianshu.com/p/52300d0df3e5
    app.statusBarHidden = YES;
    app.statusBarStyle = UIStatusBarStyleLightContent;
    // 5>.打开其他App
    [app openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    // 6>.打电话
    [app openURL:[NSURL URLWithString:@"tel://15601749931"]];
    // 7>.发短信
    [app openURL:[NSURL URLWithString:@"sms://15601749931@163.com"]];
    // 8>.App很容易受到外界（来电、锁屏）干扰
    // 当App受到干扰的时候会产生一些系统事件（AppDelegate）
}
// 3.隐藏状态栏
/// 方法一、通过UIViewController管理状态栏(每个VC都拥有自己不同的状态栏)
// 状态栏样式
// UIStatusBarStyleDarkContent黑色
// UIStatusBarStyleLightContent白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
// 是否隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}
/**
 方法二、通过UIApplication管理状态栏(app状态栏统一管理)
 不让VC管理状态栏 - 修改 info.plist（View controller-based status bar appearance，设置为NO）
 [UIApplication sharedApplication].statusBarHidden = YES;
 [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
 */

#pragma mark - UIDevice
// [UIDevice currentDevice]代表设备，通过它可以获取一些设置相关信息
// 如果需要获取设备的硬件信息 - 可以百度
// 私有api - 不能在头文件中找到的api/不能上架App store
-(void)showDevice {
    // 当前设置的 “系统版本”
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 9.0) {
        NSLog(@"系统版本大于等于9.0");
    }
    [[UIDevice currentDevice] localizedModel]; // 什么设备
    [[UIDevice currentDevice] systemName]; // 系统名称
    [[UIDevice currentDevice] systemVersion]; // 系统版本号
    /// 近距离感应
    // 打开红外线开关
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAction:) name:UIDeviceProximityStateDidChangeNotification object:nil];
}
- (void)changeAction:(NSNotification *)notification {
    if([[UIDevice currentDevice] proximityState]) {
        NSLog(@"靠近");
    } else {
        NSLog(@"远离");
    }
}


#pragma mark - 程序崩溃
// NSException
-(void)showException {
    // 新建异常
    NSException * exception = [NSException exceptionWithName:@"异常名称" reason:@"异常原因" userInfo:nil];
    // 抛出异常
    // 就会崩溃
    [exception raise];
}


#pragma mark - 架构思想
/// 1.MVC
// 1>.概念
// MVC是一种设计思想，贯穿整个iOS开发中；
// 2>.作用
// Model数据改变View的显示状态也需要随之改变；
// View视图上面显示什么取决于Model；
// Controller负责初始化Model，将Model传递给View；
// 3>.宗旨
// Model数据和View视图一一对应，以Model数据驱动View视图/防止发生复用；
/// 2.MVP
/// 3.MVVM


#pragma mark - 真机调试/打包测试
- (void)showTrueDevice {
    /**
     为什么需要真机调试？
     1.真机和模拟器的环境（内存环境、网络环境）存在差异
     2.传感器不能再模拟器上使用
     3.打电话、发短信、拍照、LBS、蓝牙等功能均不能再模拟器上使用
     */
    // Xcode7.0以后只要 “Apple ID” 就可以自动生成对应证书进行 “真机调试”
    /**
    // 获取一台设备唯一标识的方法有哪些方法？
    // https://www.jianshu.com/p/0dce89cdf9f6
    IDFA - 广告标示符/一般可以保证唯一/只要关闭“限制广告追踪”功能再次打开就会不一样
    IDFV - Vindor标示符/同一个厂商在同一个设备上的不同App返回一样/如果把App删除再次安装会改变
    UUID - 通用唯一标识符/每次输出都不一样/利用UUID + keychain唯一确定设备
    UDID - 唯一设备标识符/真机调试、App上架需要使用/苹果在iOS 5.0被禁止获取
    */
    /**
     1.限制人
     1>.免费申请Apple ID
     2>.加入开发者计划
     3>.个人账号/公司账号（99美元/688元人民币）（个人账号申请简单快捷/公司账号申请必须要"邓白氏编码"）/个人账号申请大概3天/公司账号申请大概30天/个人账号必须使用账号和密码才可以使用（不能创建和管理团队）/公司账号可以创建和管理团队（加入用户、删除用户）
     4>.企业账号 - 299美元/App针对某一个特定人群使用，无需上架AppStore/可以创建和管理团队（加入用户、删除用户）/需要"邓白氏编码"/不能上架AppStore
     5>.申请“邓白氏编码” - 直接与苹果客服MM询问
     */
    // tips - 如果看不懂英文可以直接在网址后面加一个/cn
    /**
     2.限制电脑
     1>.需要使用真机调试的电脑生成CSR文件（证书签名请求文件 - 可以唯一识别不同的电脑）
     2>.真机调试证书最多只能够配置2个/
     3>.不要删除别人的证书 - 别人电脑生成的证书（.cer文件是身份证）我这边不能直接下载使用（如果需要使用必须让别人生成.p12文件（.p12是复印件）给我）
     */
    /**
     3.限制App
     1>.根据bundle ID区分App - bundle ID使用通配符会导致很多App服务（push/iap）无法使用
     2>.新建App ID - Explicit App ID（确定的App ID）/Wildcard App ID（模糊的App ID）- 不可以使用push/iap
     */
    /**
     4.限制真机设备
     1>.根据UDID区分手机 - 禁止代码获取
     2>.添加设备 - 最多添加100次（不是100台）/每年有一次机会删除设备
     关键字 - Reset your device list before adding any new devices.   Get Started
     勾选 - 不需要的设备 -> 删除不需要的设备 -> 保存
     3>.项目的最低部署版本 < 真机设备系统版本
     */
    // 生成描述文件（Provisioning Profiles） - 登录账号 + 证书 + App ID + UDID
    // 描述文件位置 - 点击Finder -> 前往 -> 资源库 -> MobileDevice/Provisioning Profiles
    // /Users/xiewujun/Library/MobileDevice/Provisioning/Profiles
    // 此证书签发者无效 - 不能导出ipa
    // 打包测试：设备选择“Any iOS Device” -> Product -> Archive
    // 导出ipa：Window -> Organizer
}


#pragma mark - 应用发布
-(void)publishApplication {
    // 1.真机调试/打包测试
    
    // 2.TestFlight
    
    // 3.广告植入
    
    // 4.企业包
    
    // 5.上架AppStore
}


#pragma mark - 静态库
/**
 静态库
 1.库 - 程序代码的集合/共享程序代码的一种方式
 2.开源库 - 公开源代码的库/ MJRefresh/ AFNetworking
 3.闭源库 - 不公开源代码的库/经过编译后的二进制文件/静态库和动态库都是闭源库
 4.静态库 - xxx.a/ xxx.framework
 5.动态库 - xxx.dylib/ xxx.framework
 */
/**
 静态库和动态库的区别？
 1.静态库 - 链接的时候会被完整的复制到可执行文件中，被多次使用就会复制多次
 2.动态库 - 不会复制（只有一份）/程序运行的时动态加载到内存/系统只加载一次
 ！！！项目中如果使用到动态库不允许上架！！！
 ！！！MRC的项目打包成静态库可以在ARC下直接使用！！！
 ！！！静态库解决不了第三方库的重复代码问题、动态库可以！！！
 */
/**
 iOS设备架构
 1>.模拟器
 4s-5 //i386
 5s-6splus //x86_64
 2>.真机
 3gs-4s //armv7
 5/5c //armv7s(armv7兼容armv7s)
 5s-6splus //arm64
 3>.查看 xxx.a/xxx.framework 支持哪些架构
 cd ~/xxx（包含xxx.a/xxx.framework的文件夹）
 lipo -info xxx.a/xxx.framework
 4>.支持编译所有架构设置 - Build Settings-Build Active Architecture Only设置为NO
 5>.合并支持模拟器的.a/支持真机的.a
 lipo -create xxx.a路径 yyy.a路径 -output zzz.a
 */
/**
 打包 xxx.a 的静态库 - https://www.jianshu.com/p/a1dc024a8a15
 */
/**
 xxx.a和xxx.framework的区别？
 1.xxx.a - 纯二进制文件/不可以直接使用（需要xxx.h配合）/ .a + .h + sourceFile = .framework
 2.xxx.framework - 除二进制文件还有资源文件/可以直接使用/建议使用
 */
// 如果导入过多头文件建议使用主头文件
// MRC项目下的静态库打包以后可以在ARC项目下直接使用（不需要加-fno-objc-arc）


#pragma mark - 内购
/**
 1.基本概念
 1>.概念 - Apple规定如果你在App中销售的商品与App的功能相关就必须使用内购方式购买
 2>.缺点 - 对于商家而言（苹果分成3成）/对于用户而言（第一次使用必须绑定银行卡）/内购商品的价格不能自定义
 3>.开发者创收模式 - 下载收费/广告/内购
 4>.注意 - 如果销售的商品应该使用内购而开发者没有使用内购会被拒绝上架
 2.流程
 1>.商户（App）告诉商场（苹果）你需要卖什么东西 - 去苹果开发者后台创建商品
 2>.商户（App）需要进货（从自己服务器下载）/验证进货商品是否为“第1步”注册的可以销售的商品 - 需要代码操作
 3>.顾客（用户）去商户（App）购买一个商品/商户（App）会给你开一个小票（订单号）
 4>.顾客（用户）拿着小票（订单号）去商场（苹果）付款
 3.App内购类型 - 必须先同意协议（不然只会出现"免费订阅"一个选项）
 1>.消耗性项目 - 对于消耗性App内购买项目，用户每次下载的时候都必须购买
 2>.非消耗性项目 - 对于非消耗性App内购买项目，用户仅需要购买一次（永远都在）
 3>.自动续订订阅 - 用于iBook/目前国内主要用于视频会员服务/https://www.jishudog.com/17214/html
 4>.免费订阅 - 用于iBook
 5>.非续订订阅 - 用于iBook
 */
// https://blog.csdn.net/xiaoxiangzhu660810/article/details/17434907#0-qzone-1-51422-d020d2d2a4e8d1a374a433f596ad1440
// 创建App -> （必须先同意协议）点击"功能"（配置计费点）-> 写代码 -> 配置沙盒账号（用户与协议）
-(void)storeKit {
    // 1.从我们自己的服务器获取需要销售的商品
    NSArray * productIds = @[@"com.shiyi.zidan", @"com.shiyi.jiguanqiang", @"com.shiyi.yifu"];
    // 2.拿到需要销售的商品到苹果服务器进行验证
    // 1>.创建商品请求 - 哪些商品可以真正被销售
    NSSet *set = [NSSet setWithArray:@[productIds.firstObject]];
    SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:set];
    // 2>.设置代理 - 接收可以被销售的商品列表
    request.delegate = self;
    // 3>.发送请求
    [request start];
}
/**
 request - 我们传过去的
 response - 返回的数据
 */
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    // 当请求完毕执行该代理
    // request - 是我们发起的
    // response - 苹果返回数据
    /**
     products - 可以被销售的商品 / SKProduct
     invalidProductIdentifiers - 无效的商品ID  / NSString
     */
    NSLog(@"可以被销售的商品%@===无效的商品ID%@", response.products, response.invalidProductIdentifiers);
    NSLog(@"基本描述：%@", response.products.firstObject.description);
    NSLog(@"商品ID：%@", response.products.firstObject.productIdentifier);
    NSLog(@"地区编码：%@", response.products.firstObject.priceLocale.localeIdentifier);
    // 根据什么判断的当地指什么地方？- 根据AppleID账号地区确定
    // 最低6元/最高6498元
    NSLog(@"本地价格：%@", response.products.firstObject.price);
    NSLog(@"本地标题：%@", response.products.firstObject.localizedTitle);
    NSLog(@"本地描述：%@", response.products.firstObject.localizedDescription);
    NSLog(@"语言代码：%@", [response.products.firstObject.priceLocale objectForKey:NSLocaleLanguageCode]);
    NSLog(@"国家代码：%@", [response.products.firstObject.priceLocale objectForKey:NSLocaleCountryCode]);
    NSLog(@"货币代码：%@", [response.products.firstObject.priceLocale objectForKey:NSLocaleCurrencyCode]);
    NSLog(@"货币符号：%@", [response.products.firstObject.priceLocale objectForKey:NSLocaleCurrencySymbol]);
    
    if ([SKPaymentQueue canMakePayments]) {
        // 3.购买商品
        // 1.取出需要购买的商品
        SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:response.products.firstObject];
        // 2.添加到支付队列，开始进行购买操作
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        // 3.交易队列的监听
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    } else {
        // 不支持购买
    }
//    // 恢复购买
//    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    // 当交易队列中添加的每一笔交易状态发生改变的时候调用
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing: {
                // 正在支付
            }
                break;
            case SKPaymentTransactionStatePurchased: {
                // 支付成功
                // 移除交易队列
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateFailed: {
                // 支付失败
                // 移除交易队列
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateRestored: {
                // 恢复购买
                // 移除交易队列
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateDeferred: {
                // 延迟处理
            }
        }
    }
}


#pragma mark - 内存分析
// https://www.jianshu.com/p/92cd90e65d4c
/**
 1.静态内存分析/ Product->Analyze
 1>.概念 - 不运行程序直接对代码进行分析/根据代码的上下文的语法结构来分析内存状况
 2>.作用 - 1.逻辑错误（访问未初始化的变量/野指针错误）2.声明错误（从未使用过的对象）3.内存管理错误（内存泄漏）
 3>.缺点 - 测试可能不准确
 */
//// 测试可能不准确
//-(void)staticAnalyze {
//    NSObject *obj = [self getObjc];
//    [obj release];
//}
//-(NSObject *)getObjc {
//    return [[NSObject alloc]init];
//}
/**
 2.动态内存分析 - 程序运行的时候通过 Product->Profile->Instruments 动态查看内存情况
 */


#pragma mark - SEL
-(void)setSEL {
    /**
     1.SEL - 代表着方法的签名/每个方法都有一个与之对应的“SEL类型”的对象
     responds - 实现
     perform - 执行
     */
//    /**
//     2.方法调用原理
//     1>.把 “test方法” 包装成 “sel类型的数据”
//     2>.根据SEL数据到该类的类对象上去找，如果找到就执行该代码
//     3>.如果没有找到根据类对象上的父类的类对象指针去父类的类对象找，如果找到就执行该代码
//     4>.如果没有找到就一直向上找直到基类（NSObject）
//     5>.如果都没有找到就会报错
//     */
//    // 会有缓存（对性能消耗有限）
//    [p test];
    SEL sel = @selector(setAge:);
    // NSSelectorFromString(@"test:") - 把NSString转换成SEL
    WMGameProxy *wm = [WMGameProxy new];
    // 3.判断wm有没有实现“-(void)setAge:(int)age;对象方法”（对象调用）
    if ([wm respondsToSelector:sel]) {
    }
    // 4.判断WMGameProxy有没有实现”+(void)setAge:(int)age;类方法“（类调用）
    if ([WMGameProxy respondsToSelector:sel]) {
    }
    // ARC的条件下，使用选择器很可能会报警/参照该方式去除报警
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    // 5.调用“SEL包装的方法”
    // NSSelectorFromString(@"test:") - 把NSString转换成SEL
    [wm performSelector:NSSelectorFromString(@"test:")];
    /**
            sel - 方法
            10 - 方法参数/必须是一个对象（不能是普通数据类型）
     */
    [wm performSelector:sel withObject:@"10"];
    // 最多传递2个参数（多个参数只能传递dict）
    [wm performSelector:@selector(sendMsg:number:) withObject:@"谢谢你" withObject:@"15601749931"];
    #pragma clang diagnostic pop
    // 6.作为函数形参 - 在函数内部操作“SEL类型”
}


#pragma mark - ！！！以下内容不属于任何知识点！！！
/// 协议 protocol 一般是用来增加类方法
-(void)showProtocol {
#warning - 代码过几天补充
    MainController *controller = [[MainController alloc]init];
    // 必须实现方法
    [controller jumpPage:@""];
    // 可选方法
    if ([self respondsToSelector:@selector(finishTask:)]) {
        [controller finishTask:self];
    }
}
/// id动态类型
// 可以调用任何方法（包括私有方法）
-(void)dynamic {
    id obj = [WMGameProxy new];
    // 这样可以避免调用方法出现崩溃
    if ([obj isKindOfClass:[WMGameProxy class]]) {
        [obj loginWithGameId:@"" GameKey:@""];
    }
}
/// 逆序一个字符串
-(NSString *)reverseWord:(NSString *)word Oprater:(NSString *)oprater {
    NSArray *array = [word componentsSeparatedByString:oprater];
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSString *str in [array reverseObjectEnumerator]) {
        [mArray addObject:str];
    }
    return [mArray componentsJoinedByString:oprater];
}
/**
 问题 - 怎么研究新特性？- 使用新Xcode创建项目，用旧Xcode去打开
 泛型 - 1.限制类型；2.提高代码规范；3.迎合swift
 类型 <限制类型>
 最大作用 - 限制集合类型
 https://blog.csdn.net/imkata/article/details/78859482
 __covariant协变/子类转父类
 __contravariant逆变/父类转子类
 */
// 自定义泛型
-(void)showObj {
    WMGameProxy<NSString *> *wm = [WMGameProxy new];
    wm.obj = @"哈哈";
}
// 注意 - 在数组中，一般用可变数组添加方法泛型才会生效，如果使用不可变数组，泛型没有效果


#pragma mark - LLDB
-(void)showLLDB {
    
}


#pragma mark - metal
-(void)showMetal {
    
}


#pragma mark - 系统相关
- (void)dealloc {
    [super dealloc];
    // 对象销毁之前自动调用该方法
}
- (void)didReceiveMemoryWarning {
    // 系统调用
    // 当控制器接收到内存警告调用
    // 去掉一些"不必要/耗时"的内存
}

@end
