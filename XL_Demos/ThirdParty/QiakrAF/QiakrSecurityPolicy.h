//
//  QiakrSecurityPolicy.h
//  Qiakr_AFNetworking
//
//  Created by zhouxiaolu on 16/6/27.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

typedef NS_ENUM(NSUInteger, QiakrSSLPinningMode) {
    QiakrSSLPinningModeNone,
    QiakrSSLPinningModePublicKey,
    QiakrSSLPinningModeCertificate,
};

NS_ASSUME_NONNULL_BEGIN
@interface QiakrSecurityPolicy : NSObject<NSSecureCoding, NSCopying>

@property (readonly, nonatomic, assign) QiakrSSLPinningMode SSLPinningMode;
@property (nonatomic, strong, nullable) NSSet <NSData *> *pinnedCertificates;
@property (nonatomic, assign) BOOL allowInvalidCertificates;
@property (nonatomic, assign) BOOL validatesDomainName;
+ (NSSet <NSData *> *)certificatesInBundle:(NSBundle *)bundle;
+ (instancetype)defaultPolicy;
+ (instancetype)policyWithPinningMode:(QiakrSSLPinningMode)pinningMode;
+ (instancetype)policyWithPinningMode:(QiakrSSLPinningMode)pinningMode withPinnedCertificates:(NSSet <NSData *> *)pinnedCertificates;
- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(nullable NSString *)domain;

@end
NS_ASSUME_NONNULL_END
