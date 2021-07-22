// https://www.yiibai.com/dart/dart_programming_data_types.html

// dart语言简介
// 1>.dart语言是一个由Google开发的通用编程语言。后来被Ecma（Ecma-408）批准为标准。用于构建web/服务器/桌面/移动应用
// 2>.dart语言是一种面向对象的，类定义的，垃圾回收语言。使用C样式语法可以随意地转换成js
// 3>.dart语言支持接口/mixin/抽象类/具体化泛型/静态类型

// dart语言特性
// 1>.dart语言中一切（无论变量、数字、函数、null）皆对象，所有对象都是Object类的子类
// 2>.dart语言是强类型语言（一旦确定类型就不可以改变变量类型，编译的时候会进行语法检查）/Dart语言允许弱类型语言式的编程
// 3>.dart语言在运行前解析（指定数据类型和编译时常量）可以提高运行速度
// 4>.dart语言的统一入口是main函数
// 5>.dart语言的私有特性是在变量名或者函数名前面加上"_"
// 6>.dart支持async/await异步处理

// dart语言类型系统
// 1>.dart语言是类型安全的（dart语言使用静态类型检查和动态类型检查以确保变量的值总是与变量的静态类型匹配）
// 2>.dart语言中类型声明是可选的（因为会在编译时执行类型推导）
// 3>.num/double/int/String/List/Set/bool/Map/Object/dymamic/Function(/Symbol/runes)
// 4>.dart语言中所有的类型都是对象（都继承自Object类）/在dart语言中null类型也继承自Object类

/*
文件导入
1>.import 'xxx' - 全部导入
2>.import 'xxx' show yyy - 部分导入 - 只导入yyy
3>.import 'xxx' hide yyy - 部分导入 - 除yyy导入其他
4>.import 'xxx' deferred as yyy - 延迟导入yyy
 */
import 'dart:collection';

// import 'package:flutter/cupertino.dart';

// shift + command + F --> 全局搜索
class Demo {
  // 标识符 - dart语言规定必须以'字母/下划线'开头，只能包含'字母/下划线/数字/$'
  // 1>.严格区分大小写
  // 2>.标识符的定义与'其他语言'默认保持一致
  var msg = 'msg是一个标识符';

  // 语句结束
  // 1>.dart语言规定语句必须以';'结束
  var a1 = 10;
//  // 报错 - 必须以';'结束
//  var a2 = 5

  // 注释 - dart语言'注释'分为两种
  // 1>.'// 单行注释'
  // 2>./* 多行注释 */

  // 输出语句
  void log() {
    print('hello world');
  }

