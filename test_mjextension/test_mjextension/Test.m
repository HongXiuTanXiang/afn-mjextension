//
//  Test.m
//  test_mjextension
//
//  Created by lihe on 2017/9/23.
//  Copyright © 2017年 lihe. All rights reserved.
//

#import "Test.h"
#import <MJExtension/MJExtension.h>

@implementation Test

+(void)load{
    
    [Test mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
}

@end
