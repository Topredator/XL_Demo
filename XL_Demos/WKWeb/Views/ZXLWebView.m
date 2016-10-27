//
//  ZXLWebView.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/10/25.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "ZXLWebView.h"
#import <WebKit/WebKit.h>
#import "NJKWebViewProgressView.h"

static NSString *const completeRPCURLPath = @"/njkwebviewprogressproxy/complete";
static const CGFloat KInitialProgressValue = 0.1f;
static const CGFloat KInteractiveProgressValue = 0.5f;
static const CGFloat KFinalProgressValue = 0.9f;
static NSString *const kestimatedProgress = @"estimatedProgress";


@interface ZXLWebView ()<UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate>
{
    NSUInteger _loadingCount;
    NSUInteger _maxLoadCount;
    NSURL *_currentURL;
    BOOL _interactive;
}
@property (nonatomic, assign) double estimatedProgress;
@property (nonatomic, strong) NSURLRequest *originRequest;
@property (nonatomic, strong) NSURLRequest *currentRequest;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong)NJKWebViewProgressView *progressView;
@property (nonatomic, readonly) float progress; // 0.0 ~ 1.0
@end

@implementation ZXLWebView
@synthesize usingUIWeb = _usingUIWeb;
@synthesize realWebView = _realWebView;
@synthesize scalesPageToFit = _scalesPageToFit;

- (void)dealloc
{
    if (_usingUIWeb) {
        UIWebView *webView = _realWebView;
        webView.delegate = nil;
    }
    else
    {
        WKWebView *webView = _realWebView;
        webView.UIDelegate = nil;
        webView.navigationDelegate = nil;
        [webView removeObserver:self forKeyPath:kestimatedProgress];
        [webView removeObserver:self forKeyPath:@"title"];
    }
    [_realWebView scrollView].delegate = nil;
    [_realWebView stopLoading];
    [_realWebView removeFromSuperview];
    _realWebView = nil;
}
#pragma mark - init methods -
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame usingUIWebView:NO];
}
- (instancetype)initWithFrame:(CGRect)frame usingUIWebView:(BOOL)usingUIWebView
{
    self = [super initWithFrame:frame];
    if (self) {
        _usingUIWeb = usingUIWebView;
        [self configInit];
    }
    return self;
}
#pragma mark - WKWebView or UIWebView  Init method -
- (void)initWKWebView
{
    WKWebViewConfiguration* configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = [WKPreferences new];
    configuration.userContentController = [WKUserContentController new];
    configuration.selectionGranularity = WKSelectionGranularityCharacter;
    WKWebView* webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    
    [webView addObserver:self forKeyPath:kestimatedProgress options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_progressView];
    _realWebView = webView;
}
- (void)initUIWebView
{
    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.bounds];
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    for (UIView *subview in [webView.scrollView subviews])
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            ((UIImageView *) subview).image = nil;
            subview.backgroundColor = [UIColor clearColor];
        }
    }
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_progressView];
    _realWebView = webView;
}
- (void)configInit
{
    Class webview = NSClassFromString(@"WKWebView");
    if (webview && self.usingUIWeb == NO)
    {
        [self initWKWebView];
        _usingUIWeb = NO;
    }
    else
    {
        [self initUIWebView];
        _usingUIWeb = YES;
    }
    self.scalesPageToFit =  YES;
    CGRect rect = self.bounds;
    rect.origin.y = 2;
    [self.realWebView setFrame:rect];
    [self.realWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:self.realWebView];
}

