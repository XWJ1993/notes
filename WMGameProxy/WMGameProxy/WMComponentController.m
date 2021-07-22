//
//  WMComponentController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/7/31.
//  Copyright © 2019 zali. All rights reserved.
//

#import "WMComponentController.h"
#import "WMSkillViewController.h"
#import "WMFoundationNSObject.h"

@interface WMComponentController () <UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate, UITabBarControllerDelegate, UIGestureRecognizerDelegate>
 
@end

/**
 1.认识UI(User Interface)
 1>.概述 - 用户通过UI与App进行交互/ 传入用户的请求/ 反馈运行的结果
 2>.坐标系 - 坐标系(0, 0)在左上角/ x轴向右x正向延伸/ y轴向下正向延伸
 */
@implementation WMComponentController

// 这里做很多事情会导致页面加载的很慢
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WMFoundationNSObject *f = [[WMFoundationNSObject alloc]init];
    [f showDate];
}

/**
 0.控制器
 1>.凡是继承于UIViewController的对象都是控制器
 2>.本身不可见/每个控制器都有一个UIView属性管理一个软件界面
 */

#pragma mark - UIView视图
// UIView是所有视图的父类/UIView的属性是子视图共有的
// 0.以父视图左上角为原点
// 1.UIView的基本属性
// 2.父视图/子视图之间的转化
// 3.形变属性
// 4.动画
// 5.停靠模式
/*
 总结一下UIView的属性：基础控件都可以使用
 1.subviews
 2.superview
 3.tag
 4.transform
 5.frame
 6.backgroundColor
 7.alpha
 */
-(void)setupView {
//    // 坐标系 - ？？？有导航栏"原点(0, 0)"和没有导航栏"原点(0, 0)"分别在什么位置？？？
//    CGPoint point = CGPointMake(100, 100); // 坐标 - 保存坐标x,y
//    CGSize size = CGSizeMake(100, 100);  // 尺寸 - 保存尺寸
//    CGRect rect = CGRectMake(100, 100, 100, 100); // 矩形 - 保存坐标 + 尺寸
//    CGRectZero - "高度/宽度 = 0"的矩形常量
    UIView *view = [[UIView alloc]init];
    /// 设置是否能接收事件 / UIView默认是true
    // 如果父视图不能接收事件、则子视图不能接收事件
    // 子视图超出父视图部分不能接收事件
    // 如果覆盖上面的视图可以接收事件、则下面视图不会再收到事件
    // UILabel/UIImageView 默认是 false
    view.userInteractionEnabled = true;
    // 是否开启多点触摸
    view.multipleTouchEnabled = true;
    // 可以控制位置&尺寸
    // 以父控件的左上角为原点
    view.frame = CGRectMake(100, 100, 100, 50);
    /// 结构体
    // 结构体是值传递
    // 类是对象传递
    // 怎么改变控件的frame（改变尺寸：中心点不变，向四周延伸）
    // https://www.jianshu.com/p/b6ddfdef4147
    CGRect tempRect = view.frame;
    tempRect.origin.x = 100;  // 改变x
    tempRect.origin.y += 100; // 改变y
    tempRect.size.height += 50; // 改变height
    tempRect.size.width += 50;  // 改变width
    view.frame = tempRect;
    // 可以控制尺寸
    // 不可以控制位置
    // 以自己左上角为坐标原点 - x和y永远为0
    view.bounds = CGRectMake(0, 0, 100, 50);
//    // 表示view与self.view大小一样
//    view.frame = self.view.bounds;
    // 可以控制位置
    // 控件的中心点：以父控件左上角为坐标原点
    // 默认情况下：子视图的边框不会被父视图的边框裁剪
    view.center = CGPointMake(100, 40);
    // 获取父视图对象：一个视图最多只有一个父视图
    // 一旦一个视图被添加到一个父视图上就会从上一个父视图移除
    // 移动父视图的时候子视图也会一起移动
    UIView *superView = view.superview;
    // 打印CGRect
    NSLog(@"%@", NSStringFromCGRect(superView.bounds));
    NSLog(@"%@", NSStringFromCGPoint(superView.center));
    // 获取最大值/最小值
    // 可以简化布局
    CGRectGetMaxX(view.frame);
    CGRectGetMaxY(view.frame);
    CGRectGetMidX(view.frame);
    CGRectGetMidY(view.frame);
    CGRectGetMinX(view.frame);
    CGRectGetMinY(view.frame);
//    // 设置frame的方式
//    // 第一种 - 直接设置
//    view.frame = CGRectMake(0, 0, 100, 100);
//    // 第二种 - 根据图片大小设置
//    UIImage *image = [UIImage imageNamed:@""];
//    view.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//    // 第三种
//    view.frame = view.bounds;
    /// 背景颜色
    // 这个已经封装
    //设置RGBA颜色
//    view.backgroundColor = [[UIColor alloc]initWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    view.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
//    // 这里怎么理解？？？
//    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
    /// 0-透明、1-不透明
    // 如果设置为0则不响应事件：所以一般不设置View透明度、而设置View背景透明度
    view.alpha = 0;
    // 根据内容（图片/文字）计算出最优size
    // 根据最优size改变自己的size
    [self.view sizeToFit];
    
    // 获取子控件对象：一个视图可以有多个子视图
    // 在xib中只有UIView可以承载子视图
    NSArray *subViews = view.subviews;
    // 如果父视图隐藏，子视图也会隐藏
    // 设置父视图alpha = 0.5/子视图alpha = 0.8，则真实alpha = 0.5 * 0.8 = 0.4
    // 一般我们是相对父视图布局：所以父视图移动，子视图跟着移动
    // 先添加到父视图的子视图会被后添加的视图覆盖
    // 一个父视图会有多个子视图、一个子视图只能有一个父视图、任何视图都可以添加到另一个视图
    for (view in subViews) {
       NSLog(@"%@", NSStringFromCGRect(view.superview.bounds));
    }
    // 把子视图放在最上面
    [self.view bringSubviewToFront:superView];
    // 把子视图放在最下面
    [self.view sendSubviewToBack:superView];
    // 交换两个视图位置
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:2];
    // 插入一个视图在另一个视图上面
    [self.view insertSubview:view aboveSubview:superView];
    // 插入一个视图在另一个视图下面
    [self.view insertSubview:view belowSubview:superView];
    // 插入子视图：默认会添加
    [self.view insertSubview:superView atIndex:0];
    // 任何视图都可以添加到另一个视图/每个视图只能有一个父视图
    // 子视图的坐标是相对于父视图的，移动父视图会使子视图一起移动
    [self.view addSubview:superView];
    // 获取superView的父视图
    [superView superview];
    // ！！！父视图不能移除子视图/子视图可以从父视图中移除！！！
    [superView removeFromSuperview];
    view.tag = 0;
    /// 图层
    self.view.layer.borderWidth = 1.0; // 边框宽度
    self.view.layer.borderColor = UIColor.orangeColor.CGColor; // 边框颜色
    self.view.layer.cornerRadius = 5;  // 设置圆角半径
    self.view.layer.masksToBounds = true; // 将位于它之下的 layer 都挡住/设置这个就会不显示阴影
    
    /// 形变属性：一次只能利用一个形变属性
    // 1.！！！xxxMakexxx相对于UIView的初始状态进行形变！！！
    // 2.！！！xxxxxx相对于传入的初始状态进行形变！！！
    // 可以用于动画
    // 一、缩放形变
    // 0.5 -相对于水平x方向缩放的比例
    // 2 -相对于垂直y方向缩放的比例
    view.transform = CGAffineTransformMakeScale(0.5, 2);
    // 相对于superView进行形变
    view.transform = CGAffineTransformScale(superView.transform, 0.5, 2);
    // 二、旋转形变
    // 参数是弧度
    view.transform = CGAffineTransformMakeRotation(M_PI);
    view.transform = CGAffineTransformRotate(view.transform, M_PI);
    /// 三、平移形变
    // 结构体
    // 2 -相对于水平x方向平移
    // 5 -相对于垂直y方向平移
    // x 负数代表向左平移
    // y 负数表示向上平移
    view.transform = CGAffineTransformMakeTranslation(2, -5);
    view.transform = CGAffineTransformTranslate(view.transform, 2, -5);
}


