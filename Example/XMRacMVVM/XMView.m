//
//  XMView.m
//  XMRacMVVM_Example
//
//  Created by zhangxiaomeng on 2018/5/29.
//  Copyright © 2018年 zhangxiaomeng1. All rights reserved.
//

#import "XMView.h"

#import "XMModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface XMView ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UIButton *updateButton;

@end

@implementation XMView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
        [self bindData];
    }
    return self;
}

- (void)bindData {
    
    @weakify(self);
    
    // 第一种
    RAC(self.nameLabel ,text) = RACObserve(self, name);
    RAC(self.ageLabel, text) = RACObserve(self, age);
    
    // 第二种
    [RACObserve(self, ViewModel) subscribeNext:^(XMModel *XMModel) {
        @strongify(self);
        self.nameLabel.text = XMModel.name;
        self.ageLabel.text = @(XMModel.age).stringValue;
    }];
}

- (void)setupView {
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [self addSubview:self.nameLabel];
    
    self.ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 30)];
    [self addSubview:self.ageLabel];
    
    self.updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.updateButton.frame = CGRectMake(100, 300, 100, 30);
    [self.updateButton setBackgroundColor:[UIColor redColor]];
    [self.updateButton setTitle:@"更新" forState:UIControlStateNormal];
    [self addSubview:self.updateButton];
}

- (RACSignal *)updateDate {
    return [[self.updateButton rac_signalForControlEvents:UIControlEventTouchUpInside]
            flattenMap:^RACStream *(id value) {
                
                XMModel *model = [[XMModel alloc] init];
                model.name = @"张三";
                NSInteger age = arc4random() % 100;
                model.age = age;
                
                // 传递事件
                if ([self.viewDelegate respondsToSelector:@selector(smk_view:withEvents:)]) {
                    [self.viewDelegate smk_view:self withEvents:@{@"updateDate": model}];
                }

                return [RACSignal return:model];
            }];
}
@end