#pragma mark - KVO 
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:kestimatedProgress])
    {
        self.estimatedProgress = [change[NSKeyValueChangeNewKey] doubleValue];
        [_progressView setProgress:[change[NSKeyValueChangeNewKey] doubleValue] animated:YES];
    }
    else if ([keyPath isEqualToString:@"title"])
    {
        self.title = change[NSKeyValueChangeNewKey];
    }
}
#pragma mark - UIWebView delegate -
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //  进度条
    _loadingCount ++;
    _maxLoadCount = fmax(_maxLoadCount, _loadingCount);
    [self startProgress];
    //  --------------------------- //
    
    [self ZXLCallBack_WebViewDidStartLoad];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //  进度条
    _loadingCount --;
    [self incrementProgress];
    
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive) {
        _interactive = YES;
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request.mainDocumentURL.scheme, webView.request.mainDocumentURL.host, completeRPCURLPath];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    BOOL isNotRedirect = _currentURL && [_currentURL isEqual:webView.request.mainDocumentURL];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && isNotRedirect)
        [self completeProgress];
    // -------------------------------- //
    
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (!self.originRequest)
        self.originRequest = webView.request;
    
    [self ZXLCallBack_WebViewDidFinishLoad];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //  进度条
    _loadingCount --;
    [self incrementProgress];
    
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive) {
        _interactive = YES;
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request.mainDocumentURL.scheme, webView.request.mainDocumentURL.host, completeRPCURLPath];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    BOOL isNotReadirect = _currentURL && [_currentURL isEqual:webView.request.mainDocumentURL];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if ((complete && isNotReadirect) || error)
        [self completeProgress];
    //  --------------------------------  //
    
    [self ZXLCallBack_WebViewDidFailLoadWithError:error];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //  进度条
    if ([request.URL.path isEqualToString:completeRPCURLPath]) {
        [self completeProgress];
        return NO;
    }
    
    BOOL isFragmentJump = NO;
    if (request.URL.fragment) {
        NSString *nonFragmentURL = [request.URL.absoluteString stringByReplacingOccurrencesOfString:[@"#" stringByAppendingString:request.URL.fragment] withString:@""];
        isFragmentJump = [nonFragmentURL isEqualToString:webView.request.URL.absoluteString];
    }
    BOOL isTopLevelNavigation = [request.mainDocumentURL isEqual:request.URL];
    BOOL isHTTPOrLocalFile = [request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"] || [request.URL.scheme isEqualToString:@"file"];
    if (!isFragmentJump && isHTTPOrLocalFile && isTopLevelNavigation) {
        _currentURL = request.URL;
        [self reset];
    }
    //  ------------------------ //
    BOOL result = [self ZXLCallBack_WebViewShouldStartLoadWithRequest:request navigationType:navigationType];
    return result;
}
#pragma mark - WKNavigationDelegate -
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    BOOL result = [self ZXLCallBack_WebViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
    if (result)
    {
        self.currentRequest = navigationAction.request;
        if (!navigationAction.targetFrame)
            [webView loadRequest:navigationAction.request];
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    else
        decisionHandler(WKNavigationActionPolicyCancel);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self ZXLCallBack_WebViewDidStartLoad];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self ZXLCallBack_WebViewDidFinishLoad];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self ZXLCallBack_WebViewDidFailLoadWithError:error];
}
- (void)webView: (WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self ZXLCallBack_WebViewDidFailLoadWithError:error];
}
#pragma mark - WKUIDelegate  还没用到-
#pragma mark - private methods -
- (void)ZXLCallBack_WebViewDidFinishLoad
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZXL_WebViewDidFinishLoad:)])
        [self.delegate ZXL_WebViewDidFinishLoad:self];
}
- (void)ZXLCallBack_WebViewDidStartLoad
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZXL_WebViewDidStartLoad:)])
        [self.delegate ZXL_WebViewDidStartLoad:self];
}
- (void)ZXLCallBack_WebViewDidFailLoadWithError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZXL_WebView:didFailLoadWithError:)])
        [self.delegate ZXL_WebView:self didFailLoadWithError:error];
}
- (BOOL)ZXLCallBack_WebViewShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType
{
    BOOL result = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZXL_WebView:shouldStartLoadWithRequest:navigationType:)]) {
        if (navigationType == -1) navigationType = UIWebViewNavigationTypeOther;
        result = [self.delegate ZXL_WebView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return result;
}

- (id)ZXL_LoadRequest:(NSURLRequest *)request
{
    self.originRequest = request;
    self.currentRequest = request;
    if (_usingUIWeb) {
        [(UIWebView *)self.realWebView loadRequest:request];
        return nil;
    }
    else
        return [(WKWebView *)self.realWebView loadRequest:request];
}
- (id)ZXL_LoadHTMLString:(NSString *)string baseUrl:(NSURL *)baseUrl
{
    if (_usingUIWeb) {
        [(UIWebView *)self.realWebView loadHTMLString:string baseURL:baseUrl];
        return nil;
    }
    else
        return [(WKWebView *)self.realWebView loadHTMLString:string baseURL:baseUrl];
}
//  返回
- (id)goBack
{
    if (_usingUIWeb) {
        [(UIWebView *)self.realWebView goBack];
        return nil;
    }
    else
        return [(WKWebView *)self.realWebView goBack];
}
//  下一步
- (id)goForward
{
    if (_usingUIWeb) {
        [(UIWebView *)self.realWebView goForward];
        return nil;
    }
    else
        return [(WKWebView *)self.realWebView goForward];
}
//  刷新
- (id)reload
{
    if (_usingUIWeb) {
        [(UIWebView *)self.realWebView reload];
        return nil;
    }
    else
        return [(WKWebView *)self.realWebView reload];
}
//  刷新到最初的请求
- (id)reloadFromOrigin
{
    if (_usingUIWeb) {
        if (self.originRequest)
            [self evaluateJavaScript:[NSString stringWithFormat:@"window.location.replace('%@')", self.originRequest.URL.absoluteString] completionHandler:nil];
        return nil;
    }
    else
        return [(WKWebView *)self.realWebView reloadFromOrigin];
}
//  停止加载
- (void)stopLoading
{
    [self.realWebView stopLoading];
}
- (void)reset
{
    _maxLoadCount = _loadingCount = 0;
    _interactive = NO;
    [self setProgress:0.0];
}
- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandle
{
    if (_usingUIWeb) {
        NSString *resultStr = [(UIWebView *)self.realWebView stringByEvaluatingJavaScriptFromString:javaScriptString];
        if (completionHandle) completionHandle(resultStr, nil);
    }
    else
        return [(WKWebView *)self.realWebView evaluateJavaScript:javaScriptString completionHandler:completionHandle];
}

- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)javaScriptString
{
    if (_usingUIWeb)
    {
        NSString *resultStr = [(UIWebView *)self.realWebView stringByEvaluatingJavaScriptFromString:javaScriptString];
        return resultStr;
    }
    else
    {
        __block NSString* resultStr = nil;
        __block BOOL isExecuted = NO;
        [(WKWebView*)self.realWebView evaluateJavaScript:javaScriptString completionHandler:^(id obj, NSError *error) {
            resultStr = obj;
            isExecuted = YES;
        }];
        
        while (isExecuted == NO) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        return resultStr;
    }
}

