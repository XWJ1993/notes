//
//  WMFoundationNSObject.h
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/7/22.
//  Copyright © 2019 zali. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 枚举类型：实质是一个整数
// 指定第一个整数，后面的会依次递增
// 也可以置顶莫一个为多少
// 一般配合 switch 使用
typedef enum {
    kMovingTop = 10,
    kMovingLeft,
    kMovingRight,
    kMovingBottom = 100,
}kMoving;

@interface WMFoundationNSObject : NSObject

-(void)showObject;
-(void)log;
// OC中的()只有一个作用：用来括住数据类型
-(void)logger:(NSString *)text;

-(void)showString;

-(void)showArray;

-(void)showDictionary;

-(void)showSet;

-(void)showNumber;

-(void)showValue;

-(void)showNull;

-(void)showDate;

@end

NS_ASSUME_NONNULL_END
