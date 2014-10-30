//
//  SWViewUtil.m
//  TestViewLog
//
//  Created by shaowei on 10/29/14.
//  Copyright (c) 2014 shede333. All rights reserved.
//

#import "SWViewUtil.h"

@implementation SWViewUtil


#pragma mark - Function - Public
+ (void)logView:(UIView *)rootView info:(SWViewLogInfo)logInfo{
    printf("\n***************************\n");
    
//    [self log1View:rootView info:logInfo level:0]; //输出样式1
//    NSLog(@"\n\n\n\n");
//    [self log2View:rootView info:(SWViewLogInfo)logInfo level:0  prefixStr:nil ]; //输出样式2
//    NSLog(@"\n\n\n\n");
    [self log3View:rootView info:(SWViewLogInfo)logInfo level:0  prefixStr:nil ]; //输出样式3
    
    printf("\n***************************\n");
}

#pragma mark - Function - Private

//输出样式1
+ (void)log1View:(UIView *)rootView info:(SWViewLogInfo)logInfo level:(NSInteger)level {
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
            [self log1View:subView info:(SWViewLogInfo)logInfo level:(level+1)];
        }
    }
    
}

//输出样式2
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
    printf("%ld-",level);
    [self printfView:rootView info:logInfo];
    printf("\n");
    
    if ([subViews count]) {
        for (UIView *subView in subViews) {
            [self log2View:subView info:(SWViewLogInfo)logInfo level:(level+1) prefixStr:nextPrefixStr];
            
        }
        
        //输出 结束 长横线
        printf("%s\n",[[nextPrefixStr stringByAppendingString:horizentalLine] UTF8String]);
    }
}

//输出样式3
+ (NSDictionary *)log3View:(UIView *)rootView info:(SWViewLogInfo)logInfo level:(NSInteger)level prefixStr:(NSString *)prefixStr{
    
    NSArray *subViews = [rootView subviews];
    NSInteger arrCount = [subViews count];
    
    static NSString *minSpaceStr = @"  ";
    static NSString *minLineStr = @"__";
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
    printf("%ld-",level);
    [self printfView:rootView info:logInfo];
    printf("\n");
    
    NSDictionary *endLineInfo = nil;
    if (arrCount > 0) {
        NSInteger i = 0;
        for (UIView *subView in subViews) {
            endLineInfo = [self log3View:subView info:(SWViewLogInfo)logInfo level:(level+1) prefixStr:nextPrefixStr];
            i++;
            if ((arrCount != i) && endLineInfo) {
                // 不是最后一条, 输出 结束 长横线
                NSInteger lastLevel = [endLineInfo[@"level"] integerValue];
                if ((lastLevel - level) <= 1) {
                    printf("%s\n",[endLineInfo[@"content"] UTF8String]);
//                    printf("%s\n",[nextPrefixStr UTF8String]);
                }else{
                    NSString *lineStr = [nextPrefixStr stringByAppendingFormat:@"%@%@",minSpaceStr,verticalLine];
                    for (int i1 = 0; i1 < (lastLevel-level - 1); i1++) {
                        lineStr = [lineStr stringByAppendingFormat:@"%@%@",minLineStr,verticalLine];
                    }
                    
                    printf("%s\n",[[lineStr stringByAppendingString:horizentalLine] UTF8String]);
                }
            }
        }
        
        NSInteger tmpLevel = level;
        if (endLineInfo != nil) {
            tmpLevel = [endLineInfo[@"level"] integerValue];
        }
        endLineInfo = @{@"content":[nowPrefixStr stringByAppendingFormat:@"|%@",horizentalLine],
                        @"level":@(tmpLevel)};
        
    }
    
    if ((level == 0) && endLineInfo) {
        printf("%s",[endLineInfo[@"content"] UTF8String]);
    }
    
    return endLineInfo;
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