#pragma mark - CLayer(Core Animation Layer)
-(void)setupCALayer {
    // UIView是iOS系统中UI元素的基础，它的绘图部分是由CALayer类来管理
    // UIView有一个layer属性可以返回CALayer实例
    // layerClass方法
    // CALayer不能处理用户事件
}


#pragma mark - UILabel文本框
-(void)setupLabel {
    /// UILabel的包裹模式 - UILabel的高度是随着文字内容的增加而拉伸
    // 1.设置UILabel的位置(x, y)
    // 2.设置UILabel的最大宽度
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(100, 100, 100, 50);
    // 会先将label从别的父视图移除
    [self.view addSubview:label];
    label.backgroundColor = UIColor.whiteColor;
    label.text = @"hello world";
    label.textColor = UIColor.yellowColor;
    // 添加 "Zapfino.ttf字体"
    label.font = [UIFont fontWithName:@"Zapfino" size:20];
    /*
     NSTextAlignmentRight - 居右
     NSTextAlignmentCenter - 居中
     NSTextAlignmentLeft - 居左
     */
    label.textAlignment = NSTextAlignmentCenter;
    // 自适应宽度：字体会缩小/不会放大
    label.adjustsFontSizeToFitWidth = true;
    label.tag = 0;
    // ！！！父控件隐藏会导致所有的子控件都隐藏！！！
    label.hidden = false;
    // 指定label的行数
    // numberOfLines == 0表示无限行
    label.numberOfLines = 0;
    /*
     // 指定换行模式
     NSLineBreakByWordWrapping - 单词包裹
     NSLineBreakByCharWrapping - 字符包裹
     NSLineBreakByClipping
     NSLineBreakByTruncatingHead
     NSLineBreakByTruncatingTail
     NSLineBreakByTruncatingMiddle
     */
    label.lineBreakMode = NSLineBreakByWordWrapping;
    // 设置文字的最大宽度
    // 让 UILabel 能够计算出自己最真实的尺寸
    label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 15 * 2;
    // 让UILabel设置html文档
    NSString *htmlString = @"<html><body>Some html string\n<font size= \"13\" color=\"red\">This is some text!</font> </body></html>";
    NSAttributedString *attrString = [[NSAttributedString alloc]initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    label.attributedText = attrString;
}


#pragma mark - 阴影
-(void)setupShadow {
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(100, 100, 100, 50);
    // 阴影颜色
    label.shadowColor = UIColor.grayColor;
    // 偏移量
    // 负值 - 向左边、向下走
    // 正值 - 向右走、向上走
    label.shadowOffset = CGSizeMake(100, 100);
}


#pragma mark - UIButton按钮
/// 有那些类可以"事件监听"？？？:继承于UIControl都可以"事件监听"
// UIControlEventTouchUpInside - UIButton/点击事件
// UIControlEventValueChanged - UISwitch/UISegmentControl/UISlider/值改变事件
// UIControlEventEditingChanged - UITextField/文字改变事件
// UIDatePicker
// UIPageControl
// ！！！需求：将常见UI控件分类（按照父类）！！！
-(void)setupButton {
//    // 尽量使用快速定义方法、如果没有快速定义方法、再考虑init
//    UIButton *btn = [[UIButton alloc]init];
//    btn.buttonType = UIButtonTypeCustom; // 报错
    /// 工厂方法
    // 既可以显示文字也可以显示图片
    // 可以随时调整内部图片/文字的位置
    // 通过重写UIButton（设置buttonType只能在初始化的时候设置）
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:btn];
    /*
     button有四种状态
     这个很重要：可以用来做很多事情
     UIControlStateNormal -正常状态/默认状态
     UIControlStateHighlighted -高亮状态/长按未松手
     UIControlStateDisabled -禁用状态/不可以点击
     UIControlStateSelected -选择状态
     */
    // 设置文字
//    btn.titleLabel.text = "无效";
    [btn setTitle:@"普通" forState:UIControlStateNormal];
    [btn setTitle:@"高亮" forState:UIControlStateHighlighted];
    [btn setTitle:@"选择" forState:UIControlStateSelected];
    [btn setTitle:@"禁用" forState:UIControlStateDisabled];
    btn.selected = YES; // 选择状态
    // 字体字重
    btn.titleLabel.font = [UIFont systemFontOfSize:15 weight:5];
    // 文字颜色
    [btn setTitleColor:UIColor.greenColor forState:UIControlStateNormal];
    btn.enabled = NO; // 非禁用状态
    // 设置文字阴影颜色
    [btn setTitleShadowColor:UIColor.whiteColor forState:UIControlStateNormal];
    // 设置文字阴影偏移
    btn.titleLabel.shadowOffset = CGSizeMake(3, 2);
    /// 背景颜色
    // 仅仅自定义类型有效
    btn.backgroundColor = UIColor.grayColor;
    /// 设置button图像：内容图像（如果想修改布局需要重写UIButton的方法）
    // 1.只有图片/文字居中显示在button中央位置
    // 2.如果按钮足够大、同时设置文字和图片、文字/图片会并列显示
    // 3.如果按钮不够大、优先显示图像
    // 居中不拉伸
    // 如果按钮小于图片会拉伸按钮
    [btn setImage:[UIImage imageNamed:@"image_demo"] forState:UIControlStateNormal];
    /// 设置背景图像
    // 1.创建UIImage对象
    UIImage *bgImage = [UIImage imageNamed:@"image_demo"];
    /// 2.返回一张受保护而且拉伸的图片
    // 第一种方式
    // ！！！可以保证纯色图片拉伸不变形！！！
    // UIImageResizingModeTile（默认：平铺）
    // UIImageResizingModeStretch（拉伸）
    UIImage *resizableImage = [bgImage resizableImageWithCapInsets: UIEdgeInsetsMake(bgImage.size.height / 2,
                                                                                     bgImage.size.width / 2, bgImage.size.height / 2 - 1, bgImage.size.width / 2 - 1)
                                                      resizingMode: UIImageResizingModeTile];
//    // 第二种方式
//    [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width / 2 topCapHeight:bgImage.size.height / 2];
    // 根据按钮的尺寸拉伸
    [btn setBackgroundImage:resizableImage forState:UIControlStateNormal];
    // 内边距
    // 上左下右
    btn.contentEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0); // 内容（图片 + title）
    btn.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0); // 图片
    btn.titleEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0); // title