  // 数据类型
  void numType() {
    // 一、数字类型 - 整数可以转换成双精度浮点数
    int a = 1; // int - 表示任意大小的整数
    double b = 2.00; // double - 表示小数
    num sum = 0.01; // num - 表示int/double的父类
    // int s = 0.1;  // 不要把小数分配给整数（会抛出异常）
    print(sum);

    // 二、字符串 - 可以使用''/""
    // dart语言中字符串是不可变的
    String c = '这是一个字符串';
    String d = '这也是一个字符串';
    // 虽然字符串不可变但是可以操作字符串返回新的字符串
    String c1 = c.trim(); // 删除字符串前后的空格
    List list = c1.split(','); // 分割字符串返回List
    c.substring(1, 5); // 分割字符串(从0开始，包含1，不包含5)
    c1.toLowerCase(); // 将字符串全部小写
    c1.toUpperCase(); // 将字符串全部大写
    print(list);
    // 1>.字符串 -> 数字
    int e = int.parse(c);
    double f = double.parse(d);
    // 2>.数字 -> 字符串
    String g = a.toString();
    String h = b.toString();
    String numString = sum.toString();
    // 3>.拼接字符串/万能拼接'${xxx}'
    String h1 = '${2 + 2}'; // ${表达式}
    String i = '${'wy'}'; // 万能拼接
    String j = '$h1$i$e$f$g$h$numString'; // 如果是拼接标识符可以省略'{}'
    String k = i + j; // 如果是两个字符串拼接可以直接使用‘+’
    // 4>.创建多行语句
    String l = '''
    你好，
    China
    ''';
    print(l);

    // 三、布尔类型 - 没有非零既真/必须有明确的真假
    assert(k.isEmpty); // 检查是否是空字符串
    assert(e == 0); // 检查零值
    var hitTest;
    assert(hitTest == null); // 检查是否为null
    bool varName = true;
    if (varName) {
      varName = false;
    } else {
      print('走到这里');
    }

    // 四、数组List - 有序
    // var goodList = <String>[];  // 推荐使用
    // 1>.固定长度列表 - 默认已经指定长度/长度不能在运行时更改
    var listName = new List(3);
    listName[0] = 1;
    listName[1] = 2;
    listName[2] = 3;
    // 2>.可增长列表 - 默认没有指定长度/长度能在运行时更改
    // 创建一个空List
    var listM = new List();
    listM.add(1);
    listM.first;
    // 创建一个有值List
    var firstList = [1, 2, 3];
    firstList.length; // List长度
    if (firstList.length > 1) {
      var _ = firstList[1]; // 获取List第2个元素
      firstList.add(1); // 添加元素
      firstList.first; // 返回第一个元素
      if (firstList.isEmpty) {
        print('firstList是空的');
      }
      firstList.removeLast(); // 删除最后一个元素
      firstList.removeAt(2); // 删除第3个元素
      firstList.reversed; // List逆序
    }

    // 五、集合Set - 无序
    // 集合元素不能相同？？？
    var oneSet = {'123', '1234', '1235'}; // 创建非空Set不需要指定类型
    var emptySet = <String>{}; // 创建空Set需要指定类型
    oneSet.length; // 获取集合长度
    emptySet.add('12345'); // 添加元素
    oneSet.addAll(emptySet); // 将emptySet中的元素添加到set中（不是把emptySet添加到set中）
    // 遍历集合
    oneSet.forEach((element) {
      print('$element');
    });
    // 补集 - 存在于set1中 & 不存在于set2中
    var difference = oneSet.difference(emptySet);
    print(difference);
    // 交集 - 存在于set1中 & 存在于set2中
    var intersection = oneSet.intersection(emptySet);
    print(intersection);
    // 并集 - 存在于set1中 || 存在于set2中
    var union = oneSet.union(emptySet);
    print(union);

    // 六、映射 - Map对象
    // var goodMap = <String, Object>{};  // 推荐使用
    // dart语言中规定 - 映射中的键值对都可以是任何类型
    // 映射可以在运行时增长和缩小
    // 1>.第一种创建方式
    var gifts = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
    // 获取映射中的value
    assert(gifts['key1'] == 'value1');
    // 获取映射中的value，如果获取不到直接返回null
    assert(gifts['key4'] == null);
    gifts.length; // 返回映射中键值对的个数
    // 2>.第二种创建方式
    // 创建赋值 - 不推荐使用
    var giftMaps = new Map();
    giftMaps['key1'] = 'value1';
    giftMaps['key2'] = 'value2';
    giftMaps['key3'] = 'value3';
    // 修改
    giftMaps['key1'] = 'value11'; // 修改Map
    giftMaps['key4'] = 'value4'; // 添加map
    giftMaps.keys; // 返回所有的key
    giftMaps.values; // 返回所有的value
    giftMaps.length; // 返回map的长度
    giftMaps.clear(); // 删除map中所有的键值对
    // 3>.新建常量映射
    final map = const {1: 'value1', 2: 'value2', 3: 'value3'};
    print(map);
    // 4>.遍历映射
    giftMaps.forEach((key, value) {
      print('Key = $key, Value = $value');
    });

    // 七、符文 - UTF-32的代码点
    String.fromCharCode(1);

    // 八、符号Symbol - Symbol对象表示dart程序中声明的运算符或标识符
    // dart的符号是不透明的动态字符串的名称
    // 符号是一种存储人类可读字符串与优化供计算机使用的字符串之间关系的方法
    Symbol obj = new Symbol('f'); // f - 必须是有效的公共Dart成员名称，公共构造函数名称或库名称
    print(obj);
  }

  // 变量
  // 使用变量之前必须先声明变量/变量存储值的引用/dart语言支持类型检查
  // 注意 - dart语言一切皆对象/未初始化的变量默认为null（数字类型、布尔类型没有初始化都默认为null）
  /*
   * 问题 - var/Object/dynamic都可以声明变量，它们的区别是什么？
   * var - 如果没有初始化值可以变成任何类型/如果有初始化值声明的变量类型固定不能改变
   * Object - 动态任意类型/声明的变量类型可以改变/编译的时候会检查类型
   * dynamic/dai'na'mi'k - 动态任意类型/声明的变量类型可以改变/编译的时候不检查类型
   */
  void disVariable() {
    // 如果有初始化值声明的变量类型固定不能改变
    // 支持类型推导
    // 推荐使用
    var name = 'wy';

    // 动态任意类型/声明的变量类型可以改变/编译的时候会检查类型
    // 不推荐使用
    Object weight = '125';
    // weight = 123;   // 编译的时候会报错

    // 动态任意类型/声明的变量类型可以改变/编译的时候不检查类型
    // 类似oc种的id类型
    dynamic height = '180';
    // height = 170; // 编译不报错/运行报错 - 编译的时候不检查类型

    // 使用默认类型
    // 类似java
    String age = '18';

    print('$name 今年 $age 岁，体重 $weight 身高 $height');
  }

