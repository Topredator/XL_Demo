//
//  NetWork.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/6/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "NetWork.h"
#import "AFNetworking.h"
static NetWork *network = nil;
@implementation NetWork
+ (instancetype)netWorkShareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        network = [[NetWork alloc] init];
    });
    return network;
}


+ (XLSessionTask *)requestWithUrl:(NSString *)url
                   param:(NSDictionary *)param
             requestType:(RequestType)requestType
              progress:(ProgressHanle)progress
                 success:(SuccessHandle)success
                    fail:(FaileHandle)fail
{
    if (!url) return nil;
    switch (requestType) {
        case RequestType_Get:
        {
            AFHTTPSessionManager *manager = [self getAFSessionManager];
            XLSessionTask *sessionTask = nil;
            //  判断 url是否含有中文
            NSString *urlStr = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
            sessionTask = [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                //  进度
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    if (success) success(dic);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //  失败
                if ([error code] == NSURLErrorCancelled) return ;
                else
                {
                    if (fail) fail(error);
                }
            }];
            return sessionTask;
        }
            break;
        default:
        {
            AFHTTPSessionManager *manager = [self getAFSessionManager];
            XLSessionTask *sessionTask = nil;
            //  判断 url是否含有中文
            NSString *urlStr = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
            sessionTask = [manager POST:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
                //   进度
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //  成功
                id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    if (success) success(dic);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //  失败
                if ([error code] == NSURLErrorCancelled) return ;
                else
                {
                    if (fail) fail(error);
                }
            }];
            return sessionTask;
        }
            break;
    }
}
+ (XLSessionTask *)downloadRequestWithUrl:(NSString *)url
                                 progress:(ProgressHanle)progress
                                  success:(SuccessHandle)success
                                     fail:(FaileHandle)fail
{
    if (!url) return nil;
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    AFHTTPSessionManager *manager = [self getAFSessionManager];
    NSString *urlStr = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    XLSessionTask *sessionTask = nil;
    sessionTask = [manager downloadTaskWithRequest:request
                                          progress:^(NSProgress * _Nonnull downloadProgress) {
                                              //    放入主线程 刷新UI
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if (progress) {
                                                      progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
                                                  }
                                              });
                                          } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                              //    默认路径
                                              NSURL *documentsURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                                              return [documentsURL URLByAppendingPathComponent:[response suggestedFilename]];
                                          } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                              
                                          }];
    return sessionTask;
}

+ (XLSessionTask *)uploadRequestWithUrl:(NSString *)url
                               mimeType:(NSString *)mimeType
                                  param:(NSDictionary *)param
                               fileName:(NSString *)fileName
                                   name:(NSString *)name
                               progress:(ProgressHanle)progress
                                success:(SuccessHandle)success
                                   fail:(FaileHandle)fail
{
    if (!url) return nil;
    AFHTTPSessionManager *manager = [self getAFSessionManager];
    XLSessionTask *sessionTask = nil;
    NSString *urlStr = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
    sessionTask = [manager POST:urlStr
                     parameters:param
      constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
          NSString *fileNameStr = fileName;
          if (!fileName || !fileName.length || ![fileName isKindOfClass:[NSString class]]) {
              NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
              formatter.dateFormat = @"yyyyMMddHHmmss";
              NSString *str = [formatter stringFromDate:[NSDate date]];
              fileNameStr = [NSString stringWithFormat:@"%@", str];
          }
          //    文件（假设本地文件）
          
          //    上传，以文件流的格式
      } progress:^(NSProgress * _Nonnull uploadProgress) {
          //    进度 放入主线程，刷新UI
          dispatch_async(dispatch_get_main_queue(), ^{
              if (progress) {
                  progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
              }
          });
      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
          if ([dic isKindOfClass:[NSDictionary class]]) {
              if (success) success(dic);
          }
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          //  失败
          if ([error code] == NSURLErrorCancelled) return ;
          else
          {
              if (fail) fail(error);
          }
      }];
    return sessionTask;
}

+ (AFHTTPSessionManager *)getAFSessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置返回数据为json
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
