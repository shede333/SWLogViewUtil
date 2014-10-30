//
//  TabBarController.m
//  LogViewUtilDemo
//
//  Created by shaowei on 10/29/14.
//  Copyright (c) 2014 shede333. All rights reserved.
//

#import "TabBarController.h"
#import "SWViewUtil.h"

@implementation TabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //一下三条都是等效的
//    [SWViewUtil logView:self.view info:SWViewLogInfoOfClassName | SWViewLogInfoOfFrame];
//    SWLogView(self.view, SWViewLogInfoOfClassName | SWViewLogInfoOfFrame)
    SWLogViewDefault(self.view);
}

@end
