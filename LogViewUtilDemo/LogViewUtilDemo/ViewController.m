//
//  ViewController.m
//  LogViewUtilDemo
//
//  Created by shaowei on 10/29/14.
//  Copyright (c) 2014 shede333. All rights reserved.
//

#import "ViewController.h"
#import "SWViewUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [SWViewUtil logView:self.navigationController.navigationBar info:SWViewLogInfoOfClassName|SWViewLogInfoOfFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
