//
//  XMViewModel.h
//  XMRacMVVM_Example
//
//  Created by zhangxiaomeng on 2018/5/29.
//  Copyright © 2018年 zhangxiaomeng1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveViewModel/ReactiveViewModel.h>

@class RACSignal, XMViewModel;

@interface XMViewModel : RVMViewModel

@property (nonatomic, copy, readonly) NSString *nameString;
@property (nonatomic, copy, readonly) NSString *ageString;

/** 模型 */
@property (nonatomic, strong, readonly) XMViewModel *ViewModel;

- (RACSignal *)loadData;

- (void)updateModel:(XMViewModel *)model;


@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end
