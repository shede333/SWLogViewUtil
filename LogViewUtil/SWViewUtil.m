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
    
//    [self logView:rootView info:logInfo level:0];
    [self log2View:rootView info:(SWViewLogInfo)logInfo level:0  prefixStr:nil ];
    
    printf("\n***************************\n");
}

+ (void)logView:(UIView *)rootView info:(SWViewLogInfo)logInfo level:(NSInteger)level {
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
    printf("\n");
    
    NSArray *subViews = [rootView subviews];
    if ([subViews count]) {
        //输出 "\"
        printf("%s\n",[[prefixStr stringByAppendingString:brStr] UTF8String]);
        
        for (UIView *subView in subViews) {
            [self logView:subView info:(SWViewLogInfo)logInfo level:(level+1)];
        }
    }
    
}

+ (void)log2View:(UIView *)rootView info:(SWViewLogInfo)logInfo level:(NSInteger)level prefixStr:(NSString *)prefixStr{
    
    NSArray *subViews = [rootView subviews];
    
    static NSString *minSpaceStr = @"  ";
//    static NSString *brStr = @"|__";
    static NSString *verticalLine = @"|";
    static NSString *horizentalLine = @"__________________________________________________________________________________";
    
    NSString *nowPrefixStr =prefixStr;
    if (level == 0) {
        nowPrefixStr = @"";
    }else{
        nowPrefixStr = [prefixStr stringByAppendingString:minSpaceStr];
    }
    
    if ([subViews count]) {
        //输出 开始 长横线
        printf("%s\n",[[nowPrefixStr stringByAppendingString:horizentalLine] UTF8String]);
    }
    
    //输出前缀
    NSString *nextPrefixStr = [nowPrefixStr stringByAppendingString:verticalLine];
    printf("%s",[nextPrefixStr UTF8String]);
    printf("%ld_",level);
    [self printfView:rootView info:logInfo];
    printf("\n");
    
    if ([subViews count]) {
        for (UIView *subView in subViews) {
            [self log2View:subView info:(SWViewLogInfo)logInfo level:(level+1) prefixStr:nextPrefixStr];
            
        }
        
        //输出 结束 长横线
        printf("%s\n",[[nowPrefixStr stringByAppendingFormat:@"|%@",horizentalLine] UTF8String]);
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
    
    
}

@end
