//
//  ViewController.m
//  ReferenceCyclesMasterOc
//
//  Created by tlc on 2018/4/10.
//  Copyright © 2018年 tlc. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "WeakProxy.h"

@interface ViewController ()
{
    Person *_person;
}
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _person = [[Person alloc] initWithName:@"张三" age:23];
    __weak typeof(self)weakSelf = self;
    
    // 类方法就不用
    [UIView animateWithDuration:1 animations:^{
        
    }];
    
    [_person personAgeChange:^{
        /**
         * 在block中需要多次使用weakself时要转成strongSelf，这样确保在block执行完成之前不被释放掉
         */
//        __strong typeof(self) strongSelf = weakSelf;
        [weakSelf updateContent];
    }];
    
    [self updateContent];
    
    // oc
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[WeakProxy proxyWithTarget:self] selector:@selector(timerAction) userInfo:nil repeats:true];
}

- (void)timerAction {
    NSLog(@"zzzzz");
}

- (void)updateContent{
    _msgLabel.text = [NSString stringWithFormat:@"name:%@, age: %lu", _person.name, (unsigned long)_person.age];
}


- (void)doSomething {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 10; i++) {
            sleep(1);// 暂停的是当前线程
            NSLog(@"%d",i);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"完成");
        });
    });
}

- (void)doOtherThing {
    NSLog(@"asdff");
}

- (IBAction)decreaseAction:(id)sender {
    _person.age -= 1;
}

- (IBAction)increscentAction:(id)sender {
    _person.age += 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"viewcontroller 释放");
    
    [_timer invalidate];
    _timer = NULL;
}

@end
