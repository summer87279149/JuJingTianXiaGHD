//
//  BaseWebViewController.h
//  JuJingTianXiaGHD
//
//  Created by Admin on 2017/6/21.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController
{
    CGRect WebViewFrame;
    NSURL *localURL;
}
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic)   UIProgressView  *progressView;
- (instancetype)initWithWebViewFrame:(CGRect)frame localURL:(NSURL *)url;
@end