//    // 获取属性
//    // nullable - 可以为空/可选类型
//    NSString *title = [btn titleForState:UIControlStateNormal];
//    UIImage *image = [btn imageForState:UIControlStateNormal];
    // 点击事件：记下来就好
    // 最多只能携带一个参数
    // TouchUpInside
    /*
     // 基于触摸
     UIControlEventTouchDown // 用户按下时触发
     UIControlEventTouchDownRepeat // 点击次数大于1时触发
     UIControlEventTouchDragInside // 当触摸在控件内拖动时触发
     UIControlEventTouchDragOutside // 当触摸在控件外拖动时触发
     UIControlEventTouchDragEnter // 当触摸在控件外拖动到控件内时触发
     UIControlEventTouchDragExit // 当触摸在控件内拖动到控件外时触发
     UIControlEventTouchUpInside // 控件内部触摸抬起时(☑️)
     UIControlEventTouchUpOutside // 控件外部触摸抬起时
     UIControlEventTouchCancel // 触摸取消事件：设置上锁、电话呼叫中断等
     // 基于值
     UIControlEventValueChanged // 当控件的值发生改变：一般用于滑块和分段视图(☑️)
     // 基于编辑
     // 一般 UITextField 使用较多
     UIControlEventEditingDidBegin // 文本控件开始编辑时
     UIControlEventEditingChanged  // 文本控件中文本发生改变时
     UIControlEventEditingDidEnd // 文本控件中编辑结束时
     UIControlEventEditingDidEndOnExit // 文本控件内通过按下回车键结束编辑时
     UIControlEventAllTouchEvents // 所有触摸事件
     UIControlEventAllEditingEvents //文本编辑的所有事件
     UIControlEventAllEvents // 所有事件
     */
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    // 移除某个事件
    [btn removeTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnAction:(UIButton *)btn {
    NSLog(@"button被点击");
}


#pragma mark - UIImageView图片视图
// UIImage -二进制的图像数据
-(void)setupImageView {
    /// 创建图片对象
    // 图片加载方式
    // 该方法只能加载占用内存小的图片：因为这种方式加载的图片会一直保存在内存中，不会释放
    // Assets.xcassets中的图片只能通过该方法设置（默认就有缓存）
    // 一般经常使用的图片会通过该方式加载
    // png不需要后缀（jpg必须加后缀）
    UIImage *image0 = [UIImage imageNamed:@"image_demo"];
    // 打印图片大小
    NSLog(@"%@", NSStringFromCGSize(image0.size));
    /// 如果图片占用内存较大：使用下列方法（没有缓存）
    // 会从内存中释放
    // 一般不经常使用的图片会通过该方式加载
    // 进入"资源包"获取资源
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image_demo" ofType:@"png"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    // 方法一
    UIImage *image1 = [UIImage imageWithData:data];
    // 方法二
    UIImage *image2 = [UIImage imageWithContentsOfFile:path];
    NSLog(@"%@===%@", image1, image2);
    /// UIImageView
    UIImageView *imageView = [[UIImageView alloc]init];
//    // 第一种设置位置（常用）
//    imageView.frame = CGRectMake(100, 100, 100, 50);
//    // 第二种设置位置（常用）
//    // 根据图片动态获取尺寸
//    imageView.frame = CGRectMake(0, 0, image0.size.width, image0.size.height);
//    // 第三种设置位置（骚操作）
//    // 有默认尺寸
//    UIImageView *defaultImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image_demo"]];
//    defaultImageView.center = CGPointMake(100, 100);
//    [self.view addSubview:defaultImageView];
    /// 开发中常见的颜色
    // 颜色通道： ARGB/32位颜色 | RGB/24位颜色 | RGB/12位
    // 颜色通道越多，质量就越高，占用尺寸就越大，图像就越清晰
    imageView.backgroundColor = [UIColor.redColor colorWithAlphaComponent:1];
    imageView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    imageView.image = [UIImage imageNamed:@"image_demo"];
    imageView.highlightedImage = image0; // 设置高亮图片
    imageView.userInteractionEnabled = YES; // 默认为NO
    imageView.clipsToBounds = YES;  // 裁减超出部分
    /*
     填充模式：
     UIViewContentModeRedraw -重新绘制（核心动画drawRect）
     UIViewContentModeScaleToFill -拉伸填满/默认/不会超出：图片会变形
     UIViewContentModeScaleAspectFit -按比例填充/宽或高一边靠近/不会超出
     UIViewContentModeScaleAspectFill -按比例填满/宽和高全部靠近/会超出
     */
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // 毛玻璃
    UIToolbar *toolBar = [[UIToolbar alloc]init];
    // toolBar沾满imageView全屏幕
    toolBar.frame = imageView.bounds;
    /*
     UIBarStyleDefault
     UIBarStyleBlack
     */
    toolBar.barStyle = UIBarStyleBlack;
    // 设置透明度
    toolBar.alpha = 0.5;
    [imageView addSubview:toolBar];
    
    // 动画部分 - start
    // 1.帧动画
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"DOVE/image_bg.jpg"]];
    // 1).拿到数组
    NSMutableArray<UIImage *> *photos = [NSMutableArray array];
    for (NSInteger i = 1; i < 19; i++) {
        // 获取图片对象
        // 好好研究 UIImage
        UIImage *birdImaga = [UIImage imageNamed:[NSString stringWithFormat:@"DOVE.bundle/DOVE %ld", (long)i]];
        [photos addObject:birdImaga];
    }
    // 2).设置动画
    // 动画需要时间前面一个动画会覆盖后面一个动画
    // 甚至会发生未知的错误
    // 所以一般需要前面一个动画结束再执行后一个动画
    // 动画数组
    imageView.animationImages = photos;
    // 动画执行时间/动画时长
    imageView.animationDuration = 0.5;
    // 播放动画次数 / 0为无数次
    imageView.animationRepeatCount = 0;
    // 启动动画
    [imageView startAnimating];
    if (imageView.isAnimating) {
        // 正在执行动画
    }
//    // 停止动画
//    [imageView stopAnimating];
    
    // 2.渐变动画
    // 只能修改“坐标系的属性、色彩、透明度”
    // 第一种方式：通过delegate（先不实现）
    // 第二种方式：通过block
    // 不会引起循环引用：为什么？组织一下语言
    // 目前有三种形式：应用也很多
    // 支持嵌套
    [UIView animateWithDuration:2 animations:^{
        // 这里还可以设置形变属性
        NSLog(@"这里可以改变“坐标/色彩/透明度”");
    }];
    [UIView animateWithDuration:2 animations:^{
        // ！！！这里还可以设置形变属性！！！
        NSLog(@"这里可以改变“坐标/色彩/透明度”");
    } completion:^(BOOL finished) {
        // 动画完成时需要的执行
        if (finished) {
            NSLog(@"动画完成");
        }
    }];
    // UIViewAnimationOptions - 动画属性设置
    // https://www.jianshu.com/p/ec73573e112a
    /**
     UIViewAnimationOptionCurveEaseInOut - 动画开始结束比较慢，中间比较快
     UIViewAnimationOptionCurveEaseIn - 动画开始比较慢
     UIViewAnimationOptionCurveEaseOut - 动画结束比较慢
     UIViewAnimationOptionCurveLinear - 线性
     */
    [UIView animateWithDuration:2 delay:0.5 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        // 1.这里还可以设置形变属性
        NSLog(@"这里可以改变“坐标/色彩/透明度”");
        // 2.如果使用 masonry 则需要 [xxx layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            NSLog(@"动画完成");
        }
    }];
    
    // 3.核心动画
    // CAKeyframeAnimation/CABasicAnimation/CATransition
    
    // 4.转场动画
    
    // 动画部分 - end
}

-(void)addRoundCorner {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;    // 会产生离屏渲染，特别消耗性能
    imageView.layer.cornerRadius = 10;
    // FIXME - 此处自行百度寻找不会产生离屏渲染的方法
}

#pragma mark - UITextField文本输入框
-(void)setupTextField {
    UITextField *tf = [[UITextField alloc]init];
    tf.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:tf];
//    // 这两个方法正好相反
//    [tf removeFromSuperview];
    tf.text = @"我是文本框";
    tf.font = [UIFont systemFontOfSize:20];
    // 文本颜色
    tf.textColor = UIColor.redColor;
    // 文本对齐方式
    tf.textAlignment = NSTextAlignmentLeft;
    // 占位符
    tf.placeholder = @"请输入用户名";
    // 边框类型
    tf.borderStyle = UITextBorderStyleBezel;
    // 宽度自适应
    tf.adjustsFontSizeToFitWidth = true;
    // 开始编辑的时候清除文本框文字
    tf.clearsOnBeginEditing = true;
    // 设置清除UIButton
    tf.clearButtonMode = UITextFieldViewModeAlways;
    // 设置键盘外观
    tf.keyboardAppearance = UIKeyboardAppearanceDark;
    // 设置键盘类型
    tf.keyboardType = UIKeyboardTypeNumberPad;
    // 设置返回键类型
    tf.returnKeyType = UIReturnKeyDone;
    // 设置密文显示
    tf.secureTextEntry = true;
    // 自动大写类型
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    // 设置代理
    tf.delegate = self;
    // 变成第一响应者
    // 只有成为"第一响应者"才可以弹出键盘
    // 结束编辑实际就是失去"第一响应者"
    [tf becomeFirstResponder];
    // 可以达到 delegate 一样的效果
    // 监听文本改变（也可以使用delegate）
    [tf addTarget:self action:@selector(editDidChanged:) forControlEvents:UIControlEventEditingChanged];
    /// 自定义清除按钮
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    view.backgroundColor = UIColor.yellowColor;
    tf.rightView = view;
    tf.rightViewMode = UITextFieldViewModeWhileEditing;
    /// 自定义文本框弹出键盘
    // 一般银行 App 使用较多
    UIView *csView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 20)];
    csView.backgroundColor = UIColor.redColor;
    tf.inputView = csView;
    // 自定义文本框弹出键盘 Bar
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44)];
    barView.backgroundColor = UIColor.blueColor;
    tf.inputAccessoryView = barView;
}
/// editDidChanged:是方法名称
-(void)editDidChanged:(UITextField *)textField {
    NSLog(@"文字改变");
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    /// 是否允许开始编辑
    // YES代表可以成为第一响应者
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // 开始编辑/点击输入框调用该方法
    // 成为 “第一响应者” 开始调用
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    /// 是否允许结束编辑
    // NO代表不可以失去第一响应者
    return NO;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    // 结束编辑
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    /// 点击 return 的时候调用该方法
    // 第一种方式：放弃第一响应者（退出键盘）
    [textField resignFirstResponder];
//    // 第二种方式
//    [textField endEditing:YES];
//    // 第三种方式（常用）
//    [self.view endEditing:YES];
    return true;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    // 是否允许全部清空
    return YES;
}
/// ！！！重点！！！
// 当textField文字发生改变就会调用该方法
// 拦截用户输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 是否允许改变文本框内容
    // 是否允许string去改变文本框内容
    return YES; // 允许输入
