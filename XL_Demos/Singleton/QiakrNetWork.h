//
//  QiakrNetWork.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/19.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, QKRequestType) {
    QKRequestType_GET = 0,
    QKRequestType_POST
};

typedef void(^QKFinishHandle)(NSURL *url, id response, NSString *httpMethod, NSInteger statusCode, id job);
typedef void(^QKFaileHandle)(NSError *error, id job, NSString *httpMethod, NSURL *url, NSInteger statusCode);
typedef void(^QKProgressHandle)(int64_t completedUnitCount, int64_t totalUnitCount);

/**
 *  请求句柄
 */
typedef  NSURLSessionTask QKSessionTask;

@interface QiakrNetWork : NSObject
/**
 *  初始化
 *
 *  @return 单例对象
 */
+ (instancetype)defaultNetwork;

/**
 *  网络请求
 *
 *  @param urlStr         url 地址
 *  @param param          参数 字典
 *  @param job         上下文
 *  @param requestType    请求类型  GET / POST
 *  @param finishHandle   完成回调
 *  @param faileHandle    失败回调
 *  @param progressHandle 进度回调
 *
 *  @return 请求任务对象
 */
+ (QKSessionTask *)requestWithUrl:(NSString *)urlStr
                            param:(NSDictionary *)param
                              job:(id)job
                      requestType:(QKRequestType)requestType
                     finishHandle:(QKFinishHandle)finishHandle
                      faileHandle:(QKFaileHandle)faileHandle
                   progressHandle:(QKProgressHandle)progressHandle;

@end
