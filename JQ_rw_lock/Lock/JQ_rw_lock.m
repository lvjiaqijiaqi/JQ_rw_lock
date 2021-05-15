//
//  JQ_rw_lock.m
//  JQ_rw_lock
//
//  Created by 吕佳骐 on 2021/5/15.
//

#import "JQ_rw_lock.h"

@interface JQ_rw_lock()

@property(nonatomic,strong) NSCondition *cond;

@property(nonatomic,assign) NSInteger WR;
@property(nonatomic,assign) NSInteger AR;
@property(nonatomic,assign) NSInteger WW;
@property(nonatomic,assign) NSInteger AW;

@end

@implementation JQ_rw_lock

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cond = [[NSCondition alloc] init];
    }
    return self;
}

-(void)readLock{
    [self.cond lock];
    while (self.WW > 0 || self.AW > 0) {
        self.WR++;
        [self wait];
        self.WR--;
    }
    self.AR++;
    [self.cond unlock];
}

-(void)readUnLock{
    [self.cond lock];
    self.AR--;
    if (self.AR == 0) {
        [self.cond broadcast];
    }
    [self.cond unlock];
}

-(void)writeLock{
    [self.cond lock];
    while (self.AR > 0 || self.AW > 0) {
        self.WW++;
        [self wait];
        self.WW--;
    }
    self.AW++;
    [self.cond unlock];
}

-(void)writeUnLock{
    [self.cond lock];
    self.AW--;
    [self.cond broadcast];
    [self.cond unlock];
}

-(void)wait{
    [self.cond wait];
}

-(void)signal{
    [self.cond signal];
}

@end
