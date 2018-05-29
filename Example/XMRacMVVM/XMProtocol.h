//
//  XMProtocol.h
//  XMRacMVVM_Example
//
//  Created by zhangxiaomeng on 2018/5/29.
//  Copyright © 2018年 zhangxiaomeng1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol XMProtocol <NSObject>

/**
 *  将view中的事件通过代理传递出去
 *
 *  @param view   view自己
 *  @param events 所触发事件的一些描述信息
 */
- (void)smk_view:(UIView *)view withEvents:(NSDictionary *)events;

@end
