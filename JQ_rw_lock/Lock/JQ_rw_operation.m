//
//  JQ_rw_operation.m
//  JQ_rw_lock
//
//  Created by 吕佳骐 on 2021/5/15.
//

#import "JQ_rw_operation.h"

@interface JQ_rw_operation()

@property(nonatomic,strong) dispatch_queue_t queue;

@end

@implementation JQ_rw_operation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.queue = dispatch_queue_create("com.lvjiaqi.JQ_rw_operation", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

-(void)read:(void(^)(id res))complete{
    dispatch_async(self.queue, ^{
        NSLog(@"read");
        if(complete) complete(nil);
    });
}

-(void)write:(void(^)(id res))complete{
    dispatch_barrier_async(self.queue, ^{
        sleep(0.5);
        NSLog(@"write");
        if(complete) complete(nil);
    });
}

@end