//    return NO; // 禁止输入
}


#pragma mark - UITextView能滚动的文本显示控件
-(void)setupTextView {
    // 可以滚动
    UITextView *textView = [[UITextView alloc]init];
    textView.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:textView];
    textView.backgroundColor = [UIColor whiteColor];
    // 当文字超过视图边框时是否允许滑动 - 默认YES
    textView.scrollEnabled = YES;
    // 是否允许编辑内容 - 默认YES
    textView.editable = YES;
    // 设置字体名字和字体大小
    textView.font = [UIFont fontWithName:@"Arial" size:18.0];
    // return键的类型
    textView.returnKeyType = UIReturnKeyDefault;
    // 键盘类型
    textView.keyboardType = UIKeyboardTypeDefault;
    // 文本显示的位置默认为居左
    textView.textAlignment = NSTextAlignmentLeft;
    // 显示数据类型的链接模式（如电话号码、网址、地址等）
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    // 内容
    textView.text = @"请输入你想要说的话";
    // 设置代理
    textView.delegate = self;
}
#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    // 将要开始编辑
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    // 将要结束编辑
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    // 结束编辑
    [textView resignFirstResponder]; // 放弃第一响应者
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    // 开始编辑
}
/*
 内容文字改变的时候调用
 text - 用户输入的内容
 return - YES允许用户输入/NO不允许使用输入
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // 内容将要发生改变
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    // 内容发生改变
}
- (void)textViewDidChangeSelection:(UITextView *)textView {
    // 焦点发生改变
}



#pragma mark - UIScrollView滚动视图
// 用于显示超出App程序窗口大小的内容
// 允许用户通过拖动手势滚动查看内容
// 允许用户通过捏合手势缩放内容
// 用来滚动的视图，可以用来展示大量内容
// UIView不具备滚动功能
// ！！！不能用索引去查找UIScrollView的子控件（位置不确定）！！！
-(void)setupScrollView {
    /// UIScrollView不可滚动的原因有哪些？？？
    // 1.没有设置contentSize
    // 2.设置scrollEnabled = NO
    // 3.设置userInteractionEnabled = NO
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.backgroundColor = UIColor.grayColor; // 设置颜色
//    scrollView.clipsToBounds = YES;  // 默认该属性为YES（超出边框的内容会隐藏）
    /// 可视范围： scrollView的尺寸
    /// 内容实际大小
    // 可滚动尺寸： contentSize的尺寸 - scrollView的尺寸
    // 不可以滚动： contentSize的尺寸 <= scrollView的尺寸
    scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * 2, [[UIScreen mainScreen] bounds].size.height);  // 设置内容大小（左右滚动）/这里[[UIScreen mainScreen] bounds].size.height也可以设置为0
    scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height * 2);  // 设置内容大小（上下滚动）/这里[[UIScreen mainScreen] bounds].size.width也可以设置为0
    // 结构体x|y
    // 内容偏移量 = UIScrollView左上角 - 内容左上角
    // 可以控制滚动的位置
    scrollView.contentOffset = CGPointZero; // 内容偏移量：内容和控件的距离（设置UIScrollView滚动的位置）
    // 增加额外滚动区域
    // 凡是在导航条下面的UIScrollView默认会设置偏移量
    // 可以通过self.automaticallyAdjustsScrollViewInsets = NO;设置
    // 参考 - UIScrollView的常见属性.png
    scrollView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);  // 内边距 - cell到边的距离
    // 不要自动设置偏移量
    /**
     if(@available(macOS10.1, iOS 11, *)) {
         //code
     }
     */
    if (@available(iOS 11, *)) {
        // >= iOS 11
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // < iOS 11
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    scrollView.bounces = NO;  // 设置是否反弹
    scrollView.pagingEnabled = YES; // 设置按页滚动（以UIScrollView尺寸为一页）
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite; // 设置滚动条样式
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 30); // 一般不需要设置
    // 设置隐藏滚动条
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = true; // 设置是否可以滚动（设置为NO则UIScrollView不能滚动）
    scrollView.scrollsToTop = true;  // 是否滚动到顶部
    scrollView.userInteractionEnabled = NO; // 是否可以响应与用户的交互（设置为NO则UIScrollView不能滚动）
    scrollView.alwaysBounceHorizontal = YES; // 水平方向不管有没有设置contentSize，总有弹簧效果
    scrollView.alwaysBounceVertical = YES; // 垂直方向不管有没有设置contentSize，总有弹簧效果
    // UIScrollView通过delegate对WMComponentController弱引用
    // WMComponentController对UIScrollView强引用（这里只是一个局部变量）
    scrollView.delegate = self;
    //！！！以下一般不设置！！！//
    /// UIScrollView很容易实现内容缩放
    /// ！！！设置缩放功能：需要两步！！！
    // 1.设置pinch缩放属性：默认值为1
    // scrollView.minimumZoomScale == scrollView.maximumZoomScale不能缩放
    scrollView.minimumZoomScale = 0.5; // 缩小的最小比例
    scrollView.maximumZoomScale = 5;    // 放大的最大比例
    // 减速率：一般数值越大，停下来的时间越长
    scrollView.decelerationRate = 0;
    // 按住手指还没有开始拖动是YES
    // 是否正在被拖拽
    // 是否正在减速
    // 是否正在缩放
    NSLog(@"%d, %d, %d, %d", scrollView.tracking, scrollView.dragging, scrollView.decelerating, scrollView.zooming);
    [self.view addSubview:scrollView];
    // 原则：遍历一个数组最好要保证该数组不变
    // ！！！这里目前是没有问题的！！！
    for (UIView *subView in scrollView.subviews) {
        [subView removeFromSuperview];
    }
}
#pragma mark - UIScrollViewDelegate
/// 1&2&4 -可以唯一确定上滑/下滑
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 1.不管怎么操作-只要拥有偏移量就执行
    // 实时监测滚动变化
}
/// 2&4 -可以唯一确定停止滚动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 2.已经停止拖拽的时候执行
    if (decelerate == NO) {
        // 没有减速（表示已经停止滚动）
        // 4&5不会执行
    } else {
        // 停止拖拽，由于惯性会减速（表示没有停止滚动）
        // 4&5会执行
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    // 3.将要停止拖拽的时候执行
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 4.已经减速结束的时候执行
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    // 5.将要减速的时候执行
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 6.将要拖动的时候执行
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    // 7.是否允许回到顶部 - 一般不用设置
    return YES;
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    // 8.已经回到顶部开始执行
}
//！！！以下处理缩放逻辑！！！//
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // 2.设置对哪个视图缩放、返回缩放的视图对象
    // ！！！不能用索引去查找UIScrollView的子控件（位置不确定）！！！
    // FIXME - 所以此处写法有问题
    return scrollView.subviews.firstObject;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    // 将要开始缩放
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // 已经开始缩放（正在缩放）
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    // 已经结束缩放
}


