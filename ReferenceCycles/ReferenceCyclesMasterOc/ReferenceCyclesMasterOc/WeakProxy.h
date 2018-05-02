//
//  WeakProxy.h
//  ReferenceCyclesMasterOc
//
//  Created by tlc on 2018/5/2.
//  Copyright © 2018年 tlc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakProxy : NSProxy

@property (nullable, nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)proxyWithTarget:(id)target;

@end
