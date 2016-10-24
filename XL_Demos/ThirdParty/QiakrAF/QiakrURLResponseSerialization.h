//
//  QiakrURLResponseSerialization.h
//  Qiakr_AFNetworking
//
//  Created by zhouxiaolu on 16/6/27.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QiakrURLResponseSerialization <NSObject, NSSecureCoding, NSCopying>

- (nullable id)responseObjectForResponse:(nullable NSURLResponse *)response
                                    data:(nullable NSData *)data
                                   error:(NSError * _Nullable __autoreleasing *)error NS_SWIFT_NOTHROW;

@end
#pragma mark -

@interface QiakrHTTPResponseSerializer : NSObject <QiakrURLResponseSerialization>

- (instancetype)init;

@property (nonatomic, assign) NSStringEncoding stringEncoding;

+ (instancetype)serializer;

@property (nonatomic, copy, nullable) NSIndexSet *acceptableStatusCodes;

@property (nonatomic, copy, nullable) NSSet <NSString *> *acceptableContentTypes;

- (BOOL)validateResponse:(nullable NSHTTPURLResponse *)response
                    data:(nullable NSData *)data
                   error:(NSError * _Nullable __autoreleasing *)error;

@end

#pragma mark -
@interface QiakrJSONResponseSerializer : QiakrHTTPResponseSerializer

- (instancetype)init;

@property (nonatomic, assign) NSJSONReadingOptions readingOptions;

@property (nonatomic, assign) BOOL removesKeysWithNullValues;

+ (instancetype)serializerWithReadingOptions:(NSJSONReadingOptions)readingOptions;

@end
#pragma mark - 
@interface QiakrXMLParserResponseSerializer : QiakrHTTPResponseSerializer

@end

#pragma mark - 
#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
@interface QiakrXMLDocumentResponseSerializer : QiakrHTTPResponseSerializer

- (instancetype)init;

/**
 Input and output options specifically intended for `NSXMLDocument` objects. For possible values, see the `NSJSONSerialization` documentation section "NSJSONReadingOptions". `0` by default.
 */
@property (nonatomic, assign) NSUInteger options;

/**
 Creates and returns an XML document serializer with the specified options.
 
 @param mask The XML document options.
 */
+ (instancetype)serializerWithXMLDocumentOptions:(NSUInteger)mask;

@end
#endif

#pragma mark - 
@interface QiakrPropertyListResponseSerializer : QiakrHTTPResponseSerializer

- (instancetype)init;

@property (nonatomic, assign) NSPropertyListFormat format;

@property (nonatomic, assign) NSPropertyListReadOptions readOptions;

+ (instancetype)serializerWithFormat:(NSPropertyListFormat)format
                         readOptions:(NSPropertyListReadOptions)readOptions;

@end

#pragma mark - 
@interface QiakrImageResponseSerializer : QiakrHTTPResponseSerializer

#if TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH

@property (nonatomic, assign) CGFloat imageScale;

@property (nonatomic, assign) BOOL automaticallyInflatesResponseImage;
#endif
@end

#pragma mark -
@interface QiakrCompoundResponseSerializer : QiakrHTTPResponseSerializer

@property (readonly, nonatomic, copy) NSArray <id<QiakrURLResponseSerialization>> *responseSerializers;

+ (instancetype)compoundSerializerWithResponseSerializers:(NSArray <id<QiakrURLResponseSerialization>> *)responseSerializers;
@end

FOUNDATION_EXPORT NSString * const QiakrURLResponseSerializationErrorDomain;
FOUNDATION_EXPORT NSString * const QiakrOperationFailingURLResponseErrorKey;
FOUNDATION_EXPORT NSString * const QiakrOperationFailingURLResponseDataErrorKey;
NS_ASSUME_NONNULL_END