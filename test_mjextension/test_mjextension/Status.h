//
//  Status.h
//  test_mjextension
//
//  Created by lihe on 2017/8/19.
//  Copyright © 2017年 lihe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface Status : NSObject
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Status *retweetedStatus;

@end