#pragma mark - UIPageControl分页控件
-(void)setupPageControl {
    // 高度默认37（不能修改）
    UIPageControl *pc = [[UIPageControl alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    pc.currentPage = 5;  // 当前页码
    pc.numberOfPages = 10; // 总共页码
    pc.hidesForSinglePage = YES; // 只有一页时是否隐藏视图
    pc.pageIndicatorTintColor = UIColor.greenColor; // 控件颜色（未选中颜色）
    pc.currentPageIndicatorTintColor = UIColor.orangeColor; // 当前选中颜色
    pc.enabled = NO; // 一般都是屏蔽事件
    [pc addTarget:self action:@selector(updatePageChanged:) forControlEvents:UIControlEventValueChanged];
    pc.tag = 100;
    [pc updateCurrentPageDisplay]; // 刷新当前视图
    [self.view addSubview:pc];
    // 自定义 "UIPageControl样式"
    // 利用 KVC 访问私有变量
    [pc setValue:[UIImage imageNamed:@"xxx"] forKeyPath:@"_currentPageImage"];
    [pc setValue:[UIImage imageNamed:@"xxx"] forKeyPath:@"_pageImage"];
}
-(void)updatePageChanged:(UIPageControl *)pc {
    NSLog(@"%ld", (long)pc.currentPage);
}


#pragma mark - UIMenuController菜单
// https://blog.csdn.net/woyangyi/article/details/45896859
-(void)setupMenuController {
    // 如果一个控件可以使用 “单例” 创建，那么最好让 “init” 创建报错
    UIMenuController *menu = [UIMenuController sharedMenuController];
    UIMenuItem *copyItem = [[UIMenuItem alloc]initWithTitle:@"copy" action:@selector(onCopy:)];
    UIMenuItem *deleteItem = [[UIMenuItem alloc]initWithTitle:@"delete" action:@selector(onDelete:)];
    menu.menuItems = @[copyItem, deleteItem];
    // 设置坐标
    // 这块坐标一般取 “点击的位置”
    [menu setTargetRect:CGRectMake(100, 100, 80, 50) inView:self.view];
    // 显示 menu
    [menu setMenuVisible:YES animated:YES];
    // 设置当前 UIViewController 为第一响应者
    // UIMenuController的显示依赖第一响应者（UIViewController取消第一响应者 -> UIMenuController自动消失）
    [self becomeFirstResponder];
}
-(void)onCopy:(UIMenuItem *)item {
    
}
-(void)onDelete:(UIMenuItem *)item {
    
}


/// UIRefreshControl下拉刷新控件
// 不能上拉加载
-(void)setupRefreshControl {
    
}


/// UIAlertController
// iOS8.0以上推荐使用
-(void)setupAlertController {
    // 1.创建控制器
    // UIAlertController 是 UIViewControlelr 子类
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定删除？" message:@"删除以后别人将看不到你的动态" preferredStyle: UIAlertControllerStyleActionSheet];
    // 2.创建按钮
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"你点击了确认");
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"你点击了取消");
    }];
    // 3.添加按钮
    [alertVC addAction:sureAction];
    [alertVC addAction:cancelAction];
    // 4.还可以添加文本框
    // 如果需要给 block 中的对象赋值需要使用 __block 修饰
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    // 5.显示弹窗
    [self presentViewController:alertVC animated:YES completion:nil];
}


/// UIPickerView/选择器
-(void)setupPickerView {
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    // 默认选中
    [self pickerView:pickerView didSelectRow:0 inComponent:0];
    [pickerView selectRow:0 inComponent:1 animated:true];
    // 刷新数据
    [pickerView reloadAllComponents];
    [pickerView reloadComponent:0];
}
#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate
/// UIPickerViewDataSource
/// 必须实现
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    // 总共多少列
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    // 每列展示多少行
    return 10;
}
/// UIPickerViewDelegate
/// 非必须实现
// 返回每一列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.view.frame.size.width / 2;
}
// 返回每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 45;
}
/// 返回每一行的内容
// 1.字符串
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"xmg";
}
// 2.带属性字符串（大小、颜色、阴影、描边）
- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return nil;
}
// 3.视图
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    return [[UIView alloc] init];
}
// 当前选中的哪一行哪一列
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}


/// UIDatePicker/时间选择器
// date/data区别
-(void)setupDatePicker {
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    // 修改 datePicker 日期格式
    datePicker.datePickerMode = UIDatePickerModeDate;
    // ISO 639语言编码
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    // 监听日期改变
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
}
-(void)dateChange:(UIDatePicker *)datePicker {
    // 获取当前选中的日期
    // NSDate 和 NSString 相互转换
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    [fmt stringFromDate:datePicker.date];
}


/// UIStackView
-(void)setupStackView {
    
}


/// UIPopoverContrller
// 继承于 NSObject
-(void)setupPopoverContrller {
    
}


