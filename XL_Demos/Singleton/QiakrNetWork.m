//
//  QiakrNetWork.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/19.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "QiakrNetWork.h"

#import "QiakrNetworking.h"

static QiakrNetWork *qiakrNetwork = nil;
@implementation QiakrNetWork
+ (instancetype)defaultNetwork
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        qiakrNetwork = [[QiakrNetWork alloc] init];
    });
    return qiakrNetwork;
}

+ (QKSessionTask *)requestWithUrl:(NSString *)urlStr
                            param:(NSDictionary *)param
                              job:(id)job
                      requestType:(QKRequestType)requestType
                     finishHandle:(QKFinishHandle)finishHandle
                      faileHandle:(QKFaileHandle)faileHandle
                   progressHandle:(QKProgressHandle)progressHandle
{
    if (!urlStr) return nil;
    QKSessionTask *sessionTask = nil;
    QiakrHTTPSessionManager *manager = [self getAFSessionManager];
    NSString *url = [NSURL URLWithString:urlStr] ? urlStr : [self strUTF8Encoding:urlStr];
    switch (requestType) {
        case QKRequestType_GET:
        {
            sessionTask = [manager GET:url
              parameters:nil
                progress:^(NSProgress * _Nonnull downloadProgress) {
                    //    放入主线程 刷新UI
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (progressHandle)
                            progressHandle(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
                    });
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //  请求完成回调
                    if (finishHandle)
                        finishHandle(task.response.URL, responseObject, task.currentRequest.HTTPMethod, ((NSHTTPURLResponse *)task.response).statusCode, job);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    //  请求失败回调
                    if ([error code] == NSURLErrorCancelled) return ;
                    else
                    {
                        if (faileHandle) {
                            faileHandle(error, job, task.currentRequest.HTTPMethod, task.response.URL, ((NSHTTPURLResponse *)task.response).statusCode);
                        }
                    }
                }];
        }
            break;
        case QKRequestType_POST:
        {
           sessionTask = [manager POST:url
               parameters:param
                 progress:^(NSProgress * _Nonnull uploadProgress) {
                     //    放入主线程 刷新UI
                     dispatch_async(dispatch_get_main_queue(), ^{
                         if (progressHandle)
                             progressHandle(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
                     });
                 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     //  请求完成回调
                     if (finishHandle)
                         finishHandle(task.response.URL, responseObject, task.currentRequest.HTTPMethod, ((NSHTTPURLResponse *)task.response).statusCode, job);
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     //  请求失败回调
                     if ([error code] == NSURLErrorCancelled) return ;
                     else
                     {
                         if (faileHandle) {
                             faileHandle(error, job, task.currentRequest.HTTPMethod, task.response.URL, ((NSHTTPURLResponse *)task.response).statusCode);
                         }
                     }
                 }];
        }
            break;
    }
    return sessionTask;
}


+ (QiakrHTTPSessionManager *)getAFSessionManager
{
    QiakrHTTPSessionManager *manager = [QiakrHTTPSessionManager manager];
    manager.responseSerializer = [QiakrHTTPResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval=10; //    10秒超时
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                @"text/html",
                                @"text/json",
                                @"text/plain",
                                @"text/javascript",
                                @"text/xml",
                                @"image/*"]];
    return manager;
}
+ (NSString *)strUTF8Encoding:(NSString *)urlStr{
    //return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end
