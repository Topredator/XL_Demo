//
//  NetWork.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/6/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, RequestType) {
    RequestType_Get = 0,
    RequestType_Post,
};
typedef void(^SuccessHandle)(id response); // 成功回调
typedef void(^FaileHandle)(NSError *error); //  失败回调
typedef void(^ProgressHanle)(int64_t completedUnitCount, int64_t totalUnitCount); //    进度回调

typedef  NSURLSessionTask XLSessionTask;

@interface NetWork : NSObject
@property (nonatomic, assign) RequestType requestType;

//  单例初始化
+ (instancetype)netWorkShareInstance;
//  get / post 请求
+ (XLSessionTask *)requestWithUrl:(NSString *)url
                            param:(NSDictionary *)param
                      requestType:(RequestType)requestType
                         progress:(ProgressHanle)progress
                          success:(SuccessHandle)success
                             fail:(FaileHandle)fail;
//  下载
+ (XLSessionTask *)downloadRequestWithUrl:(NSString *)url
                                 progress:(ProgressHanle)progress
                                  success:(SuccessHandle)success
                                     fail:(FaileHandle)fail;
//  上传
+ (XLSessionTask *)uploadRequestWithUrl:(NSString *)url
                               mimeType:(NSString *)mimeType
                                  param:(NSDictionary *)param
                               fileName:(NSString *)fileName
                                   name:(NSString *)name
                               progress:(ProgressHanle)progress
                                success:(SuccessHandle)success
                                   fail:(FaileHandle)fail;
@end
