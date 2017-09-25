//
//  ViewController.m
//  test_mjextension
//
//  Created by lihe on 2017/8/19.
//  Copyright © 2017年 lihe. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import <MJExtension/MJExtension.h>
#import "Status.h"
#import "Ad.h"
#import "Bag.h"
#import <AFNetworking/AFNetworking.h>
#import "Key.h"
#import "Test.h"

@interface ViewController ()

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Test *testmodel;
@property (nonatomic, strong) Key *keymodel;

@end

@implementation ViewController

//newfeature
void newfunc(){
    
}

//develops上开发人员在开发
-(void)developNew{

}

//函数名就是函数的地址
int funcA(int a,int b){
    
    return a + b;
}

void funcB(int (*test)(int,int)){
    
    int a = 4,b = 5;
    int c = test(a,b);
    NSLog(@"%d",c);
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //函数指针作为函数参数,直接传函数名字就可以了
    funcB(funcA);
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager GET:@"http://jsonplaceholder.typicode.com/posts/1" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = @{@"test":responseObject};
        [dic writeToFile:@"/Users/lihe/Desktop/test.plist" atomically:YES];
        NSLog(@"%@",responseObject);

        _keymodel = [Key mj_objectWithKeyValues:dic];
        NSLog(@"%@",_keymodel.test.title);
        NSLog(@"%zd",_keymodel.test.ID);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}



//Model -> JSON【将一个模型转成字典】
- (void)test6 {
    // New model
    User *user = [[User alloc] init];
    user.name = @"Jack";
    user.icon = @"lufy.png";
    
    Status *status = [[Status alloc] init];
    status.user = user;
    status.text = @"Nice mood!";
    
    NSDictionary *dic = user.mj_keyValues;
    NSLog(@"%@",dic);
}

//JSON array -> model array【将一个 字典数组 转成 模型数组】
- (void)test5 {
    NSArray *dictArray = @[
                           @{
                               @"name" : @"Jack",
                               @"icon" : @"lufy.png"
                               },
                           @{
                               @"name" : @"Rose",
                               @"icon" : @"nami.png"
                               }
                           ];
    
    NSArray *arr = [User mj_objectArrayWithKeyValuesArray:dictArray];
    
    for (User *user in arr) {
        NSLog(@"%@",user.name);
    }
    
}


//Model name - JSON key mapping【模型中的属性名和字典中的key不相同(或者需要多级映射)】
- (void)test4 {
    [Student mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 @"desc" : @"desciption",
                 @"oldName" : @"name.oldName",
                 @"nowName" : @"name.newName",
                 @"nameChangedTime" : @"name.info[1].nameChangedTime",
                 @"bag" : @"other.bag"
                 };
    }];
    
    
    NSDictionary *dict = @{
                           @"id" : @"20",
                           @"desciption" : @"kids",
                           @"name" : @{
                                   @"newName" : @"lufy",
                                   @"oldName" : @"kitty",
                                   @"info" : @[
                                           @"test-data",
                                           @{
                                               @"nameChangedTime" : @"2013-08"
                                               }
                                           ]
                                   },
                           @"other" : @{
                                   @"bag" : @{
                                           @"name" : @"a red bag",
                                           @"price" : @100.7
                                           }
                                   }
                           };
    
    
    Student *status = [Student mj_objectWithKeyValues:dict];
    
    NSLog(@"%@",status.bag.name);
}

//模型里有字典或数组,字典和数组中又放着模型
- (void)test3 {
    //确定StatusResult的statuses和ads里存放的是什么模型
    [StatusResult mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"statuses" : @"Status",
                 // @"statuses" : [Status class],
                 @"ads" : @"Ad"
                 // @"ads" : [Ad class]
                 };
    }];
    
    
    
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"Nice weather!",
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   @{
                                       @"text" : @"Go camping tomorrow!",
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   ],
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.ad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.ad02.com"
                                       }
                                   ],
                           @"totalNumber" : @"2014"
                           };
    
    
    // JSON -> StatusResult
    StatusResult *result = [StatusResult mj_objectWithKeyValues:dict];
    
    NSLog(@"totalNumber=%@", result.totalNumber);
    // totalNumber=2014
    
    // Printing
    for (Status *status in result.statuses) {
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
        NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    }
    // text=Nice weather!, name=Rose, icon=nami.png
    // text=Go camping tomorrow!, name=Jack, icon=lufy.png
    
    // Printing
    for (Ad *ad in result.ads) {
        NSLog(@"image=%@, url=%@", ad.image, ad.url);
    }

}

//Model里包含Model
- (void)test2 {
    NSDictionary *dict = @{
                           @"text" : @"Agree!Nice weather!",
                           @"user" : @{
                                   @"name" : @"Jack",
                                   @"icon" : @"lufy.png"
                                   },
                           @"retweetedStatus" : @{
                                   @"text" : @"Nice weather!",
                                   @"user" : @{
                                           @"name" : @"Rose",
                                           @"icon" : @"nami.png"
                                           }
                                   }
                           };
    
    
    Status *status = [Status mj_objectWithKeyValues:dict];
    
    NSString *text = status.text;
    NSString *name = status.user.name;
    NSString *name1 = status.retweetedStatus.user.name;
    
    NSLog(@"%@,%@,%@",text,name,name1);
}

//JSONString -> Model【JSON字符串转模型】
- (void)test1 {
    NSString *jsonString = @"{\"name\":\"Jack\", \"icon\":\"lufy.png\", \"age\":20}";
    User *user = [User mj_objectWithKeyValues:jsonString];
    NSLog(@"name=%@, icon=%@, age=%d", user.name, user.icon, user.age);
    // name=Jack, icon=lufy.png, age=20
}

//The most simple JSON -> Model【最简单的字典转模型】
- (void)test0 {
    
    NSDictionary *dict = @{
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @20,
                           @"height" : @"1.55",
                           @"money" : @100.9,
                           @"sex" : @(SexFemale),
                           @"gay" : @"true"
                           //   @"gay" : @"1"
                           //   @"gay" : @"NO"
                           };
    
    
    User *user = [User mj_objectWithKeyValues:dict];
    NSLog(@"name=%@, icon=%@, age=%zd, height=%@, money=%@, sex=%d, gay=%d", user.name, user.icon, user.age, user.height, user.money, user.sex, user.gay);
    // name=Jack, icon=lufy.png, age=20, height=1.550000, money=100.9, sex=1
}




@end
