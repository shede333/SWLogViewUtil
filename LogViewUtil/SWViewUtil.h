//
//  SWViewUtil.h
//  TestViewLog
//
//  Created by shaowei on 10/29/14.
//  Copyright (c) 2014 shede333. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, SWViewLogInfo) {
    SWViewLogInfoOfAll =                    0, //输出所有信息
    SWViewLogInfoOfClassName =              1 << 0,
    SWViewLogInfoOfFrame =                  1 << 1,
    SWViewLogInfoOfInstanceDescription =    1 << 2,
};

@interface SWViewUtil : NSObject

+ (void)logView:(UIView *)rootView info:(SWViewLogInfo)logInfo;

@end