  // 常量 - 不可以修改/const、final关键字用于声明常量
  /*
  const - 表示编译期常量
  final - 表示运行期常量（应用更广泛）
   */
  void disConstant() {
    // 一、final和const的相同点
    // 1>.常量声明可以省略常量类型
    // final String m1 = 'wy';
    final m1 = 'wy';
    // const int n1 = 1;
    const n1 = 1;
    print('$m1 $n1');
    // 2>.常量初始化以后不能再次赋值
    // m1 = 'cfj';
    // n1 = 2;
    // 3>.不能与var一起使用
    // final var m2 = 'wy';
    // const var n2 = 2;
    // 二、final和const的区别
    // 1>.类级别常量使用static/const
    // 2>.const可以使用其他const常量的值来初始化其值
    const width = 100;
    const height = 200;
    const square = width * height;
    print(square);
    // 3>.相同的const常量不会在内存中重复存储
    // 4>.const修饰的不可变性是可以传递的（子类会继承）
    var list1 = const [1, 2, 3]; // list1数组可以修改/list1[x]元素不能修改
    const list2 = const [1, 2, 3]; // list1数组不能修改/list1[x]元素不能修改
    final list3 = const [1, 2, 3]; // list1数组不能修改/list1[x]元素不能修改
    print('$list1$list2$list3');
  }

  // 运算符
  void disOperator() {
    // 1>.基础运算符
    var m1 = 2;
    var m2 = 3;
    var result = (m1 & m2);
    result = (m1 | m2);
    result = (m1 ^ m2);
    result = (~m1);
    result = (m1 ~/ m2); // 取整 - 实际上就是商
    int sum = 2;
    String s = sum as String; // as表示’类型转换‘
    assert(sum is int); // is代表‘是否是’
    // ? - 可选类型
    // ?? - 与swift一致
    String msg;
    print(msg?.length);
    print('$result/$s');

    // 2>.条件语句
    if (m1 > m2) {
    } else {}
    switch (m1) {
      case 1:
        {}
        break;
      case 2:
        {}
        break;
      default:
        {}
    }
    // 3>.循环语句
    for (var i = 0; i < 1000; i++) {
      print('循环语句');
    }
    var list = [1, 2, 3, 4];
    for (var item in list) {
      print(item);
    }
    while (m1 < m2) {}
    do {} while (m1 < m2);
  }

  // 函数
  // 1>.概念 - 可读/可维护/可重用代码的代码块
  // 2>.注意点 - 函数也是对象/函数也是对象/函数也是对象
  // 3>.普通函数
  void disNormal(int a, int b, int c) {
    int result = a + b + c;
    print(result);
  }
  // 4>.可选参数
  // 1.可选位置参数（必须按照位置，如果需要指定c则不能省略b）
  int disSum(int a, [int b, int c]) {
    disNormal(1, 2, 3);
    return a + b + c;
  }
  // 2.带有默认值的可选位置参数
  int disDefault(int a, [int b = 1, int c = 2]) {
    disSum(1);
    return a + b + c;
  }
  // 3.可选命名参数 - 命名参数就是选填参数（不用考虑b和c的顺序）
  // 命名参数最好给默认值
  int disClick(int a, {int b = 1, int c = 1}) {
    disClick(1, b: 1, c: 2);
    return a + b + c;
  }
  // 5>.递归函数 - 自己调用自己
  // 6>.Lambda函数/lan'b'da - 函数块只有一条语句
  void single() => print('Lambda函数');
  // 7>.匿名函数 - 没有方法名/必须用var/final修饰
  /*
  两种形式
  1.() => xxx;
  2.() {

    };
   */
  void disMityFunction() {
    // (name) - 参数
    // print('$name') - 代码块
    var mName = (name) => print('$name'); // 有参匿名函数
    var sName = () => print(''); // 无参匿名函数
    // 8>.回调函数
    // 一个函数做为另一个函数参数
    // String - 函数返回类型/void可以省略
    // func - 函数名称/自定义 - 形参
    // string - 函数入参/自定义
    void sLogger(String func(name)) {
      func('1');
    }
    sLogger(mName);
    void state(String func()) {}
    state(sName);
    // 9>.函数别名/闭包 - 返回一个函数/函数也是一个对象
    Function makeAdd(int a, int b) {
      return (int y) => a + y;
    }
    // 接收一个函数
    var addFunc = makeAdd(10, 12);
    // 打印结果
    print(addFunc(12));
  }

  // 枚举 - 一种特殊的类
  void loginType() {
    var type = enumName.codeLoginType;
    switch (type) {
      case enumName.normalLoginType:
        {
          print('普通登录');
        }
        break;
      case enumName.phoneLoginType:
        {
          print('手机登录');
        }
        break;
      case enumName.codeLoginType:
        {
          print('验证码登录');
        }
        break;
    }

    // 时间处理
    // 1>.获取当前时间
    DateTime.now();
    // 2>.创建一个指定时间年月日的DateTime对象
    DateTime(2009, 03, 03);
    // 3>.解析日期字符串
    DateTime.parse('2019-03-02');
    // 4.解析时间戳
    DateTime.fromMillisecondsSinceEpoch(15516161200000);
  }

  // dart队列
  void disQueue() {
    Queue queue = new Queue();
    queue.addAll([12, 13, 14]);
    // 遍历
    Iterator iterator = queue.iterator;
    while (iterator.moveNext()) {
      print(iterator.current);
    }
  }

