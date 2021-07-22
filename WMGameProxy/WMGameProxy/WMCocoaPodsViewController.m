//
//  WMCocoaPodsViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2021/4/22.
//  Copyright © 2021 zali. All rights reserved.
//

#import "WMCocoaPodsViewController.h"

@interface WMCocoaPodsViewController ()

@end

@implementation WMCocoaPodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)cocoaPods {
    // 安装Cocoapods - https://segmentfault.com/a/1190000011428874
    
    // 使用Cocoapods - xxx
    /*
     cd ./project
     pod init
     pod install --no-repo-update
     #Podfile
     platform :ios, '8.0'
     target '项目名' do
     use_frameworks!
     pod 'NSLogger'
     pod 'AFNetworking'
     pod 'FMDB'
     pod 'UICKeyChainStore'
     pod 'SCLAlertView-Objective-C'
     pod 'FTIndicator/FTProgressIndicator'
     pod 'FTIndicator/FTToastIndicator'
     pod 'IQKeyboardManager'
     pod 'MKDropdownMenu'
     
     pod 'CLGO', :git => 'ssh://git@git.changmeng.com/ios/sdk.v3.8.git', :branch => 'appstore-bt'
     end
     pod update --no-repo-update
     //升级本机pod库
     pod repo update master
     */
    
    // 利用CocoaPods制作静态库
    /*
     // 打包
     # sudo gem install cocoapods-packager
     # cd ./xxx.podspec
     # pod package CLGO.podspec --force --verbose // 常规打包
     # pod package CLGO.podspec --force --no-mangle --verbose // 含.a的打包
     */
#pragma mark - 面试题
    // 1.pod update/pod install的区别？
    // 2.pod update/pod update --verbose --no-repo-update的区别？
    // 3.Podfile.lock是什么意思？
}

-(void)git {
    
}

-(void)svn {
    
}

@end
