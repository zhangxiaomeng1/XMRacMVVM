//
//  XMViewController.m
//  XMRacMVviewModel
//
//  Created by zhangxiaomeng1 on 05/29/2018.
//  Copyright (c) 2018 zhangxiaomeng1. All rights reserved.
//

#import "XMViewController.h"
#import "XMViewModel.h"
#import "XMView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface XMViewController ()<XMProtocol>

@property (nonatomic, strong) XMViewModel *viewModel;

@property (nonatomic, strong) XMView *firstView;

@end

@implementation XMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.viewModel = [[XMViewModel alloc] init];
    
    self.firstView = [[XMView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500)];
    [self.view addSubview:self.firstView];
    
    [self loadData];
    
    [self bindData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    
    [[self.viewModel loadData] subscribeNext:^(id x) {
        RACTupleUnpack(NSString *name, NSString *age, XMViewModel *model) = x;
        NSLog(@"%@------%@------%@", name, age, model);
    }];
}

- (void)bindData {
    
    // 第一种写法
    @weakify(self);
    RAC(self.firstView , name) = RACObserve(self.viewModel, nameString);
    RAC(self.firstView, age) = RACObserve(self.viewModel, ageString);
    
    self.firstView.viewDelegate = self;
    
    // 第二种写法
    RAC(self.firstView, ViewModel) = RACObserve(self.viewModel, ViewModel);
    
    [[self.firstView updateDate] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel updateModel:x];
    }];
}
- (void)smk_view:(UIView *)view withEvents:(NSDictionary *)events{
    NSLog(@"=====withEvents==%@",events);

}

@end
