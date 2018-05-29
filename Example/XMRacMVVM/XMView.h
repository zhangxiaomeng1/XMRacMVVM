//
//  XMView.h
//  XMRacMVVM_Example
//
//  Created by zhangxiaomeng on 2018/5/29.
//  Copyright © 2018年 zhangxiaomeng1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMProtocol.h"

@class XMModel, RACSignal;

@interface XMView : UIView 

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;

@property (nonatomic, strong)  XMModel *ViewModel;

- (RACSignal *)updateDate;

/**
 *  viewDelegate 传递事件
 */
@property (nonatomic, weak) id<XMProtocol> viewDelegate;

@end
