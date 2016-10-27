//
//  ZXLWebView.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/10/25.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXLWebView;

@protocol ZXLWebViewDelegate <NSObject>
@optional
- (void)ZXL_WebViewDidStartLoad:(ZXLWebView *)webView;
- (void)ZXL_WebViewDidFinishLoad:(ZXLWebView *)webView;
- (void)ZXL_WebView:(ZXLWebView *)webView didFailLoadWithError:(NSError *)error;
- (BOOL)ZXL_WebView:(ZXLWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
@end

@interface ZXLWebView : UIView
@property (nonatomic, weak) id <ZXLWebViewDelegate> delegate;

//  web 容器  UIWeb / WKWeb
@property (nonatomic, readonly) id realWebView;
//  是否使用UIWeb
@property (nonatomic, readonly) BOOL usingUIWeb;
//  预估网页加载速度
@property (nonatomic, readonly) double estimatedProgress;
//  初始请求
@property (nonatomic, readonly) NSURLRequest *originRequest;
//  当前 请求
@property (nonatomic, readonly) NSURLRequest *currentRequest;
@property (nonatomic, readonly, copy) NSString *title;

@property (nonatomic, readonly) NSURL *URL;

@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;
///是否根据视图大小来缩放页面  默认为YES
@property (nonatomic) BOOL scalesPageToFit;

- (instancetype)initWithFrame:(CGRect)frame usingUIWebView:(BOOL)usingUIWebView;
- (id)ZXL_LoadRequest:(NSURLRequest *)request;
- (id)ZXL_LoadHTMLString:(NSString *)string baseUrl:(NSURL *)baseUrl;

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandle;
///不建议使用这个办法  因为会在内部等待webView 的执行结果
- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)javaScriptString __deprecated_msg("Method deprecated. Use [evaluateJavaScript:completionHandler:]");

//  back层数
- (NSInteger)countOfHistory;
//  返回第N步
- (void)goBackWithStep:(NSInteger)step;

- (id)goBack;
- (id)goForward;
- (id)reload;
- (id)reloadFromOrigin;
- (void)stopLoading;
@end
