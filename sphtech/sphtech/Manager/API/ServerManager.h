//
//  ServerManager.h
//  sphtech
//
//  Created by Michael Ugale on 1/14/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"

typedef void(^ServerManagerSuccessBlock)(NSDictionary *responseObject);
typedef void(^ServerManagerFailureBlock)(NSError *error);

typedef NS_ENUM(NSInteger, ErrorType)
{
    kErrorNoInternet = 0,
    kErrorFailedAccesstokenRequest,
    kErrorNone
};

@interface ServerManager : AFHTTPSessionManager
    
    @property (nonatomic) BOOL                  hasInternet;
    @property (strong, nonatomic) Reachability  *reachability;
    
+ (ServerManager *)sharedManager;
    
#pragma mark - GET
    
- (void) getDataList:(NSDictionary *)params
                success:(ServerManagerSuccessBlock)success
                failure:(ServerManagerFailureBlock)failure;
    
@end
