//
//  Person.h
//  ReferenceCyclesMasterOc
//
//  Created by tlc on 2018/4/10.
//  Copyright © 2018年 tlc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBackBlock)(void);

@interface Person : NSObject

@property(nonatomic, nonnull, copy) NSString *name;
@property(nonatomic, assign) NSUInteger age;

- (instancetype)initWithName: (NSString *)name age: (NSUInteger)age;
- (void)personAgeChange:(CallBackBlock)callBack;

@end