  // 包 - 封装一组编程单元的一种机制
  // App可能需要集成某些第三方库或插件 - 每种语言都会提供一种机制来管理外部软件包
  /*
  dart的软件包管理器是pub
  1.pub get - 获取App所依赖的所有包
  2.pub upgrade - 将所有依赖项升级到较新版本
  3.pub build - 用于构建您的Web应用程序
  4.pub help - 将提供所有pub命名帮助
   */
  // 下载第三方库：先在pubspec.yaml中写上需要下载的第三方库 -> 然后选中pubspec.yaml -> 最后Get Packages
  void disXml() {}

  // 3.异常处理 - 在执行程序期间出现问题
  // 特点 - 发生异常时程序的正常流程中断，程序会异常中止
  void disException() {
    // 第一种写法
    try {
      // 可能会导致异常的代码
      testAge(-2);
    } catch (e) {
      // 如果发生异常在这里处理
      CustomException exception = e;
      exception.msgError();
    } finally {
      // 可选 - 总是会执行这里
    }
    // 第二种写法
    try {
      // 可能会导致异常的代码
      testAge(-2);
    } on Exception {
      // 如果发生异常在这里处理
    } finally {
      // 可选 - 总是会执行这里
    }
  }

  // 2.抛出异常
  void testAge(int age) {
    if (age < 0) {
      // throw new FormatException();
      throw new CustomException();
    }
  }
  // 自定义异常 -> 抛出异常 -> 异常处理

  // dart调试 - 查找和修复错误的过程称为调试
}

// 1.自定义异常
class CustomException implements Exception {
  String msgError() => 'Amount should be greater than zero';
}

// 枚举 - 特殊的类，通常用来表示相同类型的一组常量
// 枚举不能被继承，不能创建实例
enum enumName { normalLoginType, phoneLoginType, codeLoginType }

// 类
// 1>.概述 - dart语言是一门面向对象的语言（支持面向对象编程）
// 2>.特点 - 封装、继承（dart不支持多继承，只支持多重继承/子类可以继承父类除构造函数以外的所有属性和函数）、多态
// 3>.新建类
class Test extends Demo {
  // 成员变量
  String name = 'wy';
  // 静态成员变量
  static int age = 12;
  // 私有成员变量（'_'表示私有）
  String _method;
  // 私有方法
  void _disAdd() {
    _method = 'wy';
    print(_method);
  }

  // setter方法
  set testName(String name) {
    this.name = name;
  }

  // getter方法
  String get testName {
    return this.name;
  }

  // 构造函数
  // // 1>.普通构造函数
  // Test() {
  //   print('');
  // }
  // 2>.命名构造函数
  Test.nameConst() {
    // this - 表示引用类的当前实例
    this.name = '';
  }
  // 3>.调用超类的构造函数
  // 使用“:”可以调用超类的构造方法
  Test() : super() {
    print('');
  }

  // 静态函数 - 需要类名调用
  static void disTest() {
    // 状态 - 描述对象
    // 行为 - 描述对象可以执行的操作
    // 标识 - 将对象与一组类似对象区分开来的唯一值
  }
  
  // 使用这些方法
  void disDemo() {
    // 0>.super - 直接调用父类方法
    super.disConstant();
    // 1>.实例化Test
    Test test = new Test();
    test = Test();
    test = new Test.nameConst();
    // 2>.调用成员变量
    test.name = 'xwj';
    // 3>.调用对象函数
    test.disDemo();
    test._disAdd();
    // 4.调用静态函数
    Test.disTest();
  }
}

// 抽象类和接口
abstract class Massage {
  void doMassage();
}

class FootMassage implements Massage {
  @override
  void doMassage() {
    print('脚底按摩');
  }
}

class BackMassage implements Massage {
  @override
  void doMassage() {
    print('背部按摩');
  }
}

// 异步操作 - https://blog.csdn.net/yuzhiqiang_1993/article/details/89155870
// 1>.因为flutter基于dart语言（在一个线程中运行）开发，因此flutter也是单线程模型
// 2>.flutter对异步的操作不能像'原生iOS开发'一样利用多线程处理（flutter怎么处理异步操作？）
// 3>.！！！flutter没有多线程的概念！！！
/*
Future对象 - 表示异步操作的结果/通常使用then()来处理返回结果
async - 表明函数是一个异步函数/返回类型是Future类型
await - 等待耗时操作的返回结果，这个操作会阻塞
 */
/*
1.首先判断‘getData()’函数是不是一个异步函数？如果是需要加上‘async’
2.因为加上‘async’，所以返回值为‘Future<T>’
3.‘await’表示需要等待耗时操作返回（阻塞）
 */
Future<String> getData() async {
  String msg = await getData().then((value) {
    // 接口返回数据
    // value == Future<String>
  }).whenComplete(() {
    // 异步任务处理完成
  }).catchError(() {
    // 出现异常
  });
  return msg;
}

// 跨平台解决方案
// 1>.Web/Hybrid - 基于web相关技术来实现界面和功能 - cordova
// 2>.jsCore - 通过JsCore桥接调用原生服务 - React Native/Weex
// 3>.Native - 将某个语言编译成二进制文件，生成动态库、打包成apk和iap - flutter