/// UISlider/滑块
// 作用：控制系统声音/表示播放进度
-(void)setupSlider {
    UISlider *slider = [[UISlider alloc]init];
    slider.frame = CGRectMake(100, 100, 100, 50);
    slider.maximumValue = 100; // 设置最大值
    slider.minimumValue = 0;   // 设置最小值
    slider.value = 20;  // 设置当前值：必须设置最大值和最小值以后才可以设置value
    // 设置颜色
    slider.maximumTrackTintColor = UIColor.purpleColor;
    slider.minimumTrackTintColor = UIColor.blueColor;
    slider.thumbTintColor = UIColor.greenColor;
    // 设置图片
    slider.maximumValueImage = [UIImage imageNamed:@""]; // 右边（最大）图片
    slider.minimumValueImage = [UIImage imageNamed:@""]; // 左边（最小）图片
    [slider setThumbImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    slider.continuous = NO; // 不接收连续点击
    // 设置 UISlider 的值
    [slider setValue:10 animated:YES];
    // 滑块拖动时的事件
    [slider addTarget:self action:@selector(onSliderChanged:) forControlEvents:UIControlEventValueChanged];
    // 滑块拖动后的事件
    // 一般都选择 UIControlEventTouchUpInside
    [slider addTarget:self action:@selector(onSliderUp:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)onSliderChanged:(UISlider *)slider {
    NSLog(@"滑块拖动时的事件");
}
-(void)onSliderUp:(UISlider *)slider {
    NSLog(@"滑块拖动后的事件");
}


/// UISwitch/开关
// ！！！不能设置尺寸的控件（只能通过缩放设置尺寸）！！！
// UISwitch
// UIActivityIndicatorView
// UISegmentControl
-(void)setupSwitch {
    UISwitch *sw = [[UISwitch alloc]init];
    // 因为 iOS 内置 size（默认width51.0/height31.0）
    // 设置 frame 没有效果
    // 可以通过缩放来设置大小
    sw.frame = CGRectMake(100, 100, 100, 50);
    sw.on = true; // 是否打开
    sw.onTintColor = UIColor.orangeColor;
    sw.tintColor = UIColor.greenColor;
    sw.thumbTintColor = UIColor.purpleColor;
    [sw addTarget:self action:@selector(onSwitchChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sw];
    [sw setOn:YES animated:true];
}
-(void)onSwitchChange:(UISwitch *)sw {
    NSLog(@"打开开关");
}


/// UIStepper/步数器
-(void)setupStepper {
    UIStepper *step = [[UIStepper alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview:step];
    step.stepValue = 5;
    step.minimumValue = 0;
    step.maximumValue = 20;
    // 当前值
    step.value = 0;
    step.tintColor = UIColor.greenColor;
    // 可以从头开始
    step.wraps = YES;
    step.continuous = NO;
    step.autorepeat = YES;
    [step addTarget:self action:@selector(onStep:) forControlEvents:UIControlEventValueChanged];
}
-(void)onStep:(UIStepper *)step {
    
}


/// UISegmentControl/多段选择视图、选项卡
-(void)setupSegmentControl {
    NSArray *array = @[@"居左", @"居中", @"居右"];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:array];
//    segmentControl.frame = CGRectMake(100, 100, 100, 50);
    segmentControl.center = CGPointMake(100, 50);
    [self.view addSubview:segmentControl];
    segmentControl.tintColor = UIColor.orangeColor;
    segmentControl.selectedSegmentIndex = 0;  // 选中状态
    [segmentControl insertSegmentWithTitle:@"下一页" atIndex:1 animated:NO]; // 插入新段
    segmentControl.momentary = YES; // 默认为 NO（YES表示一会儿以后不显示被选中状态）
    [segmentControl addTarget:self action:@selector(onSegmentControl:) forControlEvents:UIControlEventValueChanged];
}
-(void)onSegmentControl:(UISegmentedControl *)segmentControl {
    
}


///// UIAlertView/中间弹窗
//// 不需要添加到父试图/不需要设置坐标
//-(void)setupAlertView {
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"输入密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",@"OK", nil];
//    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
//    [alert show];
//}
#pragma mark - UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    // 点击第几个 button
//}


///// UIActionSheet/底部弹窗
//-(void)setupActionSheet {
//    UIActionSheet *alert = [[UIActionSheet alloc]initWithTitle:@"你确定需要删除吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"确定", nil];
//    [alert showInView:self.view];
//}
#pragma mark - UIActionSheetDelegate
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    // 点击第几个 button
//}
//
//- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
//    // 有系统事件（来电）时调用
//}


/// UIProgressView/进度条
-(void)setupProgressView {
    UIProgressView *progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:progressView];
    // 当前进度
    progressView.progress = 0.5;
    progressView.tag = 0;
    progressView.progressTintColor = UIColor.orangeColor;
}


/// UIActivityIndicatorView/活动指示器
-(void)setupActivityIndicatorView {
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    // 不需要设置尺寸
    // 只需要设置位置
    // 可以通过缩放来设置大小
    view.frame = CGRectMake(100, 100, 100, 50);
    view.center = CGPointMake(100, 50);
    [self.view addSubview:view];
    view.hidesWhenStopped = YES; // 动画停止：是否隐藏视图、默认为YES
    // 开始动画
    [view startAnimating];
    //    // 结束动画
    //    [view stopAnimating];
    NSLog(@"当前动画的状态：%d", view.isAnimating);
}


/// keyBoard
-(void)keyBoard {
    // 强行关闭键盘：设置为 YES/NO 都可以关闭键盘
    // 但是发生界面死锁 NO 可能不会关闭
    // 可以强制退出键盘
    [self.view endEditing:YES];
}


/**
 iOS中事件分类：
 1.触摸事件（点击按钮、长按）/ UIGestureRecognizer
 2.加速计事件（摇一摇）/ 还没有看
 3.远程控制事件（遥控）/ 还没有看
 */
#pragma mark - UIGestureRecognizer/手势识别器
// 响应者：在 iOS 中不是所有对象都可以处理事件，只有继承 UIResponder 对象才可以接收并处理事件，我们称为“响应者对象”
// UIApplication/UIViewController/UIView都是“响应者对象”（能够接收并处理对象）
// UIResponder 内部提供了很多方法来处理事件
// 父视图不能监听事件，则子视图无法监听事件/子视图超出父视图的部分，不能监听事件
// UILabel/UIImageView默认不能接收事件
// https://www.jianshu.com/p/b1eaeff5ec81
// https://www.jb51.net/article/108236.htm
/**
 控件不能接收事件的四种可能性：
 1.userInteractionEnabled = NO;
 2.hidden = YES;
 3.alpha = 0.0 ~ 0.01;
 4.父控件不能接收事件;
 */
/**
 事件传递：
 UIApplication -> UIWindow -> 父控件 -> 子控件
 1.如果“父控件”不能响应事件：事件中断
 2.如果“子控件”不能响应事件：事件传递到“父控件”终止/“父控件”响应事件
 */
/**
 如何找到最合适的控件来处理事件？（有没有比自身控件更合适的控件）
 1.自己是否能够接收触摸事件；
 2.触摸点是否在自己身上；
 3.从后往前遍历子控件：重复步骤 1/2；
 4.如果没有符合条件 1/2 的子控件就自己最适合处理；
 */
-(void)setupGestureRecognizer {
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:imageView];
    imageView.backgroundColor = UIColor.redColor;
    imageView.userInteractionEnabled = YES;
    // 一个视图可以附着多个手势/一个手势只能附着一个视图
    /// 0.单击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    tap.numberOfTapsRequired = 1;  // 设置点击次数
    tap.numberOfTouchesRequired = 1; // 设置需要几根手指
    tap.delegate = self; // ！！！手势可以设置代理！！！
    [imageView addGestureRecognizer:tap];
    /// 1.双击
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [imageView addGestureRecognizer:doubleTap];
    [tap requireGestureRecognizerToFail:doubleTap]; // 单击会在双击失败以后才会识别单击手势
    /// 2.长按手势/拖动的时候会持续调用
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(onLongPress:)];
    longPress.minimumPressDuration = 1;  // 最小按压时间
    [imageView addGestureRecognizer:longPress];
    /// 3.拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onPan:)];
    [imageView addGestureRecognizer:pan];
    /// 4.捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(onPinch:)];
    pinch.delegate = self;
    [imageView addGestureRecognizer:pinch];
    /// 5.旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(onRotation:)];
    rotation.delegate = self;
    [imageView addGestureRecognizer:rotation];
    /// 6.轻扫手势（可以用于视频/直播方面）
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onSwipe:)];
    // NS_OPTIONS
    // 设置轻扫手势方向
    // ！！！一个轻扫手势只能对应一个方向！！！
    // 默认 UISwipeGestureRecognizerDirectionRight
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [imageView addGestureRecognizer:swipe];
}
/// 事件处理
-(void)onTap:(UITapGestureRecognizer *)tap {
    NSLog(@"点击");
}
// 当长按移动的时候会持续调用
-(void)onLongPress:(UILongPressGestureRecognizer *)press {
    NSLog(@"长按");
    // 判断手势的状态
    switch (press.state) {
        case UIGestureRecognizerStatePossible:{
            NSLog(@"");
        }
            break;
        case UIGestureRecognizerStateBegan:{
            NSLog(@"开始长按");
        }
            break;
        case UIGestureRecognizerStateChanged:{
            NSLog(@"开始时移动");
        }
            break;
        case UIGestureRecognizerStateEnded:{
            NSLog(@"手指离开");
        }
            break;
        case UIGestureRecognizerStateCancelled:{
            NSLog(@"");
        }
            break;
        case UIGestureRecognizerStateFailed:{
            NSLog(@"");
        }
            break;
        default:
            NSLog(@"");
            break;
    }
}
-(void)onPan:(UIPanGestureRecognizer *)pan {
    // 可以拿到拖动的偏移量
    // 相对于 “最原始的位置”/ 需要做 “复位” 操作
    CGPoint point = [pan translationInView:self.view];
    NSLog(@"拖动的偏移量=%@", NSStringFromCGPoint(point));
    // 1.这里可以执行 “平移” 效果让控件移动
    // 假装这里有代码 / 形变 //
    // 2.复位操作
    [pan setTranslation:CGPointZero inView:self.view];
}
-(void)onPinch:(UIPinchGestureRecognizer *)pinch {
    // 1.这里配合 “形变属性” 可以操作很多动画效果
    // 假装这里有代码 / 形变 //
    // 2.相对于 “最原始的位置”/ 需要做 “复位” 操作
    NSLog(@"捏合的比例=%lf", pinch.scale);
    [pinch setScale:1];
}
-(void)onRotation:(UIRotationGestureRecognizer *)rotation {
    // 1.这里配合 “形变属性” 可以操作很多动画效果
    // 假装这里有代码 / 形变 //
    // 2.相对于 “最原始的位置”/ 需要做 “复位” 操作
    NSLog(@"旋转的角度=%lf", rotation.rotation);
    [rotation setRotation:0];
}
-(void)onSwipe:(UISwipeGestureRecognizer *)swipe {
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"向上轻扫");
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"向右轻扫");
    }
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 是否允许触发手势
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 是否允许同时支持多个手势：默认不支持 / YES表示支持
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 是否允许接收手势
    // 一边可以接收手势
    // 另一边不可以接收手势
    CGPoint point = [touch locationInView:self.view];
    if (point.x > self.view.frame.size.width / 2) {
        return NO;
    } else {
        return YES;
    }
}


