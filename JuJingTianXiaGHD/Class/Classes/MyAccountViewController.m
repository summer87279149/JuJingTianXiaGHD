//
//  MyAccountViewController.m
//  JuJingTianXiaGHD
//
//  Created by Admin on 2017/6/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "MyAccountViewController.h"

@interface MyAccountViewController ()<WKScriptMessageHandler>
@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"popvc"];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [self unifiedPopVCWith:@"popvc"];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