// 选择flutter的原因
// 1>.Web/Hybrid - UI性能差，功能性Api缺失
// 2>.RN - UI性能一般，开发体验差
// 3>.flutter - UI性能好，开发体验较好

// flutter概述
// 1>.概念 - flutter是google开发的移动UI框架。可以快速的在iOS/Android上构建高质量的原生用户界面
// 2>.特点 - flutter可以与现有的代码一起工作 ｜ flutter是完全免费、开源的
// 3>.兼容 - iOS/Android/wp/web
// 4>.组成 - Engine(C++) - Skia/Dart/Text ｜ Framework - Dart

// flutter详情
// 1>.dart语法编译 - dart是一种强类型、跨平台的客户端开发语言。具有专门为客户端优化、高生产力、快速高效、可移植易学的风格
// 2>.flutter插件 - dart语言无法直接调用Android系统提供的Java接口，需要使用flutter插件来实现中转
// 3>.Skia（siQ）图像处理引擎 - 2005年问世/用于Chrome浏览器/2007年被移植到Android平台
// 4>.开发电脑选择：mac(windows不能开发iOS)
// 5>.IDE选择：Android Studio > VsCode

// flutter环境搭建
/*
 一.flutter环境准备
 1>.打开官网https://flutter.io
 2>.点击Docs->点击Get Started->选择macOS
 3>.下载flutterSDK（以后flutter升级直接可以用命令行）
 4>.将下载完成的flutterSDK放在某个位置（例如 - /Applications/flutter）
 二、开始配置环境变量
 1>.vim ~/.bash_profile
 2>.写入以下语句
 '''
 // 配置环境变量
 export PATH=/Applications/flutter/bin:$PATH
 // 针对国内用户 - 设置Flutter临时镜像（随时可以会换）
 export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
 export PUB_HOSTED_URL=https://pub.flutter-io.cn
 '''
 3>.source ~/.bash_profile
 4>.flutter doctor #检测flutter环境
 5>.在iOS上配置环境 - 下载Xcode/安装git/安装CocoaPods
 6>.Android Studio - Preferences - Plugins(下载Dart插件/Flutter插件)
 */
// 注意点
// 1>.shift + command + p - 打开控制器面板
// 2>.运行flutter项目之前可以使用“flutter doctor”命令行检测一下
// 3>.？？？怎么升级flutterSDK？？？1.终端输入flutter upgrade/2.直接下载flutterSDK覆盖
// 4>.Using Flutter in China - https://flutter.dev/community/china
// 5>.VSCode新建项目命令 - xxx是项目名称，必须小写
// flutter create -i swift -a kotlin xxx
// 6>.将项目导入到AS
// 将flutter项目导入AS中会自动引导AS安装Dart插件/Flutter插件
// 7>.flutter run - 运行项目
// 8>.flutter run -d 'iphone X' - 利用iphone X运行项目

// flutter项目文件
/*
 * dream_flutter - projectName
 * .dart_tool - 工具包
 * .idea - 环境配置
 ** android - 安卓包工程文件
 * build - xxx
 ** ios - iOS包工程文件
 ** lib - 主要工程目录（dart源文件）/可以包含其他资源文件
 * test - 测试相关文件
 * .gitignore - 忽略文件
 * .metadata - 元信息
 * .packages - 包信息
 * donewflutter.iml - xxx
 * pubspec.lock - xxx
 ** pubspec.yaml - 项目依赖配置文件（很重要）
 * README.md - 相关介绍文档
 */

// flutter中怎么归档资源文件
// 1>.Android中将resources/assets区别对待/iOS中将images和assets区别对待
// 2>.flutter中认为所有的资源都会被作为assets对待
// 3>.flutter中的assets文件夹可以是任意文件夹（只要在pubspec.yaml中声明）
/*
assets:
# 这里只需要声明一个就行
- images/dm_main_logo.png
*/
/*
项目中怎么使用该图片
new Image.asset(images/dm_main_logo.png);
 */

// flutter中如何处理不同分辨率 - 与iOS一致遵循一个简单的基于像素密度的格式

// flutter中如何添加项目所需依赖
// 1>.在Android中可以使用Gradle文件来添加依赖项/在iOS中通常把依赖项添加到Podfile中
// 2>.flutter使用dart构建系统和pub包管理器来处理依赖
/*
dependencies:
  flutter:
    sdk: flutter
    google_sign_in: ^3.0.3
*/
/*
注意：
1.虽然flutter项目中的Android文件夹下有一个Gradle文件，但是只有在添加平台相关所需要的依赖关系时才使用这些文件。否则应该使用pubspec.yaml来声明用于flutter的外部依赖项
2.如果flutter项目中的iOS文件夹下有Podfile文件，但是只有在添加平台相关所需要的依赖关系时才使用这些文件。否则应该使用pubspec.yaml来声明用于flutter的外部依赖项
*/

/*第一个程序start*/
// import 'package:flutter/material.dart';  // 必须使用‘;’结尾

// // void main() => runApp(MyApp());  // 只有一行使用 =>
// void main() {
//   runApp(MyApp());
// }