#pragma mark -触摸
/// 点击控制器 View 系统会自动调用
// 1.一根/多根手指开始触摸 view
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 事件将顺着响应者链条往上传递
    // 控制器的 View 上一个响应者是控制器/其它 View 上一个响应者是父控件
    [super touchesBegan:touches withEvent:event];
    NSLog(@"touch begin");
    // 单点触摸：使用第一个参数
    // 一根手指对应一个 UITouch 对象
    // 保存着与手指有关的信息（触摸的位置、时间、阶段）
    // 当手指移动的过程中 UITouch 对象也会随之改变
    // ！！！好好研究一下 UITouch 对象！！！
    // iOS开发中避免使用双击
    UITouch *touch = [touches anyObject];
    // CGRect/CGSize/CGPoint/CGFloat都不是类
    CGPoint currentPoint = [touch locationInView:self.view];
    CGPoint lastPoint = [touch previousLocationInView:self.view];
    NSLog(@"当前触摸点%@=上次触摸点%@", NSStringFromCGPoint(currentPoint), NSStringFromCGPoint(lastPoint));
    NSLog(@"触摸产生时所处的窗口%@=触摸产生时所处的视图%@=短时间内点击屏幕的次数%lu=触摸时间%f",
          touch.window, touch.view, touch.tapCount, touch.timestamp);
    // 多点触摸：使用第二个参数
    // 每产生一个事件就会产生一个UIEvent对象
    NSSet *touchSet = [event allTouches];
    for (UITouch *touch in touchSet) {
        CGPoint currentPoint = [touch locationInView:self.view];
        CGPoint lastPoint = [touch previousLocationInView:self.view];
        NSLog(@"当前触摸点%@=上次触摸点%@", NSStringFromCGPoint(currentPoint), NSStringFromCGPoint(lastPoint));
        NSLog(@"触摸产生时所处的窗口%@=触摸产生时所处的视图%@=短时间内点击屏幕的次数%lu=触摸时间%f",
              touch.window, touch.view, touch.tapCount, touch.timestamp);
    }
    /**
     事件的产生和传递：
     第一步：
     1.发生触摸事件以后，系统会将该事件加入到一个由 UIApplication 管理的事件队列中
     2.UIApplication 会从事件队列中取出最前面的事件分发一下以便处理，通常先发送事件到 App 主窗口 / keyWindow
     3.主窗口会在视图层次结构中找到“一个最合适的视图”来处理触摸事件
     第二步：
     1.找到合适的视图控件以后就会调用视图控件的 touches 方法来做具体的事件处理
     2.触摸事件的传递是从父控件传递到子控件的（最后传递到自身控件）
     */
}
// 2. 一根/多根手指在 view 中移动
// 会持续调用
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch move");
    // 手指移动的同时让 UIView 移动可以实现 UIView 拖拽
}
// 3.一根/多根手指离开 view
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch end");
}
// 4.某个系统事件（电话呼入）打断触摸过程
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch cancel");
}


#pragma mark - 停靠模式
/**
 停靠模式Autoresize
 1>.概念 - 控制父视图改变大小时，子视图的变化方式；服务于父视图边界修改后，子视图的重新布局
 2>.作用 - 主要处理父子视图/等比例缩放/横竖屏旋转
 @property (strong,nonatomic) UIViewAutoresizing autoresizingMask;
 UIViewAutoresizingNone      = 0  //NO
 UIViewAutoresizingFlexibleLeftMargin   = 1 << 0  //右边界和父视图的距离不变，左边界自由
 UIViewAutoresizingFlexibleWidth    = 1 << 1  //自由的宽度：左右边距与父视图保持不变
 UIViewAutoresizingFlexibleRightMargin  = 1 << 2  //左边界和父视图的距离不变，右边界自由
 UIViewAutoresizingFlexibleTopMargin   = 1 << 3  //下边界和父视图的距离不变，上边界自由
 UIViewAutoresizingFlexibleHeight    = 1 << 4  //自由的高度，上下边距保持不变
 UIViewAutoresizingFlexibleBottomMargin  = 1 << 5  //上边界和父视图的距离不变，下边界自由
 3.在xib中怎么使用autoresizingMask：外部4根线固定边距、内部2根线固定宽高和父视图的比例
 */
-(void)setupAutoresize {
    // 创建父视图
    UIView *superView = [[UIView alloc] init];
    superView.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:superView];
    // 创建子视图
    UIView *subView = [[UIView alloc] init];
    subView.frame = CGRectMake(0, 0, 50, 25);
    [superView addSubview:subView];
    // 设置停靠模式
    subView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
}


#pragma mark - UIViewControllView
// UITabBarController/UINavigationController/UITableViewController
// 先执行 “init()方法” -> 执行 “loadView()方法”
-(void)setupController {
    // 颜色
    self.view.backgroundColor = UIColor.grayColor;
    // 模态跳转
    // 1.任何控制器都可以通过 “模态跳转”
    // 2.“模态跳转” 会将窗口上面的 View 移除，将需要 “模态跳转” 的 “控制器View” 添加到窗口上
    WMSkillViewController *conroller = [[WMSkillViewController alloc]init];
    // 设定动画样式
    conroller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    // 弹出
    // 当一个控制器被销毁 - 控制器View不一定会被销毁/控制器View的业务逻辑没法处理
    [self presentViewController:conroller animated:YES completion:^{
        // self.presentingViewController 强引用 WMSkillViewController
        NSLog(@"模态弹出%@", self.presentingViewController);
    }];
    // 消失
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"模态消失");
    }];
}
#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    // 是否可以选择这个控制器
    // YES可以/NO不可以
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    // 选中某一个控制器
}
- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    // 将要开始编辑
}
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed {
    // 结束编辑
}

#pragma mark - UINavigationBar导航条/UIToolBar工具条
-(void)setupNavigationBar {
    /// 0.创建导航视图控制器
    // 必须指定 RootViewController：通过push/pop管理UIViewController
    // 继承 UIViewController
    /*
     需要理解的内容：
     1.UINavigationController的常见属性和方法
     2.UINavigationController的层级关系
     3.UINavigationBar的常见属性和方法
     4.UINavigationItem的常见属性和方法
     */
    // 1.UINavigationController的常见属性和方法
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:self];
   // navigationController.childViewControllers, navigationController.viewControllers 有什么区别
    NSLog(@"获取导航控制器的顶部控制器=%@、获取导航控制器的可视控制器=%@、获取导航控制器的子控制器=%@、获取栈中视图控制器=%@", navigationController.topViewController, navigationController.visibleViewController, navigationController.childViewControllers, navigationController.viewControllers);
    
    /// 2.UINavigationController的层级关系（参见 UINavigationController 的层级结构 .png）
    /**
    1.UIWindow -> UINavigationController() -> 存放子控制器（通过栈的形式）
    2.rootViewController 的 view 添加到 UIWindow
    */
    // UITabBar隐藏
    self.hidesBottomBarWhenPushed = YES;
    // 压入栈 - 跳转到下一个 UIViewController
    [self.navigationController pushViewController:self animated:YES];
    // 返回到上一个 UIViewController / 会将上面的控制器移除（移除的控制器会销毁）
    [self.navigationController popViewControllerAnimated:YES]; // 移除栈顶控制器
    [self.navigationController popToViewController:self animated:YES]; // 移除指定控制器
    [self.navigationController popToRootViewControllerAnimated:YES];  // 移除栈底控制器
    
    /// 3.UINavigationBar的常见属性和方法
    // 1>.导航条（只有一个、默认不隐藏）
    // 继承 UIView
    // 设置导航控制器的风格
    // UINavigationBar *bar = navigationController.navigationBar; // 获取导航栏：只读变量
    /*
     UIBarStyleDefault  // 默认白色
     UIBarStyleBlack     // 黑色
     */
    // 坐标 {0, 20}
    navigationController.navigationBar.barStyle = UIBarStyleBlack; // 导航条样式
    navigationController.navigationBarHidden = YES;  // 导航条隐藏：默认不隐藏
    [navigationController setNavigationBarHidden:YES animated:YES];
    navigationController.navigationBar.translucent = YES; // YES半透明（表示坐标原点在屏幕左上角）/NO不透明（表示坐标原点在导航条左下角）
    navigationController.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image_demo"]]; // 左上角返回键字体颜色/以图片做为颜色
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1]; // 导航条颜色
    // 导航条/导航条上的控件设置 alpha 没有效果
    navigationController.navigationBar.alpha = 0;
    // 设置导航条背景（必须使用默认模式 UIBarMetricsDefault）
    // 当背景图片设置为 nil 的时候系统会自动生成一张半透明的图片为导航条背景
    [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"image_demo"] forBarMetrics:UIBarMetricsDefault];
    // 2>.工具条：默认隐藏
    // 一般不用（默认就是隐藏）
    navigationController.toolbarHidden = NO;
    navigationController.toolbar.barStyle = UIBarStyleBlack;
    navigationController.toolbar.translucent = NO;
    navigationController.toolbar.tintColor = UIColor.yellowColor;
    // 继承 UIView
    [self.navigationController setToolbarHidden:NO animated:YES];  // 设置"UIToolBar工具条"是否隐藏
    if (self.navigationController.toolbarHidden) {
        // UIToolBar工具条是否隐藏
    }
    
    /// 4.UINavigationItem 的常见属性和方法
    // 每个 UIViewController 都有一个 UINavigationItem
    // UINavigationItem 在 UINavigationBar上面，但是是由 UIViewController 控制 UINavigationItem
    // ！！！导航栏的内容取决于栈顶控制器的 UINavigationItem 属性/需要在 栈顶控制器 中设置！！！
    // self.navigationItem.backBarButtonItem - 左上角的返回按钮
    self.navigationItem.title = @"导航视图控制器";  // 标题
    self.navigationItem.titleView = [[UIView alloc]init]; // 标题视图
    /// 初始化 UIBarButtonItem 有多种方法
    // 1.定制系统 UIBarButtonItem
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAdd)];
    // 2.设置有图片的 UIBarButtonItem
    // 设置图片让图片不要渲染就可以保持图片颜色不会变成蓝色而保持原色
    // 可以直接在 Assets.xcassets 中设置/也可以通过代码设置
    UIImage *image1 = [UIImage imageNamed:@"image_demo"];
    [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(onImage)];
    // 3.设置有文字的：省略
    // 怎么让文字不要默认蓝色 - 如果需要修改字体颜色使用 “富文本”/参考 "eyee"
    // 4.自定义 UIBarButtonItem
    // 位置不需要设置/大小需要自己设置
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIBarButtonItem *customItem0 = [[UIBarButtonItem alloc]initWithCustomView: btn];
    // 让按钮自适应大小
    [btn sizeToFit];
    // 这两种写法有什么不同
    /*
     一个 UINavigationController 有若干个 UIViewController
     一个 UINavigationController 包含一个 navigationBar/toolbar
     navigationItem 在 navigationBar 的上面
     navigationItem 不是由 navigationBar 控制、也不是由 UINavigationController 控制
     navigationItem 是由当前 UIViewController 控制
     */
    // UIBarButtonItem 可以自定义 / UINavigationItem决定着显示内容 / 子控制器的属性
