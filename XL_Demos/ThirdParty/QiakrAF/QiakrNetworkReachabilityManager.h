//
//  QiakrNetworkReachabilityManager.h
//  Qiakr_AFNetworking
//
//  Created by zhouxiaolu on 16/6/27.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

#if !TARGET_OS_WATCH
#import <SystemConfiguration/SystemConfiguration.h>

typedef NS_ENUM(NSInteger, QiakrNetworkReachabilityStatus) {
    QiakrNetworkReachabilityStatusUnknown          = -1,
    QiakrNetworkReachabilityStatusNotReachable     = 0,
    QiakrNetworkReachabilityStatusReachableViaWWAN = 1,
    QiakrNetworkReachabilityStatusReachableViaWiFi = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface QiakrNetworkReachabilityManager : NSObject
@property (readonly, nonatomic, assign) QiakrNetworkReachabilityStatus networkReachabilityStatus;

@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;

@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;

@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;

+ (instancetype)sharedManager;

+ (instancetype)manager;

+ (instancetype)managerForDomain:(NSString *)domain;

+ (instancetype)managerForAddress:(const void *)address;

- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability NS_DESIGNATED_INITIALIZER;

- (void)startMonitoring;

- (void)stopMonitoring;

- (NSString *)localizedNetworkReachabilityStatusString;

- (void)setReachabilityStatusChangeBlock:(nullable void (^)(QiakrNetworkReachabilityStatus status))block;
@end
FOUNDATION_EXPORT NSString * const QiakrReachabilityDidChangeNotification;
FOUNDATION_EXPORT NSString * const QiakrReachabilityNotificationStatusItem;
FOUNDATION_EXPORT NSString * QiakrStringFromNetworkReachabilityStatus(QiakrNetworkReachabilityStatus status);

NS_ASSUME_NONNULL_END
#endif