// Flutter的基本项目代码
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // 属性以‘,’结尾
//       title: 'Welcome to Flutter',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Welcome to Flutter'),
//         ),
//         body: Center(
//           child: Text('Helllo World'),
//         ),
//       ),
//     );
//   }
// }

// /*
// r - 热更新
// p - 显示网格
// o - 切换安卓/iOS样式
// q - 退出
//  */
/*第一个程序end*/

// flutter打包
// 安卓打包 - flutter build apk
// iOS打包 - xxx

// /*组件学习start*/
// // flutter一切皆Widget
// import 'package:flutter/material.dart'; // 引入库

// void main() => runApp(
//     MyApp(items: new List<String>.generate(1000, (index) => 'Item $index')));

// /*
// StatelessWidget - 适用于当我们描述的用户界面不依赖于对象中的配置信息/死控件/不会随数据动态改变/无状态
// StatefulWidget - 动态更新UI/具有state对象存储状态数据并将其传递到树重建中/活控件/会随数据动态改变/有状态
// */
// class MyApp extends StatelessWidget {
//   // 1.声明一个List
//   final List<String> items;

//   MyApp({Key key, @required this.items}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // 层叠布局
//     var stack = new Stack(
//       // 0 - 1
//       // 只能相对于两个控件
//       alignment: const FractionalOffset(0, 1),
//       children: <Widget>[
//         new CircleAvatar(
//           backgroundImage: new NetworkImage('http://blogimages.jspang.com/blogtouxiang1.jpg'),
//           radius: 100.0,
//         ),
//         // new Container(
//         //   decoration: new BoxDecoration(
//         //     color: Colors.lightBlue
//         //   ),
//         //   padding: const EdgeInsets.all(10.0),
//         //   child: Text('jsPang 技术胖'),
//         // )
//         // 绝对布局 - 特别灵活
//         new Positioned(
//           child: new Text('jsPang'),
//           top: 10.0,
//           left: 10.0,
//         ),
//         new Positioned(
//           child: new Text('jsPang.com'),
//           right: 10.0,
//           bottom: 10.0,
//         ),
//       ],
//     );

//     // card布局
//     var card = new Card(
//       child: Column(
//         children: <Widget>[
//           ListTile(
//             title: Text(
//               'jspang',
//               style: TextStyle(fontWeight: FontWeight.w500)
//             ),
//             subtitle: Text('技术胖'),
//             leading: new Icon(Icons.accessibility,color:Colors.lightBlue)
//           ),
//           ListTile(
//             title: Text(
//               'jspang',
//               style: TextStyle(fontWeight: FontWeight.w500)
//             ),
//             subtitle: Text('技术胖'),
//             leading: new Icon(Icons.accessibility,color:Colors.lightBlue)
//           ),
//           ListTile(
//             title: Text(
//               'jspang',
//               style: TextStyle(fontWeight: FontWeight.w500)
//             ),
//             subtitle: Text('技术胖'),
//             leading: new Icon(Icons.accessibility,color:Colors.lightBlue)
//           ),
//         ],
//       ),
//     );

//     /*
//     * 命令式UI - 手动构建全功能UI实体，然后在UI更改时使用方法对其进行变更/在旧的上进行修改
//     * 声明式UI - widget会在自身上触发重建并构建一个新的widget子树/生成新的
//     * */
//     // widget具有不同性 - 每当widget状态发生改变的时候就会创建一个新的widget
//     // https://www.jianshu.com/p/88c66747eec1
//     return MaterialApp(
//       title: 'text widget',
//       // home的含义？？？
//       home: Scaffold(
//         // 导航栏
//         appBar: new AppBar(
//           title: new Text('Flutter Demo'),
//         ),
//         // // 页面 - 具体内容
//         // body: Center(
//         //   // // 1.Text - 类似UILabel
//         //   // child: Text(
//         //   //   // 文字
//         //   //   '这是谁？这是谁？这是谁？这是谁？这是谁？',
//         //   //   // 对其方式
//         //   //   textAlign: TextAlign.center,
//         //   //   // 最大行数
//         //   //   maxLines: 1,
//         //   //   // 字数过多溢出怎么处理
//         //   //   overflow: TextOverflow.clip,
//         //   //   // 字体样式
//         //   //   style: TextStyle(
//         //   //     // 字体大小
//         //   //     fontSize: 25.0,
//         //   //     // 字体颜色
//         //   //     color: Color.fromARGB(255, 255, 125, 125),
//         //   //     // 下划线
//         //   //     decoration: TextDecoration.underline,
//         //   //     // 下划线样式
//         //   //     decorationStyle: TextDecorationStyle.double,
//         //   //   ),
//         //   // ),

