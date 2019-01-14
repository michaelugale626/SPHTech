//
//  ServerManager.m
//  sphtech
//
//  Created by Michael Ugale on 1/14/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "ServerManager.h"

//Utilities
#import "Cache.h"
#import "Utilities.h"

//Categories
#import "NSObject+Cast.h"
#import "NSString+Additions.h"
#import "NSDateFormatter+StaticInstance.h"
#import "UIColor+More.h"
#import "UIViewController+Additions.h"
#import "UIAlertController+Convenience.h"

typedef void (^AFRequestOperationSuccesBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^AFRequestOperationFailureBlock)(NSURLSessionDataTask *task, NSError *error);

#define UNDESIRED_NULL                      @"(null)"
#define IS_REFRESH_TOKEN_ACTIVE             1
#define IS_REFRESH_BASE_ON_LOGIN_ACTIVE     0
#define IS_NEW_URL                          @"yes"

static NSString * const JSONResponseSerializerWithDataKey = @"JSONResponseSerializerWithDataKey";
static NSString * const BOWParameterDateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";

NSString *const BASIC_AUTH_ID       = @"";
NSString *const BASIC_AUTH_SECRET   = @"";

@interface ServerManager ()
    
    @property (strong, nonatomic) UIView                *floatingWarning;
    
    @end

@implementation ServerManager
    
    static ServerManager *manager = nil;
    
+ (ServerManager *)sharedManager
    {
        if (IS_IOS7_OR_LATTER) {
            if (!manager) {
                manager = (ServerManager *)[[self alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL]];
                SPLOG_DEBUG(@"Singleton has memory address at: %@\nBase URL = %@", manager, API_BASE_URL);
            }
        } else {
            @synchronized(self) {
                if (!manager) {
                    manager = (ServerManager *)[[self alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL]];
                    SPLOG_DEBUG(@"Singleton has memory address at: %@\nBase URL = %@", manager, API_BASE_URL);
                }
            }
        }
        
        return manager;
    }
    
- (id)initWithBaseURL:(NSURL *)url
    {
        self = [super initWithBaseURL:url];
        if (self) {
            
            self.responseSerializer                 = [AFJSONResponseSerializer serializer];
            self.requestSerializer                  = [AFJSONRequestSerializer serializer];
            self.requestSerializer.timeoutInterval  = 60.0f;
            
            self.reachability                       = [Reachability reachabilityForInternetConnection];
            [self.reachability startNotifier];
            
            NetworkStatus status                    = [self.reachability currentReachabilityStatus];
            
            self.hasInternet                        = !(status == NotReachable);
            
            if (!self.hasInternet) {
                //SHOW no internet
            }
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(reachabilityChanged:)
                                                         name:kReachabilityChangedNotification
                                                       object:nil];
        }
        return self;
    }
    
- (void)setBasicAuth
    {
        [self.requestSerializer setAuthorizationHeaderFieldWithUsername:BASIC_AUTH_ID password:BASIC_AUTH_SECRET];
    }
    
- (ErrorType)setBearerForAuthorizationHeader
    {
        if (!self.hasInternet) {
            return kErrorNoInternet;
        }
        
        BOOL authorizationHeaderWasSet = NO;
        for (NSInteger retryCount = 0; retryCount < 4; retryCount++) {
            authorizationHeaderWasSet = [self fetchAndSetAuthorizationHeader];
            if (authorizationHeaderWasSet) {
                break;
            }
        }
        
        if (authorizationHeaderWasSet) {
            return kErrorNone;
        } else {
            return kErrorFailedAccesstokenRequest;
        }
    }
    
- (void)setHTTPHeader:(NSString *)header ForKey:(NSString *)key
    {
        [self.requestSerializer setValue:header forHTTPHeaderField:key];
    }
    
- (BOOL)fetchAndSetAuthorizationHeader
    {
        __block BOOL authorizationHeaderWasSet = NO;
        __block NSString *bearer = nil;
        
        
        bearer = [NSString stringWithFormat:@"Bearer %@", [[Cache shared] getCachedObjectForKey:ACCESS_TOKEN]];
        [self setHTTPHeader:bearer ForKey:@"Authorization"];
        authorizationHeaderWasSet = YES;
        
        return authorizationHeaderWasSet;
    }
    
- (void)checkErrorType:(ErrorType)errorType forFailureBlock:(void (^)(NSError *error))failure
    {
        switch (errorType) {
            case kErrorNoInternet:
            failure([self noInternetError]);
            break;
            default:
            failure([self unkownError]);
            break;
        }
    }
    
- (void)reachabilityChanged:(NSNotification *)notification
    {
        Reachability *reachability = [notification object];
        
        if (reachability.isReachable) {
            self.hasInternet = YES;
        } else {
            self.hasInternet = NO;
        }
    }
    
