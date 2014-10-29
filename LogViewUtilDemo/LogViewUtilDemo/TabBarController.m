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
    [SWViewUtil logView:self.view info:SWViewLogInfoOfClassName | SWViewLogInfoOfFrame];
}

@end
