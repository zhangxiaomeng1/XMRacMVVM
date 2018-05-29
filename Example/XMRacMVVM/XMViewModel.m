//
//  XMViewModel.m
//  XMRacMVVM_Example
//
//  Created by zhangxiaomeng on 2018/5/29.
//  Copyright © 2018年 zhangxiaomeng1. All rights reserved.
//

#import "XMViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface XMViewModel ()

@property (nonatomic, copy, readwrite) NSString *nameString;
@property (nonatomic, copy, readwrite) NSString *ageString;

@property (nonatomic, strong) NSDictionary *stringDict;

/** 模型 */
@property (nonatomic, strong, readwrite) XMViewModel *ViewModel;

@end

@implementation XMViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.stringDict = @{
                            @"name": @"周",
                            @"age" : @12
                            };
    }
    return self;
}

- (RACSignal *)loadData {
    
    self.nameString = self.stringDict[@"name"];
    self.ageString = [self.stringDict[@"age"] stringValue];
    
    
    XMViewModel *model = [[XMViewModel alloc] init];
    model.name = self.stringDict[@"name"];
    model.age = [self.stringDict[@"age"] integerValue];
    self.ViewModel = model;
    
    RACTuple *tuple = RACTuplePack(self.nameString, self.ageString, model);
    return [RACSignal return:tuple];
}

- (void)updateModel:(XMViewModel *)model {
    self.ViewModel = model;
}

@end