//         //   // // 2.Container - 类似div/UIView
//         //   // // 属性之间的‘,’不能减少/最后一个属性省略‘,’
//         //   // child: Container(
//         //   //   // 子widget
//         //   //   child: new Text('hello jsPang', style: TextStyle(fontSize: 40.0)),
//         //   //   // 文字在容器中的位置
//         //   //   alignment: Alignment.topLeft,
//         //   //   // 宽度
//         //   //   width: 350.0,
//         //   //   // 高度
//         //   //   height: 400.0,
//         //   //   // // 背景颜色
//         //   //   // color: Colors.red,
//         //   //   // 内边距 - 容器与容器子元素（文字/图片）之间的距离
//         //   //   padding: const EdgeInsets.fromLTRB(10, 15, 15, 10),
//         //   //   // 外边距 - 容器与父元素之间的距离
//         //   //   margin: const EdgeInsets.all(10.0),
//         //   //   // decoration - 装饰
//         //   //   decoration: new BoxDecoration(
//         //   //     // 渐变颜色 - 不能与“背景颜色”共存/会抛出异常
//         //   //     gradient: const LinearGradient(colors: [Colors.red, Colors.black, Colors.blue]),
//         //   //     border: Border.all(width:2.0, color: Colors.red),
//         //   //   ),
//         //   // )

//         //   // // 3.Image - 图片
//         //   // // Image.asset() - 项目图片（常用）
//         //   // // Image.file() - 本地图片
//         //   // // Image.memory() - 内存图片
//         //   // // Image.network() - 网络图片（常用）
//         //   // child: Container(
//         //   //   child: new Image.network(
//         //   //     // src - 资源路径
//         //   //     'https://pics3.baidu.com/feed/ca1349540923dd54c1589d6d977805d89c824807.jpeg?token=c818dc30edfcb1df8e619903be34b251',
//         //   //     /*
//         //   //     BoxFit.contain - xxx
//         //   //     BoxFit.fill - 填满/会变形
//         //   //     BoxFit.fitWidth - 横向按比例填满（竖向可能会超出）
//         //   //     BoxFit.fitHeight - 竖向按比例填满（横向可能会超出）
//         //   //     BoxFit.cover - 按比例填满
//         //   //     BoxFit.scaleDown - 不能改变原图大小
//         //   //      */
//         //   //     fit: BoxFit.cover,
//         //   //     // 图片混合颜色
//         //   //     color: Colors.greenAccent,
//         //   //     colorBlendMode: BlendMode.darken,
//         //   //     // 图片重复
//         //   //     // ImageRepeat.noRepeat - 不重复（默认）
//         //   //     // ImageRepeat.repeat - 重复（以中间为基础）
//         //   //     // ImageRepeat.repeatX - 横向重复
//         //   //     // ImageRepeat.repeatY - 竖向重复
//         //   //     repeat: ImageRepeat.repeatY,
//         //   //   ),
//         //   //   width: 300.0,
//         //   //   height: 300.0,
//         //   //   color: Colors.red
//         //   // ),
//         // ),

//         // 4.ListView
//         // 1>.静态ListView
//         // body: new ListView(
//         //   children: <Widget>[
//         //     // 第一种写法
//         //     // new ListTile(
//         //     //   leading: new Icon(Icons.perm_camera_mic),
//         //     //   title: new Text('perm_camera_mic'),
//         //     // ),
//         //     // new ListTile(
//         //     //   leading: new Icon(Icons.perm_contact_calendar),
//         //     //   title: new Text('perm_camera_mic'),
//         //     // ),
//         //     // new ListTile(
//         //     //   leading: new Icon(Icons.perm_data_setting),
//         //     //   title: new Text('perm_camera_mic'),
//         //     // ),
//         //     // // 第二种写法
//         //     // new Image.network('https://cms-dumall.cdn.bcebos.com/cms_com_upload_pro/dumall_1588149639781.jpg?x-bce-process=image/quality,q_100/format,f_auto/interlace,i_progressive'),
//         //     // new Image.network('https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3105985776,1507540069&fm=11&gp=0.jpg'),
//         //     // new Image.network('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1590391163768&di=4d4846387c0f24f310895a37c45ac1e2&imgtype=0&src=http%3A%2F%2Fimg1.cache.netease.com%2Fcatchpic%2F4%2F4A%2F4A8FF896FCBBF48048A13CE64024DE0E.jpg')
//         //     // new Image.asset(images/dm_main_logo.png);
//         //   ],
//         // ),

//         // // 2>.万物皆组件
//         // body: Center(
//         //   child: Container(
//         //     height: 200.0,
//         //     child: MyListView()
//         //   ),
//         // ),

//         // // 3>.动态列表
//         // body: new ListView.builder(
//         //   itemBuilder: (context, index) {
//         //     return new ListTile(
//         //       title: Text('$items[index]'),
//         //       onTap: (){
//         //         // 点击事件
//         //         print('');
//         //       },
//         //     );
//         //   },
//         //   itemCount: items.length,
//         // )

//         // // 5.GridView
//         // // 1>.静态GridView
//         // body: GridView.count(
//         //   // 1.内边距
//         //   padding: const EdgeInsets.all(20.0),
//         //   // 2.网格之间的间距（横轴）
//         //   crossAxisSpacing: 10.0,
//         //   // 3.网格之间的间距（竖轴）
//         //   mainAxisSpacing: 5.0,
//         //   // 4.宽/高
//         //   childAspectRatio: 2.0,
//         //   // 5.每行显示几个网格
//         //   crossAxisCount: 3,
//         //   // 6.共有几个网格
//         //   children: <Widget>[
//         //     const Text('I am JSpang'),
//         //     const Text('I am JSpang'),
//         //     const Text('I am JSpang'),
//         //     const Text('I am JSpang'),
//         //     const Text('I am JSpang'),
//         //     const Text('I am JSpang'),
//         //     const Text('I am JSpang'),
//         //   ],
//         // ),

