//
//  WMJumpViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2020/3/18.
//  Copyright © 2020 zali. All rights reserved.
//

#import "WMJumpViewController.h"

@interface WMJumpViewController ()

@end

@implementation WMJumpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 1.应用间跳转/scheme(skim)
 0>.https://blog.csdn.net/cc1991_/article/details/79050275
 1>.如果想要跳转到不同的App - 1.定义需要跳转到的App的“协议/scheme”/2.打开对应App的“协议/scheme”
 2>.应用间跳转代表进程之间可以通信/线程之间也可以通信
 */
-(void)setupJump {
    /**
     1>.URL的组成
     scheme协议 - http
     host主机名 - www.520it.com
     path路径 - /query
     query查询 - name=sz&age=18
     */
    NSURL *url = [NSURL URLWithString:@"http://www.520it.com/query?name=sz&age=18"];
    NSLog(@"协议 = %@/ 主机名 = %@/ 资源路径 = %@/ 请求参数 = %@", url.scheme, url.host, url.path, url.query);
    /**
     2.应用间跳转 - 从 "应用A -> 应用B"
     1>.先在 “应用B” 设置 “scheme协议”（注意不要加上"://"）
     2>.iOS9.0以后 - 再在“应用A”上添加白名单/ info.plist -> LSApplicationQueriesSchemes（注意不要加上"://"）
     3>.写代码实现跳转
     */
    NSURL *schemeUrl = [NSURL URLWithString:@"scheme协议://"];
    if ([[UIApplication sharedApplication] canOpenURL:schemeUrl]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:schemeUrl options:@{} completionHandler:^(BOOL success) {
                
            }];
        } else {
            [[UIApplication sharedApplication] canOpenURL:schemeUrl];
        }
    } else {
        NSLog(@"尚未安装App");
    }
    /**
     3.应用跳转到指定页面
     1>.在 “2” 的基础上添加一个标识 -> 根据标识在 “AppDelegate回调” 中自行处理
     2>.详情见"AppDelegate.m"应用间跳转
     */
    NSURL *pUrl = [NSURL URLWithString:@"scheme协议://pengyouquan"];
    if ([[UIApplication sharedApplication] canOpenURL:pUrl]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:pUrl options:@{} completionHandler:^(BOOL success) {
                
            }];
        } else {
            [[UIApplication sharedApplication] canOpenURL:pUrl];
        }
    } else {
        NSLog(@"尚未安装App");
    }
    
//    4.打电话、发短信、发邮件
//    1>.https://blog.csdn.net/cc1991_/article/details/74990013
}

/**
 2.社交分享
 1>.对于系统自带的分享 - 如果是分享到短信、邮箱,需要导入MessageUI系统库,然后创建分
 享;如果是分享到新浪微博、腾讯微博,需要导入Social系统库,然后分享创建。优点：不需要集
 成第三方库,不需要App Key;缺点：页面简单,不能自定制
 2>.对于第三方分享 - 一般使用shareSDK，首先进入shareSDK官网获取App Key，集成shareSDK，
 想要分享至哪些平台就去相应开放平台申请AppKey和AppSecret，然后按照文档构建分享内容
 http://blog.csdn.net/leaf8742
 https://www.jianshu.com/p/1a94498de7f4
 https://www.jianshu.com/p/2e1b3f54b4f3
 https://www.jianshu.com/p/71499300a133
 https://www.cnblogs.com/xubojoy/p/3885932.html
 https://blog.csdn.net/qq_28009573/article/details/77744001
 */

/**
 3.第三方登录 - 基于OAuth2.0协议构建的OAuth2.0授权登录系统
 1>.微信登录：只提供原生登录方式(必须安装客户端)，所有使用之前必须判断；
 https://www.cnblogs.com/sunfuyou/p/7843612.html
 2>.QQ登录：xxx
 https://blog.csdn.net/alexander_wei/article/details/72626396
 https://www.jianshu.com/p/133d84042483
 3>.微博登录：xxx
 https://blog.csdn.net/zhonggaorong/article/details/51724810
 https://blog.csdn.net/u010545480/article/details/53004699
 https://www.jianshu.com/p/87d1d397d269
 */

// 4.应用统计

// 5.第三方支付

@end
