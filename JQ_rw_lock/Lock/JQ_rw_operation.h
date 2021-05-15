//
//  JQ_rw_operation.h
//  JQ_rw_lock
//
//  Created by 吕佳骐 on 2021/5/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQ_rw_operation : NSObject

-(void)read:(void(^)(id res))complete;
-(void)write:(void(^)(id res))complete;

@end

NS_ASSUME_NONNULL_END