//         // 布局
//         // 1>.水平布局 - Row
//         // body: new Row(
//         //   // 主轴对齐方法
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   // 副轴对齐方法
//         //   crossAxisAlignment: CrossAxisAlignment.end,
//         //   children: <Widget>[
//         //     // 灵活的布局
//         //     Expanded(child: new RaisedButton(
//         //       onPressed: (){},
//         //       color: Colors.red,
//         //       child: new Text('红色按钮'),
//         //       ),
//         //     ),
//         //     Expanded(child: new RaisedButton(
//         //       onPressed: (){},
//         //       color: Colors.blue,
//         //       child: new Text('蓝色按钮'),
//         //       ),
//         //     ),
//         //     Expanded(child: new RaisedButton(
//         //       onPressed: (){},
//         //       color: Colors.orange,
//         //       child: new Text('橙色按钮'),
//         //       ),
//         //     ),
//         //     Expanded(child: new RaisedButton(
//         //       onPressed: (){},
//         //       color: Colors.yellow,
//         //       child: new Text('黄色按钮'),
//         //       ),
//         //     ),
//         //   ],
//         // ),

//         // // 2>.垂直布局 - Column
//         // body: Center(
//         //   child: Column(
//         //     // 对齐方法
//         //     // 垂直布局 - 主轴就是垂直方法/副轴就是水平方法
//         //     crossAxisAlignment: CrossAxisAlignment.end,   // 相对与控件居中
//         //     mainAxisAlignment: MainAxisAlignment.center,  // 相对于屏幕
//         //     children: <Widget>[
//         //       Text('I am JSpang'),
//         //       Text('My website is jspang.com'),
//         //       Text('I love coding'),
//         //     ],
//         //   ),
//         // ),
//         /*
//         start - 将子控件放在主轴的开始位置
//         end - 将子控件放在主轴的结束位置
//         center - 将子控件放在主轴的中间位置
//         spaceBetween - 将主轴空白位置进行均分，排列子元素，首尾没有空隙
//         spaceAround - 将主轴空白区域均分，使中间各个子控件间距相等，首尾子控件间距为中间子控件间距的一半
//         spaceEvenly - 将主轴空白区域均分，使各个子控件间距相等
//          */

//         // // 3>.层叠布局
//         // body: Center(
//         //   child: stack,
//         // ),

//         // // 4.card布局
//         // body: Center(
//         //   child: card,
//         // ),

//         // 导航
//         body: Center(
//             // 按钮
//             child: Button()),
//       ),
//     );
//   }
// }

// class MyListView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       // 滑动方法 - 水平方法
//       scrollDirection: Axis.horizontal,
//       children: <Widget>[
//         new Image.network('https://cms-dumall.cdn.bcebos.com/cms_com_upload_pro/dumall_1588149639781.jpg?x-bce-process=image/quality,q_100/format,f_auto/interlace,i_progressive'),
//         new Image.network('https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3105985776,1507540069&fm=11&gp=0.jpg'),
//         new Image.network('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1590391163768&di=4d4846387c0f24f310895a37c45ac1e2&imgtype=0&src=http%3A%2F%2Fimg1.cache.netease.com%2Fcatchpic%2F4%2F4A%2F4A8FF896FCBBF48048A13CE64024DE0E.jpg')
//       ],
//     );
//   }
// }

// class Button extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton(
//       onPressed: () {
//         // 点击事件
//         // // MaterialPageRoute - 路由组件
//         // Navigator.push(context, MaterialPageRoute(
//         //   builder: (contxt) => new SecondScreen(productId: '1234567890')
//         // ));
//         _jumpSecondScreen(context);
//       },
//       child: Text('查看商品详情页'),
//     );
//   }

//   // 私有方法
//   _jumpSecondScreen(BuildContext context) async {
//     // 获取方法的result
//     final result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (contxt) => new SecondScreen(productId: '1234567890')));
//     // Toast
//     Scaffold.of(context).showSnackBar(SnackBar(content: Text('$result')));
//   }
// }

// class SecondScreen extends StatelessWidget {
//   // 接收参数
//   final String productId;
//   // 构造函数 - 这是什么写法？？？
//   /*
//   * @required - 表示参数是必选的
//   * : super(key:key) - 表示调用父类
//   * */
//   SecondScreen({Key key, @required this.productId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('商品详情页')),
//         body: Center(
//             child: RaisedButton(
//           onPressed: () {
//             // 点击事件
//             // Navigator.pop(context);
//             // 带参数回来
//             Navigator.pop(context, this.productId);
//             print(this.productId);
//           },
//           child: Text('返回'),
//         )),
//       ),
//     );
//   }
// }
// /*组件学习end*/
