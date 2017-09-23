//
//  Ad.h
//  test_mjextension
//
//  Created by lihe on 2017/8/19.
//  Copyright © 2017年 lihe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ad : NSObject
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *url;
@end

@interface StatusResult : NSObject
/** Contatins status model */
@property (strong, nonatomic) NSMutableArray *statuses;
/** Contatins ad model */
@property (strong, nonatomic) NSArray *ads;
@property (strong, nonatomic) NSNumber *totalNumber;
@end
