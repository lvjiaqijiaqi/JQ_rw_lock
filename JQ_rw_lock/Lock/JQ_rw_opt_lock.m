//
//  JQ_rw_opt_lock.m
//  JQ_rw_lock
//
//  Created by 吕佳骐 on 2021/5/15.
//

#import "JQ_rw_opt_lock.h"
#import <pthread/pthread.h>

static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t r_cond = PTHREAD_COND_INITIALIZER;
static pthread_cond_t w_cond = PTHREAD_COND_INITIALIZER;

@interface JQ_rw_opt_lock()

@property(nonatomic,assign) NSInteger WR;
@property(nonatomic,assign) NSInteger AR;
@property(nonatomic,assign) NSInteger WW;
@property(nonatomic,assign) NSInteger AW;

@end

@implementation JQ_rw_opt_lock

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)readLock{
    pthread_mutex_lock(&mutex);
    while (self.WW > 0 || self.AW > 0) {
        self.WR++;
        pthread_cond_wait(&r_cond, &mutex);
        self.WR--;
    }
    self.AR++;
    pthread_mutex_unlock(&mutex);
}

-(void)readUnLock{
    pthread_mutex_lock(&mutex);
    self.AR--;
    if (self.AR == 0 && self.WW > 0) {
        pthread_cond_signal(&w_cond);
    }
    pthread_mutex_unlock(&mutex);
}

-(void)writeLock{
    pthread_mutex_lock(&mutex);
    while (self.AR > 0 || self.AW > 0) {
        self.WW++;
        pthread_cond_wait(&w_cond, &mutex);
        self.WW--;
    }
    self.AW++;
    pthread_mutex_unlock(&mutex);
}

-(void)writeUnLock{
    pthread_mutex_lock(&mutex);
    self.AW--;
    if (self.WW > 0) {
        pthread_cond_signal(&w_cond);
    }else if (self.WR > 0){
        pthread_cond_broadcast(&r_cond);
    }
    pthread_mutex_unlock(&mutex);
}


@end