- (NSInteger)countOfHistory
{
    if (_usingUIWeb)
    {
        UIWebView *webView = self.realWebView;
        int count = [[webView stringByEvaluatingJavaScriptFromString:@"window.history.length"] intValue];
        return count ? : 1;
    }
    else
    {
        WKWebView *webView = self.realWebView;
        return webView.backForwardList.backList.count;
    }
}
- (void)goBackWithStep:(NSInteger)step
{
    if (!self.canGoBack) return;
    if (step) {
        NSInteger historyCount = [self countOfHistory];
        if (step >= historyCount)
            step = historyCount - 1;
        if (_usingUIWeb)
        {
            UIWebView* webView = self.realWebView;
            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.history.go(-%ld)", (long) step]];
        }
        else
        {
            WKWebView* webView = self.realWebView;
            WKBackForwardListItem* backItem = webView.backForwardList.backList[step];
            [webView goToBackForwardListItem:backItem];
        }
    }
    else
        [self goBack];
}
- (void)startProgress
{
    if (_progress < KInitialProgressValue) {
        [self setProgress:KInitialProgressValue];
    }
}
//  完成进度
- (void)completeProgress
{
    [self setProgress:1.0];
}
- (void)incrementProgress
{
    float progress = self.progress;
    float maxProgress = _interactive ? KFinalProgressValue : KInteractiveProgressValue;
    float remainPercent = (float)_loadingCount / (float)_maxLoadCount;
    float increment = (maxProgress - progress) * remainPercent;
    progress += increment;
    progress = fmin(progress, maxProgress);
    [self setProgress:progress];
}
#pragma mark - setter and getter -
-(UIScrollView *)scrollView
{
    return [(id)self.realWebView scrollView];
}
-(NSURLRequest *)currentRequest
{
    if(_usingUIWeb)
        return [(UIWebView*)self.realWebView request];
    else
        return _currentRequest;
}
-(NSURL *)URL
{
    if(_usingUIWeb)
        return [(UIWebView*)self.realWebView request].URL;
    else
        return [(WKWebView*)self.realWebView URL];
}
//  正在加载
- (BOOL)isLoading
{
    return [self.realWebView isLoading];
}
//  是否能返回
- (BOOL)canGoBack
{
    return [self.realWebView canGoBack];
}
//  是否能下一步
-(BOOL)canGoForward
{
    return [self.realWebView canGoForward];
}
- (void)setProgress:(float)progress
{
    // progress should be incremental only
    if (progress > _progress || progress == 0) {
        _progress = progress;
        [_progressView setProgress:progress animated:YES];
    }
}
-(void)setScalesPageToFit:(BOOL)scalesPageToFit
{
    if(_usingUIWeb)
    {
        UIWebView* webView = _realWebView;
        webView.scalesPageToFit = scalesPageToFit;
    }
    else
    {
        if(_scalesPageToFit == scalesPageToFit)
        {
            return;
        }
        
        WKWebView* webView = _realWebView;
        NSString *jScript = @"var meta = document.createElement('meta'); \
        meta.name = 'viewport'; \
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; \
        var head = document.getElementsByTagName('head')[0];\
        head.appendChild(meta);";
        
        if(scalesPageToFit)
        {
            WKUserScript *wkUScript = [[NSClassFromString(@"WKUserScript") alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
            [webView.configuration.userContentController addUserScript:wkUScript];
        }
        else
        {
            NSMutableArray* array = [NSMutableArray arrayWithArray:webView.configuration.userContentController.userScripts];
            for (WKUserScript *wkUScript in array)
            {
                if([wkUScript.source isEqual:jScript])
                {
                    [array removeObject:wkUScript];
                    break;
                }
            }
            for (WKUserScript *wkUScript in array)
            {
                [webView.configuration.userContentController addUserScript:wkUScript];
            }
        }
    }
    
    _scalesPageToFit = scalesPageToFit;
}
-(BOOL)scalesPageToFit
{
    if(_usingUIWeb)
    {
        return [_realWebView scalesPageToFit];
    }
    else
    {
        return _scalesPageToFit;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
