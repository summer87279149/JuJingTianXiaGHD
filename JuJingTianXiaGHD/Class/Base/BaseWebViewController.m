//
//  BaseWebViewController.m
//  JuJingTianXiaGHD
//
//  Created by Admin on 2017/6/21.
//  Copyright © 2017年 Summer. All rights reserved.
//
#import "BaseWebViewController.h"

@interface BaseWebViewController ()<WKUIDelegate/*,WKScriptMessageHandler*/,WKNavigationDelegate,UIScrollViewDelegate>
@end

@implementation BaseWebViewController
#pragma mark - initial methods
+(instancetype)sharedWithWebName:(NSString *)name{
    return [[self alloc]initWithWebName:name];
}
- (instancetype)initWithWebName:(NSString *)name{
    NSURL *url = [[NSBundle mainBundle]URLForResource:name withExtension:nil];
   return [self initWithWebViewFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20) localURL:url];
}
- (instancetype)initWithWebViewFrame:(CGRect)frame localURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        WebViewFrame = frame;
        localURL = url;
    }
    return self;
}
#pragma mark - setting
- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //实例化对象
    configuration.userContentController = [WKUserContentController new];

    //调用JS方法,下面代码是给html文件注入js代码：移动端html标签的id和网页版可能不一样。
    //注册过的方法在js文件中就可以向iOS发出消息,在WKScriptMessageHandler代理中接收到
//    [configuration.userContentController addScriptMessageHandler:self name:@"erweima"];
    
//    NSString *jsString = @"var script = document.createElement('script');script.type = 'text/javascript';script.text = function yourfunction(){var btn = document.getElementById('index-bn');btn.addEventListener('touchstart',function(){alert(1234)})}();document.getElementsByTagName('head')[0].appendChild(script);";
//    WKUserScript *UserScript = [[WKUserScript alloc]initWithSource:jsString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    [configuration.userContentController addUserScript:UserScript];
    
    WKPreferences *preferences = [WKPreferences new];
    configuration.preferences = preferences;
    self.webView = [[WKWebView alloc] initWithFrame:WebViewFrame configuration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:localURL];
    [self.webView loadRequest:request];
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.delegate = self;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
    
    UIView *placeholderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    placeholderView.backgroundColor = [UIColor jk_colorWithHexString:@"#008fcb"];
    [self.view addSubview:placeholderView];
}


#pragma mark - WKScriptMessageHandler
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

//这里是js中的方法传回来的参数
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
//{
//    NSLog(@"js中的方法传回来的参数body:%@",message.name);
//    if ([message.name isEqualToString:@"erweima"]) {
//    }
//}
-(void)unifiedPopVCWith:(NSString*)ScriptMessage{
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:ScriptMessage];
    self.webView.scrollView.delegate=nil;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc{
    NSLog(@"delloc root");
}

#pragma mark - WKNavigationDelegate

//这个是网页加载完成，导航的变化
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //    [JHUD hideForView:self.view];
    //NSLog(@"完成加载");
}

//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    //    NSLog(@"开始加载");
    
    //    [JHUD showAtView:self.view message:@"loading..." hudType:JHUDLoadingTypeGifImage];
}

//内容返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    //    NSLog(@"didCommitNavigation");
}

//重定向
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    //    NSLog(@"重定向");
}

// 内容加载失败时候调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    //    NSLog(@"页面加载超时");
    [JHUD hideForView:self.view];
    [JHUD showAtView:self.view message:@"loading..." hudType:JHUDLoadingTypeFailure];
}

//跳转失败的时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    //     NSLog(@"跳转失败");
}

//进度条
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
}



- (NSString*)getJsonWith:(NSDictionary*)dic {
    NSString *json = nil;
    
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
        
        if(!error) {
            
            json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        else {
            NSLog(@"JSON parse error: %@", error);
        }
    }
    else {
        NSLog(@"Not a valid JSON object: %@", dic);
    }
        return json;
    
}

















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
