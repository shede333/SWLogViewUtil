//
//  SWViewUtil.m
//  TestViewLog
//
//  Created by shaowei on 10/29/14.
//  Copyright (c) 2014 shede333. All rights reserved.
//

#import "SWViewUtil.h"

@implementation SWViewUtil

+ (void)logView:(UIView *)rootView info:(SWViewLogInfo)logInfo{
    printf("\n***************************\n");
    
    [self logView:rootView level:0  info:(SWViewLogInfo)logInfo];
    
    
    
    printf("\n***************************\n");
}

+ (void)logView:(UIView *)rootView level:(NSInteger)level  info:(SWViewLogInfo)logInfo{
    NSString *prefixStr = @"";
    static NSString *minSpaceStr = @"   ";
    static NSString *brStr = @"|__";
    static NSString *symbolStr = @"|";
    for (int i = 0; i <level; i++) {
        prefixStr = [prefixStr stringByAppendingString:minSpaceStr];
    }
 
    printf("%s",[[prefixStr stringByAppendingString:symbolStr] UTF8String]);
    printf("%ld-",level);
    [self printfView:rootView info:logInfo];
    
    NSArray *subViews = [rootView subviews];
    if ([subViews count]) {
        //输出 "\"
        printf("%s\n",[[prefixStr stringByAppendingString:brStr] UTF8String]);
        
        for (UIView *subView in subViews) {
            [self logView:subView level:(level+1)  info:(SWViewLogInfo)logInfo];
        }
    }
    
}

+ (void)printfView:(UIView *)rootView info:(SWViewLogInfo)logInfo{
    
    if ((logInfo & SWViewLogInfoOfClassName) || (logInfo == SWViewLogInfoOfAll)) {
        printf("className:%s,",[NSStringFromClass([rootView class]) UTF8String]);
    }
    
    if ((logInfo & SWViewLogInfoOfFrame) || (logInfo == SWViewLogInfoOfAll)) {
        printf("frame:%s,",[NSStringFromCGRect(rootView.frame) UTF8String]);
    }
    
    if ((logInfo & SWViewLogInfoOfInstanceDescription) || (logInfo == SWViewLogInfoOfAll)) {
        printf("descrption:%s,",[[rootView description] UTF8String]);
    }
    
    printf("\n");
}

@end