- (void)clearAuthorizationHeader
    {
        [self.requestSerializer clearAuthorizationHeader];
    }
    
- (void) getAccessTokenErrorMessage
    {
        NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
        
        info[NSLocalizedDescriptionKey] = ISSUE_ACCESS_TOKEN;
        
        NSError *error = [NSError errorWithDomain:CONNECTION_ERROR code:9997 userInfo:info];
        
        [Utilities showSimpleAlert:(id)self setTitle:[error localizedDescription]];
        
    }
- (NSURLSessionDataTask *)getAccessToken:(void (^)(NSString *accessToken))success failure:(void (^)(NSError *))failure
    {
        return nil;
    }
    
- (AFRequestOperationSuccesBlock)successCallback:(ServerManagerSuccessBlock)success {
    return ^(NSURLSessionDataTask *task, id responseObject) {
        SPLOG_INFO(@"Success Response: %@ %@", task.currentRequest.URL.absoluteString, responseObject);
        if (success) {
            success(responseObject);
        }
    };
}
    
- (AFRequestOperationFailureBlock)failureCallback:(ServerManagerFailureBlock)failure
    {
        return ^(NSURLSessionDataTask *task, NSError *error) {
            SPLOG_INFO(@"Request Error: %@ %@", task.originalRequest.URL.absoluteString, error.description);
            
            NSString *errorMessage = nil;
            if (error.userInfo[JSONResponseSerializerWithDataKey][@"message"]) {
                errorMessage = error.userInfo[JSONResponseSerializerWithDataKey][@"message"];
            } else if (error.localizedDescription) {
                errorMessage = error.localizedDescription;
            } else {
                errorMessage = SOMETHING_WENT_WRONG;
            }
            
            NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
            userInfo[NSLocalizedDescriptionKey] = errorMessage;
            NSError *newError = [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
            
            if ([errorMessage isEqualToString:@"No internet connection."]) {
                
                [self.floatingWarning removeFromSuperview];
                
                self.floatingWarning = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                                64,
                                                                                [UIViewController topViewController].view.bounds.size.width,
                                                                                30)];
                self.floatingWarning.backgroundColor    = [UIColor clearColor];
                self.floatingWarning.alpha              = 0.7f;
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIViewController topViewController].view.bounds.size.width, 30)];
                label.text = errorMessage;
                label.font = FONT_UI_Text_Light(14);
                label.backgroundColor = [UIColor colorWithHex:THEME_COLOR_GRAY];
                label.textColor = [UIColor whiteColor];
                [label setTextAlignment:NSTextAlignmentCenter];
                [self.floatingWarning addSubview:label];
                
                
                UIViewController *tempView = [UIViewController topViewController];
                
                if ([tempView isKindOfClass:[UIAlertController class]]) {
                    tempView = [[[[UIApplication sharedApplication]delegate] window] rootViewController];
                }
                
                [tempView.view addSubview:self.floatingWarning];
                
                // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
                [UIView animateWithDuration:0.5 delay:1.0 options:0 animations:^{
                    // Animate the alpha value of your imageView from 1.0 to 0.0 here
                    self.floatingWarning.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
                    [self.floatingWarning removeFromSuperview];
                }];
                
            }
            
            if (failure) failure(newError);
        };
    }
    
#pragma mark - GET
    
    /**
     This is an API call to get Product List
     
     @param parameters this contains theme, pageSize and page
     */
- (void) getDataList:(NSDictionary *)parameters
                success:(ServerManagerSuccessBlock)success
                failure:(ServerManagerFailureBlock)failure
    {
        ErrorType errorType = [self setBearerForAuthorizationHeader];
        if (errorType != kErrorNone) {
            [self checkErrorType:errorType forFailureBlock:failure];
            return;
        }
        
        [parameters setValue:API_RESOURCE_KEY forKey:@"resource_id"];
        
        [self GET:API_BASE_URL
       parameters:parameters
          success:[self successCallback:success]
          failure:[self failureCallback:failure]];
    }
    
#pragma mark - NSError Methods
    
    /**
     Get error message for code 99999 which is an unknown error
     
     @return NSError
     */
- (NSError *)unkownError
    {
        NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
        info[NSLocalizedDescriptionKey] = @"An unknown error occured.";
        
        NSError *error = [NSError errorWithDomain:@"Unknown error" code:9999 userInfo:info];
        return error;
    }
    
    /**
     Get error message for code 9998 which is an no internet connection
     
     @return NSError
     */
- (NSError *)noInternetError
    {
        NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
        info[NSLocalizedDescriptionKey] = NO_INTERNET_CONNECTION;
        
        NSError *error = [NSError errorWithDomain:CONNECTION_ERROR code:9998 userInfo:info];
        return error;
    }
    @end
