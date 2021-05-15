//
//  ViewController.m
//  JQ_rw_lock
//
//  Created by 吕佳骐 on 2021/5/15.
//

#import "ViewController.h"
#import "JQ_rw_lock.h"
#import "JQ_rw_opt_lock.h"
#import "JQ_rw_operation.h"

@interface ViewController ()

@property(nonatomic,strong) NSObject<JQ_rw_lock_protocol> *rwLock;
@property(nonatomic,strong) JQ_rw_operation *rw_operation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"JQ_rw_opt_lock" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(50, 100, 200, 50);
    btn1.backgroundColor = [UIColor blueColor];
    [btn1 addTarget:self action:@selector(operation1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"JQ_rw_lock" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor blueColor];
    [btn2 addTarget:self action:@selector(operation2) forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(50, 200, 200, 50);
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"JQ_rw_operation" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor blueColor];
    [btn3 addTarget:self action:@selector(operation3) forControlEvents:UIControlEventTouchUpInside];
    btn3.frame = CGRectMake(50, 300, 200, 50);
    [self.view addSubview:btn3];
    
}

-(void)operation1{
     self.rwLock = [[JQ_rw_lock alloc] init];
     [self read];
     [self read];
     [self write];
     [self read];
     [self read];
     [self write];
}

-(void)operation2{
     self.rwLock = [[JQ_rw_opt_lock alloc] init];
     [self read];
     [self read];
     [self write];
     [self read];
     [self read];
     [self write];
}

-(void)operation3{
    self.rw_operation = [[JQ_rw_operation alloc] init];
    [self.rw_operation read:nil];
    [self.rw_operation read:nil];
    [self.rw_operation write:nil];
    [self.rw_operation read:nil];
    [self.rw_operation write:nil];
}


-(void)read{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.rwLock readLock];
        sleep(0.2);
        NSLog(@"read");
        [self.rwLock readUnLock];
    });
}

-(void)write{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.rwLock writeLock];
        NSLog(@"write");
        sleep(1);
        [self.rwLock writeUnLock];
    });
}


@end
