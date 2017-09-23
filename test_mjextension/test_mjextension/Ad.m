//
//  Ad.m
//  test_mjextension
//
//  Created by lihe on 2017/8/19.
//  Copyright © 2017年 lihe. All rights reserved.
//

#import "Ad.h"
#import <MJExtension/MJExtension.h>

@implementation Ad

@end


@implementation StatusResult

+(void)load{
    [StatusResult mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"statuses" : @"Status",
                 // @"statuses" : [Status class],
                 @"ads" : @"Ad"
                 // @"ads" : [Ad class]
                 };
    }];
}


@end
