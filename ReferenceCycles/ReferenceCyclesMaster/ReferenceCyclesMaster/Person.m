//
//  Person.m
//  ReferenceCyclesMasterOc
//
//  Created by tlc on 2018/4/10.
//  Copyright © 2018年 tlc. All rights reserved.
//

#import "Person.h"

@interface Person()
{
    CallBackBlock _block;
}
@end

@implementation Person

- (instancetype)initWithName: (NSString *)name age: (NSUInteger)age {
    if (self = [super init]) {
        self.name = name;
        self.age  = age;
    }
    return self;
}

- (void)personAgeChange:(CallBackBlock)callBack {
    _block = callBack;
}

- (void)setAge:(NSUInteger)age {
    _age = age;
    
    if (_block) {
        _block();
    }
    
}

- (void)dealloc
{
    NSLog(@"person 释放");
}

@end