//    // 每个 "子控制器" 都有一个 navigationItem
//    self.navigationController.navigationItem.leftBarButtonItem = item0;  // 错误写法
    self.navigationItem.leftBarButtonItem = item0;   // 正确写法
    self.navigationItem.rightBarButtonItem = item1;
    self.navigationItem.leftBarButtonItems = @[item0, customItem0];
    self.navigationItem.rightBarButtonItems = @[item0, customItem0];
    self.navigationItem.hidesBackButton = YES;  // 隐藏返回按钮
//    self.navigationItem.prompt = @"加载中..."; // 一般不使用
    /// ！！！默认图片 / title都是蓝色！！！
    // 如果不需要图片蓝色使用 - UIImageRenderingModeAlwaysOriginal
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"image_demo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onAdd)];
    // 如果不需要设置文字蓝色 - 如果需要修改字体颜色使用 “富文本”/参考 "eyee"
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(onAdd)];
}
-(void)onAdd {
    /// 导航栏的跳转
    // self.navigationController 是否有值？？？取决于 self 是否加入导航控制器
    // 1.跳转到下一页
    WMSkillViewController *controller = [[WMSkillViewController alloc]init];
    [self.navigationController pushViewController:controller animated:true];
    // 2.返回上一页
    [self.navigationController popToViewController:controller animated:true];
    // 3.返回到任意页面
    // 这个页面必须是导航控制器的子控制器
    int index = 5;
    if (index < self.navigationController.viewControllers.count) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[index] animated:true];
    }
    // 4.回到根视图控制器
    [self.navigationController popToRootViewControllerAnimated:true];
}
-(void)onImage {
}
/**
 非主流框架搭建：
 UIWindow -> UINavigationController -> UITabBarController -> ChildViewControllers
 */


#pragma mark - TabBar
-(void)setupTabBar {
    // 分栏控制器
    // 继承 UIViewController
    // 最多显示 5 个
    // 1.创建 UITabBarController
    // 这里也有一个 UIView
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    tabBarController.view.backgroundColor = UIColor.redColor;
    // 2.添加子控制器
    [tabBarController addChildViewController:self];
//    tabBarController.viewControllers = @[self];
    // 3.设置属性
    tabBarController.selectedIndex = 0;  // 选中的 index
    /// tabBar
    // 只有一个
//    UITarBar *bar = tabBarController.tabBar;  // 获取 UITarBar
    tabBarController.tabBar.barStyle = UIBarStyleDefault; // UITabBar的样式
    tabBarController.tabBar.tintColor = UIColor.redColor; // 图标选中颜色
    tabBarController.tabBar.barTintColor = UIColor.yellowColor; // 分栏颜色
    tabBarController.tabBar.translucent = true;  // true透明/false不透明
    tabBarController.delegate = self;
    /// tabBarItem
    // 决定着每个 UITabBarButton 内容
    // ！！！每个 "子控制器" 都有一个 tabBarItem / UITabBarItem决定着显示内容 / 子控制器的属性！！！
    // 添加完成 "子控制器" 就需要设置下面属性
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    self.tabBarItem.title = @"";  // 标题文字/如果需要修改字体颜色使用 “富文本”/参考 "eyee"/iOS13.x以后设置方法有所改变
    self.tabBarItem.image = [UIImage imageNamed:@""]; // 图标
    self.tabBarItem.selectedImage = [UIImage imageNamed:@""]; // 选中的图标
    self.tabBarItem.badgeValue = @"5";  // 提醒数字
}
/**
主流框架搭建：
UIWindow -> UITabBarController -> UINavigationController -> ChildViewControllers
*/


#pragma mark - UIImagePickerController
// 相机、相册
-(void)setupImagePickerController {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    // 显示控件
    [picker presentViewController:picker animated:YES completion:^{
        
    }];
    // 隐藏控件
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - Masonry/SnapKit
-(void)setupMasory {
    // 设置布局 - makeConstraints
    
    // 重新布局（移除以前的布局）- remakeConstraints
    
    // 更新布局 - updateConstraints
    
    // 设置约束的优先级
    // 只要保证View已经add的情况下，我们不用按顺序布局（可以直接先布局底下的样式，再布局上部的样式）
    
    // 约束冲突 - https://blog.csdn.net/Haikuotiankong11111/article/details/51800761
}


#pragma mark - XIB
// 1>.概念 - 可视化文件，可以通过拖拽进行界面布局，实质是一个xml文件
// 2>.特征 - 只可以显示一个视图，在创建视图的时候可以同时创建（无需关联）
-(void)setupXib {
//    // 3>.通过xib新建UIViewController
//    WMSkillViewController *controller = [[WMSkillViewController alloc]initWithNibName:@"WMSkillViewController" bundle:nil];
    
    // 4>.获取xib
    // 第一种方式：创建一个xib
    // 拿到的可能多个
    // 默认选中第一个
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"xib名称" owner:nil options:nil];
    UIView *customView = nibs.firstObject;
    NSLog(@"%@", customView);
    // 第二种方式：创建一个xib
    UINib *nib = [UINib nibWithNibName:@"xib名称" bundle:nil];
    UIView *view = [nib instantiateWithOwner:nil options:nil].firstObject;
    NSLog(@"%@", view);
    
    // 5>.注意事项
    // 1、xib不支持[[xxx alloc]init]创建（就算已经关联View）
    // 2、xib创建的UIView不进入"-(instancetype)init{}方法"
    // 3、xib创建的UIView进入"-(instancetype)initWithCoder:(NSCoder *)aDecoder{}方法"/"-(void)awakeFromNib方法"
    // 4、用代码给"xib创建的子控件"添加子控件需要先唤醒
    
    // 6>.xib的加载原理
    
    
    // Segue
    // xxx需要在xib中设置
    [self performSegueWithIdentifier:@"xxx" sender:nil];
    /**
     1.command + D可以在 xib 中复制控件
     2.！！！删除 xib 需要删除 “代码部分”和“xib连线” 两处！！！
     */
}
// 准备跳转前调用
// 这样就可以实现跳转
// 一般不使用xib做跳转
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSLog(@"%@=====%@", segue.destinationViewController, segue.sourceViewController);
//    WMSkillViewController *controller = (WMSkillViewController *)segue.destinationViewController;
}

@end
