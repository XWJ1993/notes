//
//  MainController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/6/10.
//  Copyright © 2019 zali. All rights reserved.
//

#import "MainController.h"
#import <MessageUI/MessageUI.h>
// 2.在这里使用到 WMSkillViewController.h/m 的地方才需要导入 WMSkillViewController.h
#import "WMSkillViewController.h"

/// 常见设置常量的办法
// 1.宏定义
// 2.static xxx
// 3.枚举：OC语言的枚举 == 常量
#define NAME @"谢吴军"
@interface MainController () <MFMailComposeViewControllerDelegate>

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self sendEmail];
}

-(void)selected {
    NSString *key = @"key";
    NSString *childSelectorName = [NSString stringWithFormat:@"add%@", key];
    SEL childSelector = NSSelectorFromString(childSelectorName);
    if ([self respondsToSelector:childSelector]) {
//        // 这行代码有问题？？？
//        // https://www.jianshu.com/p/6517ab655be7
//        [self performSelector:childSelector withObject:nil];
    }
}
/// 发送邮件
// 添加 "系统库MessageUI.framework"
-(void)sendEmail {
    if ([MFMailComposeViewController canSendMail]) {
        /// 用户已设置邮件账户
        // 邮件服务器
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc]init];
        // 设置邮件代理
        [controller setMailComposeDelegate:self];
        // 设置邮件主题
        [controller setSubject:@"邮件主题"];
        // 设置收件人
        [controller setToRecipients:@[@"15601749931@163.com"]];
        // 设置抄送人
        [controller setCcRecipients:@[@"18642963201@163.com"]];
        // 设置密抄
        [controller setBccRecipients:@[@"1822512598@qq.com"]];
        // 设置邮件的正文内容/是否为HTML格式
        [controller setMessageBody:@"邮件的正文内容" isHTML:NO];
//        [controller setMessageBody:@"这里填写html代码块" isHTML:YES];
        // 弹出邮件发送视图
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        NSLog(@"----");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {
    [self dismissViewControllerAnimated:true completion:^{
        switch (result) {
            case MFMailComposeResultCancelled: {
                NSLog(@"用户取消编辑");
            }
                break;
            case MFMailComposeResultSaved: {
                NSLog(@"用户保存邮件");
            }
                break;
            case MFMailComposeResultSent: {
                NSLog(@"用户点击发送");
            }
                break;
            case MFMailComposeResultFailed: {
                NSLog(@"尝试保存或发送邮件失败：%@", [error localizedDescription]);
            }
            default:
                break;
        }
    }];
}
/// 添加字体
-(void)addFont {
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont fontWithName:@"Zapfino" size:15];
}
/// 3.遵循代理、实现方法
-(void)followDelegate {
    WMSkillViewController *controller = [[WMSkillViewController alloc]init];
    controller.delegate = self;
    controller.myBlock = ^(BOOL isBlue) {
        // 执行代码
    };
}
#pragma mark - WMSkillViewControllerProtocol
- (void)jumpPage:(NSString *)text {
    // 传值
}

#pragma mark - Objective-C语言专用注释

//#warning -还没有写完的代码

@end
