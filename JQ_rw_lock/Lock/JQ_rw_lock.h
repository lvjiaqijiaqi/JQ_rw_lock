//
//  JQ_rw_lock.h
//  JQ_rw_lock
//
//  Created by 吕佳骐 on 2021/5/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JQ_rw_lock_protocol <NSObject>

-(void)readLock;
-(void)readUnLock;
-(void)writeLock;
-(void)writeUnLock;

@end

@interface JQ_rw_lock : UIView<JQ_rw_lock_protocol>

    
@end

NS_ASSUME_NONNULL_END
